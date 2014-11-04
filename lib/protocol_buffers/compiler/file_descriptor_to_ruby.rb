require 'protocol_buffers/compiler/descriptor.pb'
require 'stringio'

class FileDescriptorToRuby < Struct.new(:descriptor)

  include Google::Protobuf::FieldDescriptorProto::Type
  include Google::Protobuf::FieldDescriptorProto::Label

  def initialize(descriptor)
    super
    @package_modules = descriptor.package ? descriptor.package.split('.') : []
    @ns = []
  end

  def write(io)
    @io = io

    @io.write <<HEADER
#!/usr/bin/env ruby
# Generated by the protocol buffer compiler. DO NOT EDIT!

require 'protocol_buffers'

HEADER

    # descriptor.dependency.each do |dep|
    #   dir      = File.dirname(dep)
    #   filename = File.basename(dep, ".proto") + ".pb"
    #   path = if dir == '.'
    #     filename
    #   else
    #     File.join(dir, filename)
    #   end
    #   @io.write("begin; require '#{path}'; rescue LoadError; end\n")
    # end
    # @io.write("\n") unless descriptor.dependency.empty?

    in_namespace("module", @package_modules) do
      declare(descriptor.package, descriptor.message_type, descriptor.enum_type)

      descriptor.message_type.each do |message|
        dump_message(descriptor.package, message)
      end

      descriptor.service.each do |service|
        dump_service(descriptor.package, service)
      end
    end
    
  end

  protected

  def declare(package, messages, enums)
    return if messages.empty? && enums.empty?

    line %{# forward declarations}
    messages.each do |message|
      line %{class #{name([@package_modules, message.name].flatten)}; include ProtocolBuffers::Message; clear_fields!; end}
    end

    if enums.empty?
      line
    else
      line
      line %{# enums}
      enums.each do |enum|
        dump_enum(package, enum)
      end
    end
  end

  def line(str = nil)
    if str
      @ns.size.times { @io.write("  ") }
      @io.write(str)
    end
    @io.write("\n")
  end
  
  def in_namespace(type, namespace, rest = "")
    
    namespace_array = [namespace].flatten
    
    namespace_array.each do |n|
      line "#{type} #{camelize(n)}#{rest}"
      @ns.push n
    end
    yield
    namespace_array.each do |n|
      @ns.pop
      line "end"
    end
  end

  def name(parts)
    ns = @ns.dup
    (parts.shift; ns.shift) while !parts.empty? && parts.first == ns.first
    parts.map { |p| camelize(p) }.join("::")
  end

  LABEL_MAPPING = {
    LABEL_OPTIONAL => "optional",
    LABEL_REQUIRED => "required",
    LABEL_REPEATED => "repeated",
  }

  TYPE_MAPPING = {
    TYPE_DOUBLE => ":double",
    TYPE_FLOAT => ":float",
    TYPE_INT64 => ":int64",
    TYPE_UINT64 => ":uint64",
    TYPE_INT32 => ":int32",
    TYPE_FIXED64 => ":fixed64",
    TYPE_FIXED32 => ":fixed32",
    TYPE_BOOL => ":bool",
    TYPE_STRING => ":string",
    TYPE_BYTES => ":bytes",
    TYPE_UINT32 => ":uint32",
    TYPE_SFIXED32 => ":sfixed32",
    TYPE_SFIXED64 => ":sfixed64",
    TYPE_SINT32 => ":sint32",
    TYPE_SINT64 => ":sint64",
  }

  def dump_message(package, message)
    in_namespace("class", message.name, "") do
      fully_qualified_name = fully_qualified_name(package, message.name)
      declare(fully_qualified_name, message.nested_type, message.enum_type)

      line %{# nested messages} unless message.nested_type.empty?
      message.nested_type.each { |inner| dump_message(fully_qualified_name, inner) }

      message.field.each do |field|
        typename = field_typename(field)
        fieldline = %{#{LABEL_MAPPING[field.label]} #{typename}, :#{field.name}, #{field.number}}
        if field.type == TYPE_GROUP
          fieldline << %{, :group => true}
        end
        if field.default_value && field.default_value != ""
          fieldline << %{, :default => #{default_value(field)}}
        end

        # Dont need to check for 'repeated' attribute or type, protoc will take care of this.
        if field.options.packed
          fieldline << %{, :packed => true }
        end

        if field.options.entity && field.options.entity.size > 0
          fieldline << %{, :entity => "#{ service_typename(field.options.entity) }" }
        end

        line fieldline
      end
    end
    line
  end

  def dump_enum(package, enum)
    in_namespace("module", enum.name) do
      line %{include ::ProtocolBuffers::Enum}
      
      enum.value.each do |value|
        line %{#{capfirst(value.name)} = #{value.number}}
      end
    end
    line
  end

  def dump_service(package, service)
    in_namespace("class", service.name, "") do
      line %{include ProtocolBuffers::Service}
      line %{clear_rpcs!}

      fully_qualified_name = fully_qualified_name(package, service.name)
      
      line %{properties #{ service.options.properties_message }}

      service.method.each do |method|
        line %{#{ method.options.clientside ? :client_rpc : :rpc } :#{underscore(method.name)}, "#{method.name}", #{service_typename(method.input_type)}, #{service_typename(method.output_type)}}
      end
    end
  end

  def field_typename(field)
    TYPE_MAPPING[field.type] || service_typename(field.type_name)
  end

  def service_typename(type_name)
    type_name.split(".").map { |t| camelize(t) }.join("::")
  end

  # TODO: this probably doesn't work for all default values, expand
  def default_value(field)
    case field.type
    when TYPE_STRING, TYPE_BYTES
      %{"#{field.default_value}"}
    when TYPE_BOOL
      field.default_value
    when TYPE_ENUM
      typename = field_typename(field)
      %{#{typename}::#{field.default_value}}
    else
      field.default_value
    end
  end

  def fully_qualified_name(package, name)
    package == nil || package.empty? ? name : "#{package}.#{name}"
  end

  def capfirst(s)
    "#{s[0,1].capitalize}#{s[1..-1]}" if s
  end
  
  def camelize(lower_case_and_underscored_word)
    lower_case_and_underscored_word.to_s.gsub(/(?:^|_)(.)/) { $1.upcase }
  end

  def underscore(camelized_word)
    word = camelized_word.to_s.dup
    word.gsub!(/::/, '/')
    word.gsub!(/(?:([A-Za-z\d])|^)((?=\a)\b)(?=\b|[^a-z])/) { "#{$1}#{$1 && '_'}#{$2.downcase}" }
    word.gsub!(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
    word.tr!("-", "_")
    word.downcase!
    word
  end

end

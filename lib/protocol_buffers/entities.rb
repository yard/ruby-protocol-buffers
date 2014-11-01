module ProtocolBuffers
  
  #  Pre-processes entities definition file.
  #
  class Entities

    class << self

      BUILT_IN_TYPES = %w(double float int64 uint64 int32 fixed64 fixed32 bool string bytes uint32 sfixed32 sfixed64 sint32 sint64)

      #  Reads the file supplied and returns Tempfile
      #  which holds the processed response.
      #
      def protobuferize(input_filename)
        #  read the contents of the file
        contents = File.open(input_filename, "rb").read.lines


        #  prepare output array
        output = []
        #  container for requests and responses
        request_response_messages = []
        #  container for property messages
        property_messages = []
        #  current service
        entity = nil

        request_response_messages << property_messages

        contents.each do |line|
          case line 
            when /^\s*package/ then begin
              output << line
              output << 'import "phoenix.proto";'
            end

            when /^\s*entity/ then begin
              entity = line.match(/\s*entity\s*([^\s\{}]+)\s*\{/)[1]

              property_messages << [entity, []]

              output << request_response_messages
              output << convert_entity_definition(line)
            end

            when /^\s*property/ then begin
              raise "Encountered property not being within and entity {} block!" if entity.blank?
              property_messages.last.last << line
            end

            when /^\s*client/ then begin
              output << convert_client_api_definition(line, request_response_messages, entity)
            end

            when /^\s*server/ then begin
              output << convert_server_api_definition(line, request_response_messages, entity)
            end
          else
            output << line
          end
        end

        property_messages.replace( convert_property_lines_into_messages(property_messages) )

        output = output.flatten.join("\n")

        convert_entity_fields_to_mailboxes(output)
      end

    protected

      #  Converts message fields which refer to entities (aka services) so that
      #  they are represented as mailboxes.
      def convert_entity_fields_to_mailboxes(output)
        output.gsub(/(required|optional|repeated)\s*(entities\.[^\s]+)([^\;]+)\;/, '\1 phoenix.messages.Mailbox \3 [ (phoenix.messages.entity) = \'\2\' ];')
      end

      #  Converts entity definition into a protobuf service defintion.
      def convert_entity_definition(line)
        line.gsub("entity", "service") + "\n  option (phoenix.messages.properties_message) = \"#{ line.match(/\s*entity\s*([^\s\{}]+)\s*\{/)[1] }PropertiesMessage\";\n\n"
      end

      #
      def convert_property_lines_into_messages(property_messages)
        property_messages.map do |entry|
          entity_name = entry.first
          props = entry.last

          result = "message #{entity_name}PropertiesMessage {\n"

          result += props.map.with_index do |definition, index|
            definition.gsub("property", "optional").gsub(";", " = #{index + 1};")
          end.join("\n")

          result + "\n}\n\n"
        end
      end

      #  Converts client api definition into RPC definition.
      def convert_client_api_definition(line, messages, entity)
        match = line.match(/(\s*)client\s*([^\s]+)\s*\(([^\)]*)\)\s*;/)

        name = match[2]
        args = match[3].strip

        messages << "message Client#{entity}#{ name }RequestMessage { #{ args.split(",").map.with_index { |ad, i| "required " + ad + " = #{i + 1};" }.join(' ') } }"
        match[1] + "rpc #{ name } (Client#{entity}#{ name }RequestMessage) returns (phoenix.messages.Void) { option (phoenix.messages.clientside) = true; };"
      end

      #  Converts server api definition into RPC definition.
      def convert_server_api_definition(line, messages, entity)
        match = line.match(/(\s*)server\s*([^\s]+)\s*\(([^\)]*)\)\s*returns\s*([^;]*);/)

        name = match[2]
        args = match[3].strip
        result = match[4].strip

        messages << "message Server#{entity}#{ name }RequestMessage { #{ args.split(",").map.with_index { |ad, i| "required " + ad + " = #{i + 1};" }.join(' ') } }"

        if result != ""
          messages << "message Server#{entity}#{ name }ResponseMessage { required #{result} value = 1; }"
          match[1] + "rpc #{ name } (Server#{entity}#{ name }RequestMessage) returns (Server#{entity}#{ name }ResponseMessage);"
        else
          match[1] + "rpc #{ name } (Server#{entity}#{ name }RequestMessage) returns (phoenix.messages.Void);"
        end
      end

    end

  end

end
# -*- encoding: utf-8 -*-
# stub: ruby-protocol-buffers 1.6.0 ruby lib

Gem::Specification.new do |s|
  s.name = "ruby-protocol-buffers"
  s.version = "1.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Brian Palmer", "Benedikt B\xC3\xB6hm", "Rob Marable", "Paulo Luis Franchini Casaretto"]
  s.date = "2014-11-04"
  s.email = ["brian@codekitchen.net", "bb@xnull.de"]
  s.executables = ["common.xslt", "csharp-protoc", "csharp.xslt", "descriptor.proto", "phoenix.proto", "protobuf-net.dll", "protoc-gen-ruby", "protogen.exe", "ruby-protoc", "xml.xslt"]
  s.extra_rdoc_files = ["Changelog.md"]
  s.files = [".document", ".gitignore", ".travis.yml", "CHANGELOG.md", "Changelog.md", "Gemfile", "Gemfile.no_varint", "LICENSE", "README.md", "Rakefile", "bin/common.xslt", "bin/csharp-protoc", "bin/csharp.xslt", "bin/descriptor.proto", "bin/phoenix.proto", "bin/protobuf-net.dll", "bin/protoc-gen-ruby", "bin/protogen.exe", "bin/ruby-protoc", "bin/xml.xslt", "debian/changelog", "debian/compatability", "debian/control", "debian/libprotobuf-ruby1.8.install", "debian/protocol_buffers.rb", "debian/rules", "examples/json_protobuf.rb", "lib/protocol_buffers.rb", "lib/protocol_buffers/compiler.rb", "lib/protocol_buffers/compiler/descriptor.pb.rb", "lib/protocol_buffers/compiler/descriptor.proto", "lib/protocol_buffers/compiler/file_descriptor_to_d.rb", "lib/protocol_buffers/compiler/file_descriptor_to_ruby.rb", "lib/protocol_buffers/compiler/plugin.pb.rb", "lib/protocol_buffers/compiler/plugin.proto", "lib/protocol_buffers/entities.rb", "lib/protocol_buffers/limited_io.rb", "lib/protocol_buffers/runtime/decoder.rb", "lib/protocol_buffers/runtime/encoder.rb", "lib/protocol_buffers/runtime/enum.rb", "lib/protocol_buffers/runtime/extend.rb", "lib/protocol_buffers/runtime/field.rb", "lib/protocol_buffers/runtime/message.rb", "lib/protocol_buffers/runtime/rpc.rb", "lib/protocol_buffers/runtime/service.rb", "lib/protocol_buffers/runtime/text_formatter.rb", "lib/protocol_buffers/runtime/text_parser.rb", "lib/protocol_buffers/runtime/text_parser.ry", "lib/protocol_buffers/runtime/text_scanner.rb", "lib/protocol_buffers/runtime/varint.rb", "lib/protocol_buffers/version.rb", "ruby-protocol-buffers.gemspec", "spec/compiler_spec.rb", "spec/fields_spec.rb", "spec/message_spec.rb", "spec/negative_int32_spec.rb", "spec/nil_bugs_spec.rb", "spec/proto_files/depends.proto", "spec/proto_files/dotted_package.proto", "spec/proto_files/enums.pb.rb", "spec/proto_files/enums.proto", "spec/proto_files/featureful.pb.rb", "spec/proto_files/featureful.proto", "spec/proto_files/nested/child.proto", "spec/proto_files/no_package.pb.rb", "spec/proto_files/no_package.proto", "spec/proto_files/packed.pb.rb", "spec/proto_files/packed.proto", "spec/proto_files/services.pb.rb", "spec/proto_files/services.proto", "spec/proto_files/simple.pb.rb", "spec/proto_files/simple.proto", "spec/proto_files/top_level_enum.proto", "spec/proto_files/under_score_package.proto", "spec/runtime_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "spec/text_format_spec.rb", "spec/unicode_string_spec.rb", "tasks/rspec.rake", "tasks/yard.rake"]
  s.homepage = "https://github.com/codekitchen/ruby-protocol-buffers"
  s.licenses = ["BSD"]
  s.rubygems_version = "2.2.2"
  s.summary = "Ruby compiler and runtime for the google protocol buffers library."
  s.test_files = ["spec/compiler_spec.rb", "spec/fields_spec.rb", "spec/message_spec.rb", "spec/negative_int32_spec.rb", "spec/nil_bugs_spec.rb", "spec/proto_files/depends.proto", "spec/proto_files/dotted_package.proto", "spec/proto_files/enums.pb.rb", "spec/proto_files/enums.proto", "spec/proto_files/featureful.pb.rb", "spec/proto_files/featureful.proto", "spec/proto_files/nested/child.proto", "spec/proto_files/no_package.pb.rb", "spec/proto_files/no_package.proto", "spec/proto_files/packed.pb.rb", "spec/proto_files/packed.proto", "spec/proto_files/services.pb.rb", "spec/proto_files/services.proto", "spec/proto_files/simple.pb.rb", "spec/proto_files/simple.proto", "spec/proto_files/top_level_enum.proto", "spec/proto_files/under_score_package.proto", "spec/runtime_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "spec/text_format_spec.rb", "spec/unicode_string_spec.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<autotest-standalone>, [">= 0"])
      s.add_development_dependency(%q<autotest-growl>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rake-compiler>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.14"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<racc>, ["~> 1.4.12"])
    else
      s.add_dependency(%q<autotest-standalone>, [">= 0"])
      s.add_dependency(%q<autotest-growl>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rake-compiler>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.14"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<racc>, ["~> 1.4.12"])
    end
  else
    s.add_dependency(%q<autotest-standalone>, [">= 0"])
    s.add_dependency(%q<autotest-growl>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rake-compiler>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.14"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<racc>, ["~> 1.4.12"])
  end
end

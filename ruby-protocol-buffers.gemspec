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
  s.executables = []
  s.extra_rdoc_files = ["Changelog.md"]
  s.files = `git ls-files -z`.split("\x0")
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

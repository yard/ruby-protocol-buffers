require 'protocol_buffers/compiler'
require 'protocol_buffers/entities'
require 'protocol_buffers/compiler/file_descriptor_to_ruby'
require 'fileutils'

module ProtocolBuffers

  class Processors

    class << self

      #  Returns path to mono binary
      #
      def mono_binary
        @mono_binary ||= (`which mono`.empty? ? "PATH=$PATH:/Applications/Unity/MonoDevelop.app/Contents/Frameworks/Mono.framework/Commands mono" : "mono")
      end

      #  Returns path to mcs binary
      #
      def mcs_binary
        @mcs_binary ||= (`which mono`.empty? ? "PATH=$PATH:/Applications/Unity/MonoDevelop.app/Contents/Frameworks/Mono.framework/Commands mcs" : "mcs")
      end

      #  Returns path to the c# generator.
      #
      def csharp_generator
        @csharp_generator ||= "#{ mono_binary } #{ File.expand_path( File.join(__FILE__, "..", "..", "..", "vendor", "generators", "csharp", "protogen.exe") ) }"
      end

      #  Returns path to the c# precompiler.
      #  
      def csharp_precompiler
        @csharp_precompiler ||= "#{ mono_binary } #{ File.expand_path( File.join(__FILE__, "..", "..", "..", "vendor", "precompilers", "csharp", "precompile.exe") ) }"
      end

      #  Returns path to a folder with ext proto files.
      #
      def proto_folder
        @proto_folder ||= File.expand_path( File.join(__FILE__, "..", "..", "..", "vendor", "proto") )
      end

      #  Returns path to a-bot stubs.
      #
      def abot_stubs
        @abot_stubs ||= File.expand_path( File.join(__FILE__, "..", "..", "..", "vendor", "support", "AbotStubs.cs") )
      end

      #  Returns path to a-bot stubs.
      #
      def abot_protobuf_net_dll
        @abot_protobuf_net_dll ||= File.expand_path( File.join(__FILE__, "..", "..", "..", "vendor", "support", "protobuf-net.dll") )
      end

      #  Processes the config and yields C# code.
      #
      def csharp(root, config, requirements)
        config.each do |filename, out_path|
          protocfile = Tempfile.new("csharp-protoc")
          proto_file_name = protocfile.path

          run "protoc -I#{ root.to_s } -I#{ File.dirname(filename) } -I#{ proto_folder } -o#{ proto_file_name } #{ filename }"
          if $?.exitstatus != 0
            puts "\nprotoc failed on #{ filename } :("
            exit 1
          end

          run "#{ csharp_generator } -i:#{ proto_file_name } -o:#{ out_path } -p:fixCase -p:abotRpc#{ requirements ? " -p:abotRpcRequirement" : "" }"
          if $?.exitstatus != 0
            puts "\nprotogen.exe failed #{ filename } :("
            exit 1
          end

          protocfile.close(true)
        end
      end

      #  Processes the config and yields Ruby code.
      #
      def ruby(root, config)
        config.each do |proto, path|
          include_dirs = [ proto_folder.to_s, root.to_s ]

          protocfile = Tempfile.new("ruby-protoc").tap(&:binmode)
          
          ProtocolBuffers::Compiler.compile(protocfile.path, File.join(root, proto), :include_dirs => include_dirs)
          descriptor_set = Google::Protobuf::FileDescriptorSet.parse(protocfile)
          
          protocfile.close(true)
          
          File.open(path, "wb") do |file|
            dumper = FileDescriptorToRuby.new(descriptor_set.file.first)
            dumper.write(file)
          end
        end
      end

      #  Prepares C# serializer class, which statically (de)serializes messages.
      #
      def csharp_serializer(folder)
        run "cd #{folder} && #{ mcs_binary } #{ abot_stubs } `find #{ File.expand_path(folder) } -name \"*.cs\"` -reference:#{ abot_protobuf_net_dll } -out:#{ File.expand_path( File.join(folder, "TypesAssembly.dll") ) }"
        if $?.exitstatus != 0
          puts "\nmcs.exe failed :("
          exit 1
        end

        run "cd #{folder} && cp #{ abot_protobuf_net_dll } ."

        run "cd #{folder} && #{ csharp_precompiler } -o:#{ File.expand_path( File.join(folder, "DiscardMeAndNeverMind.dll") ) } -t:Abot.Serializer TypesAssembly.dll"
        if $?.exitstatus != 0
          puts "\precompile.exe failed :("
          exit 1
        end
      end

      #  Runs the command.
      #
      def run(command)
        `#{command}`
      end

    end

  end

end
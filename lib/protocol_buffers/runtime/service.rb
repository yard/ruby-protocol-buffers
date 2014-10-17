require 'protocol_buffers/runtime/rpc'

module ProtocolBuffers
  module Service
    module ClassMethods
      
      def set_fully_qualified_name(name)
        @fully_qualified_name = name.dup.freeze
      end

      def fully_qualified_name
        @fully_qualified_name
      end

      def rpcs
        @rpcs
      end

      def client_rpcs
        @client_rpcs
      end

      def rpc(name, proto_name, request_type, response_type)
        @rpcs ||= Array.new
        @rpcs = @rpcs.dup
        @rpcs << Rpc.new(name.to_sym, proto_name, request_type, response_type, self).freeze
        @rpcs.freeze
      end

      def client_rpc(name, proto_name, request_type, response_type)
        @client_rpcs ||= Array.new
        @client_rpcs = @client_rpcs.dup
        @client_rpcs << Rpc.new(name.to_sym, proto_name, request_type, response_type, self).freeze
        @client_rpcs.freeze
      end

    end

    #  Mix class methods in.
    #
    def self.included(base)
      base.send :extend, ClassMethods
    end

  end
end

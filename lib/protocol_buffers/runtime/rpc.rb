module ProtocolBuffers
  class Rpc
    attr_reader :name, :proto_name, :request_class, :response_class

    def initialize(name, proto_name, request_class, response_class)
      @name = name
      @proto_name = proto_name.dup.freeze
      @request_class = request_class
      @response_class = response_class
    end

    def to_s
      @hash ||= {
        :name => name,
        :proto_name => proto_name,
        :request_class => request_class,
        :response_class => response_class
      }.freeze
      @hash.to_s
    end
  end
end

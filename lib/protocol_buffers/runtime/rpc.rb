module ProtocolBuffers
  class Rpc
    attr_reader :name, :proto_name, :request_class, :response_class

    def initialize(name, proto_name, request_class, response_class)
      @name = name
      @proto_name = proto_name.dup.freeze
      @request_class = request_class
      @response_class = response_class
      @hash = {
        :name => name,
        :proto_name => proto_name,
        :request_class => request_class,
        :response_class => response_class
      }.freeze
    end

    def to_s
      @hash.to_s
    end
  end
end

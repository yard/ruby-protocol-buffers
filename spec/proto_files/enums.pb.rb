#!/usr/bin/env ruby
# Generated by the protocol buffer compiler. DO NOT EDIT!

require 'protocol_buffers'

module Enums
  # forward declarations
  class FooMessage
    include ProtocolBuffers::Message
  end

  # enums
  module FooEnum
    include ::ProtocolBuffers::Enum

    set_fully_qualified_name "enums.FooEnum"

    ONE = 1
    TWO = 2
    THREE = 3
  end

  module BarEnum
    include ::ProtocolBuffers::Enum

    # purposefully removing qualified name to make sure that nothing breaks
    #set_fully_qualified_name "enums.BarEnum"

    FOUR = 4
    FIVE = 5
    SIX = 6
  end

  class FooMessage
    include ProtocolBuffers::Message

    # forward declarations

    # enums
    module NestedFooEnum
      include ::ProtocolBuffers::Enum

      set_fully_qualified_name "enums.FooMessage.NestedFooEnum"

      SEVEN = 7
      EIGHT = 8
    end

    module NestedBarEnum
      include ::ProtocolBuffers::Enum

      # purposefully removing qualified name to make sure that nothing breaks
      #set_fully_qualified_name "enums.FooMessage.NestedBarEnum"

      NINE = 9
      TEN = 10
    end

    set_fully_qualified_name "enums.FooMessage"

    optional ::Enums::FooMessage::NestedFooEnum, :nested_foo_enum, 1
    optional ::Enums::FooMessage::NestedBarEnum, :nested_bar_enum, 2
  end

end

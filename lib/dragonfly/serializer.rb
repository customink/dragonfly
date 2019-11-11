# encoding: utf-8
require 'base64'

module Dragonfly
  module Serializer
    
    # Exceptions
    class BadString < RuntimeError; end
    
    extend self # So we can do Serializer.b64_encode, etc.
    
    def b64_encode(string)
      Base64.urlsafe_encode64(string)
    end
    
    def b64_decode(string)
      Base64.urlsafe_decode64(string)
    end
    
    def marshal_encode(object)
      b64_encode(Marshal.dump(object))
    end
    
    def marshal_decode(string)
      Marshal.load(b64_decode(string))
    rescue TypeError, ArgumentError => e
      raise BadString, "couldn't decode #{string} - got #{e}"
    end
    
  end
end

module Bytepack
  class Hash < Complex
    
    class << self
      def pack(hash = {})
        AnyType.pack(hash.keys) + AnyType.pack(hash.values)
      end
    
      def unpack(bytes, offset = 0)
        keys, offset = *AnyType.unpack(bytes, offset)
        values, offset = *AnyType.unpack(bytes, offset)
        [::Hash[keys.map.with_index {|key, index| [key, values[index]]}], offset]
      end
    end
    
  end
end
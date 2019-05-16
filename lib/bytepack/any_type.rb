module Bytepack
  class AnyType < Struct
    
    class << self
      def pack(val)
        dataType = packingDataType(val)
        TypeInfo.pack(dataType) + dataType.pack(val)
      end
    
      def unpack(bytes, offset = 0)
        dataType, offset = *TypeInfo.unpack(bytes, offset)
        if dataType.nil?
          [nil, offset]
        else
          dataType.unpack(bytes, offset)
        end
      end
    end
    
  end
end
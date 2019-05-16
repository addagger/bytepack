module Bytepack
  class SingleTypeArray < Compound
    LENGTH_TYPE = AnyType
    
    class << self
      def pack(val = []) # First element is a data type indicator (Integer, Struct, String/Symbol)
        array = val[1..-1]
        dataType = classifyDataType(val[0])
        unless dataType  # No indicator recognized
          array = val
          dataType = autodetect_dataType(array)
        end
        TypeInfo.pack(dataType) + self::LENGTH_TYPE.pack(array.size) + array.map {|e| dataType.pack(e)}.join
      end

      def unpack(bytes, offset = 0)
        dataType, offset = *TypeInfo.unpack(bytes, offset)
        if dataType.nil?
          array = nil
        else
          array_size, offset = *self::LENGTH_TYPE.unpack(bytes, offset)
          array = array_size.times.map do
            element, offset = *dataType.unpack(bytes, offset)
            element
          end
        end
        [array, offset]
      end

      def autodetect_dataType(array)
        if array[0].is_a?(::Integer)
          max_int = array.select {|e| e.is_a?(::Integer)}.max
          packingDataType(max_int)
        else
          packingDataType(array[0])
        end
      end
    end
    
  end
end
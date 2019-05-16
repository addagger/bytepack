module Bytepack
  
  class Struct
    class << self
      def config(const, value)
        begin
          remove_const(const) if const_defined?(const)
        rescue NameError
        end
        const_set(const, value)
      end

      def packingDataType(val) # Ruby data type conversion
        case val
        when ::Array then single_type_array?(val) ? SingleTypeArray : Array
        when ::Hash then Hash
        when ::NilClass then Null # Byte::NULL_INDICATOR
        when ::Integer then
          case val.bit_length
          when (0..7) then Byte
          when (8..15) then Short
          when (16..31) then Integer
          else
            Long if val.bit_length >= 32
          end
        when ::Float then Float
        when ::String then
          val.encoding.name == "UTF-8" ? String : Varbinary # See "sometext".encoding
        when ::Symbol then Symbol
        when ::Time then Timestamp
        when ::BigDecimal then Decimal
        else # CustomData
          CustomData.struct_by_ruby_type(val)
        end
      end
  
      def single_type_array?(array)
        first_type = array[0].class
        begin
          array.each {|e| raise(Exception) unless e.is_a?(first_type)}
        rescue Exception
          false
        else
          true
        end
      end
  
      def classifyDataType(val)
        case val
        when Class then val if val < Struct
        when ::String, ::Symbol then
          begin
            Bytepack.const_get("#{val}")
          rescue
            nil
          end
        end
      end
    
      def testpacking(val)
        unpack(pack(val))
      end
    
    end
  end
  
end

require 'bytepack/any_type'
require 'bytepack/basic'
require 'bytepack/complex'
require 'bytepack/compound'
require 'bytepack/custom_data'
require 'bytepack/extensions'
require 'bytepack/type_info'
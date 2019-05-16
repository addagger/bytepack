module Bytepack
  class TypeInfo < Byte
    extend Extensions::CodeValuesHash
      
    hash_codes [-99, Array], # ARRAY
               [-98, SingleTypeArray], # SingleTypeArray
               [-89, Hash], # Hash
               [1, Null], # NULL
               [3, Byte], # TINYINT
               [4, Short], # SMALLINT
               [5, Integer], # INTEGER
               [6, Long], # BIGINT
               [8, Float], # FLOAT
               [9, String], # STRING
               [10, Symbol], # Symbol
               [11, Timestamp], # TIMESTAMP
               [22, Decimal], # DECIMAL
               [25, Varbinary] # VARBINARY
    
    class << self
      def pack(val)
        val = val.is_a?(::Integer) ? val : code_values[val]||CustomData.code_by_struct(val)
        super(val)
      end
      
      def unpack(bytes, offset = 0)
        unpacked = super(bytes, offset)
        unpacked[0] = codes[unpacked[0]]||CustomData.struct_by_code(unpacked[0]) if unpacked[0]
        unpacked
      end
    end
    
  end
end
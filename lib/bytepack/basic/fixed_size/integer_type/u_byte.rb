module Bytepack
  class UByte < IntegerType # Unsigned
    DIRECTIVE = 'C'
    LENGTH = 1
    NULL_INDICATOR = 0 # NULL indicator for object type serializations
  end
end
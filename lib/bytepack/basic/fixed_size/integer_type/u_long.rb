module Bytepack
  class ULong < IntegerType # Unsigned
    DIRECTIVE = 'Q>'
    LENGTH = 8
    NULL_INDICATOR = 0 # NULL indicator for object type serializations
  end
end
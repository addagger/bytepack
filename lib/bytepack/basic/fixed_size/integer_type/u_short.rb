module Bytepack
  class UShort < IntegerType # Unsigned
    DIRECTIVE = 'S>'
    LENGTH = 2
    NULL_INDICATOR = 0 # NULL indicator for object type serializations
  end
end
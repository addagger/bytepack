module Bytepack
  class UInteger < IntegerType # Unsigned
    DIRECTIVE = 'L>'
    LENGTH = 4
    NULL_INDICATOR = 0 # NULL indicator for object type serializations
  end
end
module Bytepack
  class Byte < IntegerType
    DIRECTIVE = 'c'
    LENGTH = 1
    NULL_INDICATOR = -128 # NULL indicator for object type serializations
  end
end
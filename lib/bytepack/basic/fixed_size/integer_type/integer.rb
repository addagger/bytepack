module Bytepack
  class Integer < IntegerType
    DIRECTIVE = 'l>'
    LENGTH = 4
    NULL_INDICATOR = -2147483648 # NULL indicator for object type serializations
  end
end
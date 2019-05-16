module Bytepack
  class Short < IntegerType
    DIRECTIVE = 's>'
    LENGTH = 2
    NULL_INDICATOR = -32768 # NULL indicator for object type serializations
  end
end
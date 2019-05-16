module Bytepack
  class Float < FixedSize
    DIRECTIVE = 'G'
    LENGTH = 8
    NULL_INDICATOR = -1.7E308 # NULL indicator for object type serializations
  end
end
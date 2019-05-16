module Bytepack
  class Null < Byte
    
    class << self
      def pack(*)
        super(Byte::NULL_INDICATOR)
      end
    end
    
  end
end
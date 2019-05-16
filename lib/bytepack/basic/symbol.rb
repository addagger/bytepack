module Bytepack
  class Symbol < Varbinary
    
    class << self
      def unpack(bytes, offset = 0)
        vb = super(bytes, offset)
        vb[0] = vb[0].to_sym unless vb[0].nil?
        vb
      end
    end
  
  end
end
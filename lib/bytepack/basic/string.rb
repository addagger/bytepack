module Bytepack
  class String < Varbinary

    class << self
      def unpack(bytes, offset = 0)
        vb = super(bytes, offset)
        vb[0] = vb[0].force_encoding("utf-8") unless vb[0].nil?
        vb
      end
    
      def convert_input(val)
        val.to_s.encode("utf-8")
      end
    end
  
  end
end
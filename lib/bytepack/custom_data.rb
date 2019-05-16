module Bytepack
  class CustomData < Struct
    
    @subclasses = []
    
    class << self
      def inherited(child)
        @subclasses << child
      end
            
      def subclasses(&block)
        selected = nil
        @subclasses.each do |child| # .find() is too slow
          if yield(child)
            selected = child
            break
          end
        end
        selected if block_given?
      end
      
      def struct_by_ruby_type(val)
        subclasses {|child| val.is_a?(child::RUBY_TYPE)}
      end
      
      def code_by_struct(struct)
        struct::TYPE_CODE if struct < Struct
      end
      
      def struct_by_code(code)
        subclasses {|child| child::TYPE_CODE == code}
      end
    end
    
  end
  
end
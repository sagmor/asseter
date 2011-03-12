module Asseter
  module Builder
    class Base
      def initialize(options = {})
        @options = options
      end
      
      def build(bundle, path = nil)
        buffer = collapse( files(bundle,path) )
        buffer = minify(buffer) if false
        buffer
      end
      
      protected
        def collapse(files)
          files.inject('') do |buffer, file|
            buffer << compile(file) << "\n"
          end << "\n"
        end
    end
    
    class UnknownFileTypeError < StandardError; end
  end
end
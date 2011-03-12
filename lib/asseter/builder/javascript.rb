module Asseter
  module Builder
    class Javascript < Base
      protected
        def compile(file)
          data = File.read(file)
          
          case File.extname(file)
          when '.js'     then data
          when '.coffee' then compile_coffee(data)
          else raise UnknownFileTypeError
          end
        end
        
        def files(bundle, path = nil)
          path = '**/*' if path.nil? || path.empty?
          
          Dir["app/javascripts/#{bundle}/#{path}.{js,coffee}"]
        end
        
        def compile_coffee(data)
          raise CoffeeScriptNotLoadedError unless defined? CoffeeScript
          
          CoffeeScript.compile data
        end
    end
    
    class CoffeeScriptNotLoadedError < StandardError; end
  end
end
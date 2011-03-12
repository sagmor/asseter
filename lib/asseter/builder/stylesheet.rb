module Asseter
  module Builder
    class Stylesheet < Base
      protected
        def compile(file)
          data = File.read(file)
          
          case File.extname(file)
          when '.css'  then data
          when '.scss' then compile_sass(data)
          when '.sass' then compile_scss(data)
          when '.less' then compile_less(data)
          else raise UnknownFileTypeError
          end
        end
        
        def files(bundle, path = nil)
          path = '**/*' if path.nil? || path.empty?
          
          Dir["app/stylesheets/#{bundle}/#{path}.{css,scss,sass,less}"]
        end
        
        def compile_less(data)
          raise LessNotLoadedError unless defined? Less
          Less::Engine.new(data).to_css
        end

        def compile_sass(data)
          raise SassNotLoadedError unless defined? Sass
          Sass::Engine.new(data, :syntax => :sass).render
        end

        def compile_scss(data)
          raise SassNotLoadedError unless defined? Sass
          Sass::Engine.new(data, :syntax => :sass).render
        end
    end
    
    class SassNotLoadedError < StandardError; end
    class LessNotLoadedError < StandardError; end
  end
end
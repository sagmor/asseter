module Asseter
  class Middleware
    JAVASCRIPTS_CHECK = /^\/javascripts\/(\w+)((\/\w+)*).js/
    STYLESHEETS_CHECK = /^\/stylesheets\/(\w+)((\/\w+)*).css/
    
    def initialize(app,config = {})
      @app = app
      @config = config
    end
    
    def call(env)
      case env["PATH_INFO"]
      when JAVASCRIPTS_CHECK then javascript($1,$2)
      when STYLESHEETS_CHECK then stylesheet($1,$2)
      else @app.call(env)
      end
    rescue Asseter::FileNotFoundError
      [404,{},'']
    end
    
    protected
      def javascript(bundle,file)
        return [403, {"Content-Type" => "text/plain"}, ["Forbidden\n"]] if file.include?('..')

        body = javascript_builder.build(bundle,file)
        [200, headers('javascript'), [body]]
      end
      
      def stylesheet(bundle,file)
        return [403, {"Content-Type" => "text/plain"}, ["Forbidden\n"]] if file.include?('..')

        body = stylesheet_builder.build(bundle,file)
        [200, headers('css'), [body]]
      end
      
      def headers(type)
        headers = { 'Content-Type' => "text/#{type}" }
        headers['Cache-Control'] = 'public, max-age=2592000' if @config[:cache]
        
        headers
      end

      def javascript_builder
        @javascript_builder ||= Asseter::Builder::Javascript.new(@config)
      end

      def stylesheet_builder
        @stylesheet_builder ||= Asseter::Builder::Stylesheet.new(@config)
      end
  end
  
  class FileNotFoundError < StandardError; end
end

module Asseter
  module Railties
    module ViewHelpers
      def javascript_assets(bundle)
        if Rails.env.production?
          [bundle.to_s]
        else
          ViewHelpers.files('javascripts',bundle)
        end.inject('') do |buffer, file|
          buffer << javascript_include_tag(file) << "\n"
        end.html_safe
      end

      def stylesheet_assets(bundle)
        if Rails.env.production?
          [bundle.to_s]
        else
          ViewHelpers.files('stylesheets',bundle)
        end.inject('') do |buffer, file|
          buffer << stylesheet_link_tag(file) << "\n"
        end.html_safe    
      end
    
        def self.files(type, bundle)
          Dir[Rails.root.join(*%W{app #{type} #{bundle} ** *})].inject([]) do |collection, file|
            if File.exists?(file) && !File.directory?(file)
              file.gsub!(/^#{Rails.root.join(*%W{app #{type}})}\/(.*)\..*$/,'\1')
              
              collection << file unless File.basename(file).first == '_'
            end
            
            collection
          end
        end
    end
  end
end

ActionView::Base.send :include, Asseter::Railties::ViewHelpers

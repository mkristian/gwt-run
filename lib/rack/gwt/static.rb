require 'rack/static'
require 'date'

module Rack
  module Gwt
    class Static < Rack::Static
      
      def initialize( app, *gwt_modules )
        if gwt_modules.last.is_a?( Hash )
          gwt_modules.reverse!
          opts = gwt_modules.shift.dup
          gwt_modules.reverse!
        else
          opts = {}
        end
        pathes = gwt_modules.collect { |g| "/#{g}" }
        options = { :root => 'public',
          :index => 'index.html',
          :header_rules => [
                            [ /\.css/, 
                              { 'Content-Type' => 'application/css' } ],
                            [ /\.js/, 
                              { 'Content-Type' => 'application/js' } ],
                            [ /\.cache\./, 
                              { 'Expires' => (Time.now + 365).rfc2822 } ],
                            [ /\.nocache\./, 
                              { 'Expires' => Time.new( 1970 ).rfc2822,
                                'Cache-Control' => 'public, max-age=0, must-revalidate' } ]
                           ]
        }
        options.merge!( opts )
        options[ :urls ] = pathes + [ "/#{opts[ :index] }" ]
        super( app, options )
      end

    end
  end
end

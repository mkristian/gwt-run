#
# Copyright (C) 2013 Christian Meier
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
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
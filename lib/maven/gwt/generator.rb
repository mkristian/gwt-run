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
require 'maven/gwt/layout'
require 'thor/group'
require 'thor/actions'

module Maven
  module Gwt
    class Generator < Thor::Group
      include Thor::Actions

      source_root( File.join( File.dirname( __FILE__ ), 'templates' ) )

      def layout
        @layout ||= Layout.new
      end

      def base_package
        @base_package ||= @java_package + '.client'
      end
      
      def basedir
        @basedir ||= File.join( layout.java_root, *@java_package.split( /\./ ) )
      end
      
      def clientdir
        @clientdir ||= File.join( basedir, 'client' )
      end
      
      def application_name
        @application_name ||= File.basename( @basedir )
      end

      def application_name_humanized
        @application_name_humanized ||= application_name.split( /_/ ).collect{ |p| p.capitalize }.join( ' ' )
      end

      def application_class_name
        @application_name ||= camelize( application_name )
      end

      def camelize( str )
        str.split( "_" ).collect { |s| s.capitalize }.join
      end

      def setup( java_package, app_name = nil )
        @java_package = java_package
        @application_name = app_name
        template( 'Module.gwt.xml',
                  "#{basedir}/#{application_class_name}.gwt.xml" )
        template( 'ModuleDevelopment.gwt.xml',
                  "#{basedir}/#{application_class_name}Development.gwt.xml" )
        template( 'EntryPoint.java', 
                  "#{clientdir}/#{application_class_name}EntryPoint.java" )
        template( 'Application.java', 
                  "#{clientdir}/#{application_class_name}Application.java" )
        template( 'Application.ui.xml', 
                  "#{clientdir}/#{application_class_name}Application.ui.xml" )
        template( 'index.html',
                  'public/index.html' )
        template( 'gwt.css',
                  "public/#{application_name}.css" )
        
      end

    end
  end
end
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
require 'maven/jetty/pom_magic'
require 'maven/tools/gem_project'
require 'maven/gwt/layout'
require 'fileutils'

module Maven
  module Gwt
    class PomMagic < Maven::Jetty::PomMagic

      def generate_pom( dir = '.', *args )

        proj = Maven::Tools::GemProject.new

        ensure_web_xml( dir, proj )
        ensure_mavenfile( dir )

        load_standard_files( dir, proj )

        pom_xml( dir, proj, args )
      end

      def gwt_module( layout )
        gwt_module = layout.find_gwt_xml
        unless gwt_module
          path = layout.java_root.sub( /#{File.expand_path( '.' )}/, '').sub( /^\//, '' )
          e = StandardError.new "no gwt module found in '#{path}'. try to run the command below to setup a minimal gwt application.\n\n\t\t#{File.basename( $0 )} setup JAVA_PACKAGE [APP_NAME]\n\n"
         
          def e.backtrace
            []
          end
          raise e
        end
        gwt_module
      end

      def ensure_mavenfile( dir )
        unless File.exists?(  File.join( dir, 'Mavenfile' ) )
          layout = Layout.new( dir )
          file = File.expand_path( gwt_module( layout ) )
          gwt_module = file.sub( /#{layout.java_root}\/?/, '' ).sub( /.gwt.xml$/, '' ).gsub( /\//, '.')
          app_name = gwt_module.sub( /.*\./, '' )
          unless File.exists?( File.join( layout.public_dir, app_name + ".html" ) )
            app_name = 'index'
          end
          super dir, File.dirname( __FILE__ ), 'GWT_MODULE' => gwt_module, 'APP_NAME' => app_name, 'GWT_MODULE_NAME' => gwt_module.sub( /.*\./, '' )
        end
      end

      def ensure_web_xml( dir, proj )
        super dir, proj, File.dirname( __FILE__ ), File.join( dir, 'public', 'WEB-INF', 'web.xml' )
      end
    end
  end
end

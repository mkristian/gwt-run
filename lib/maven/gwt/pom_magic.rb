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
          super dir, File.dirname( __FILE__ ), 'GWT_MODULE' => gwt_module, 'APP_NAME' => app_name
        end
      end

      def ensure_web_xml( dir, proj )
        super dir, proj, File.dirname( __FILE__ ), File.join( dir, 'public', 'WEB-INF', 'web.xml' )
      end
    end
  end
end

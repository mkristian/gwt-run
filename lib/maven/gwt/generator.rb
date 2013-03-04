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

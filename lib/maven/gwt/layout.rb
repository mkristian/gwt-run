module Maven
  module Gwt
    class Layout

      def initialize( dir = '.' )
        @dir = dir
      end
      
      def java_root
        @java_root ||= File.join( @dir, 'src', 'main', 'java' )
      end
      
      def public_dir
        @public_dir ||= File.join( @dir, 'public' )
      end
      
      def find_gwt_xml( path = java_root )
        Dir[ File.join( path, "*" ) ].each do |path|
          if File.directory?( path )
            result = find_gwt_xml( path )
            return result if result
          elsif File.file?( path )
            return path if (path =~ /.gwt.xml$/) && ! (path =~ /Development.gwt.xml$/)
          end
        end
        nil
      end
    end

  end
end

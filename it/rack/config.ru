#-*- mode: ruby -*-

require 'rack/lobster'
require File.join( File.dirname( __FILE__), 
                   '..', '..', '..', 'lib',
                   'rack', 'gwt', 'static' )

use Rack::Gwt::Static, 'Demo', :root => File.join( File.dirname( __FILE__),
                                                   'public' )

run Rack::Lobster.new

# vim: syntax=Ruby

# gwt run 

* [![Build Status](https://secure.travis-ci.org/mkristian/gwt-run.png)](http://travis-ci.org/mkristian/gwt-run)
* [![Dependency Status](https://gemnasium.com/mkristian/gwt-run.png)](https://gemnasium.com/mkristian/gwt-run)
* [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/mkristian/gwt-run)


## install ##

first uninstall older ruby-maven (< 3.0.4.0.29.0) if present, they will otherwise conflict with gwt-run command

    $ gem uninstall ruby-maven
	$ gem install gwt-run

## usage ##

    $ cd my_rails_app
 	$ jruby -S bundle install #optional
	$ gwt run

or for a rack application (assuming existiing config.ru)

    $ cd my_rack_app
 	$ jruby -S bundle install #optional
	$ gwt run

regarding `bundle install`: it must work wth JRuby since JRuby is the runtime environment. but `bundle install` since `gwt` will resolve a valid gemset itself and creates a Gemfile.lock (with the help of bundler). in short; all gems must be for the java platform or you need to provide jruby alternative gems.

`gwt` works with both MRI and JRuby - MRI starts up slightly faster BUT **uses JRuby** when running the applicaton.

gwt-run will use Gemfile/Gemfile.lock and Jarfile/Jarfile.lock to setup an environment to start rails in development mode as well gwt development shell. it uses ruby-maven to achieve this, i.e. all missing jar dependencies (gwt itself and all its dependences) will be downloaded on the first run (that can take time since it first needs to download all the jars).

to customize gwt and add your source dependencues you can use the _Mavenfile_ which allows to reconfigure gwt-maven-plugin, i.e. the version of gwt

    properties['gwt.version'] = '2.5.1

you also can pass some properties in via the command line

	$ gwt -- -Dgwt.version=2.5.1
	
**--** is used a separator after which you can use any maven open available. like `-- -X` gives you a complete maven debug output, `-- -o` offline mode, etc.

## using the super dev mode ##

start the super dev mode with

    $ gwt codeserver
	
follow the instruction about the bookmarklet and start jetty with (it is a dependency to gwt-run)
   
    $ jetty-run
	
now you can open your browser on localhost:8080 and active the codeserver wth the bookmark.

## compile the application ##

    $ gwt compile
	
or recompile with strict checkings (helpful for debugging gwt-generated code)

    $ gwt compile --force --strict
	
or production (use force to overwrite development code)

    $ gwt compile -e production --force
	
## add a simple skeleton to your rack/rails application

    $ gwt setup com.example.myapp MyApp
	
you will find the code under src/main/java

## more ##

see

    gwt help
	 
# note #

orginally the code was part the jruby-maven-plugins and slowly the functionality moved to the ruby side of things. so things are on the move and there is room for improvements . . .
    
contributing
------------

1. fork it
2. create your feature branch (`git checkout -b my-new-feature`)
3. commit your changes (`git commit -am 'Added some feature'`)
4. push to the branch (`git push origin my-new-feature`)
5. create new Pull Request

meta-fu
-------

bug-reports and pull request are most welcome. otherwise

enjoy :) 

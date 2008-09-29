lib_dir = File.expand_path(File.join(File.dirname(__FILE__), "lib"))
$:.unshift(lib_dir)
$:.uniq!

require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/packagetask'
require 'rake/gempackagetask'
require 'rake/contrib/rubyforgepublisher'
require 'spec/rake/spectask'

require File.join(File.dirname(__FILE__), 'lib/xbel', 'version')

PKG_DISPLAY_NAME   = 'XBEL'
PKG_NAME           = PKG_DISPLAY_NAME.downcase
PKG_VERSION        = XBEL::VERSION::STRING
PKG_FILE_NAME      = "#{PKG_NAME}-#{PKG_VERSION}"

RELEASE_NAME       = "REL #{PKG_VERSION}"

RUBY_FORGE_PROJECT = PKG_NAME
RUBY_FORGE_USER    = "sporkmonger"
RUBY_FORGE_PATH    = "/var/www/gforge-projects/#{RUBY_FORGE_PROJECT}"
RUBY_FORGE_URL     = "http://#{RUBY_FORGE_PROJECT}.rubyforge.org/"

PKG_SUMMARY        = "XBEL"
PKG_DESCRIPTION    = <<-TEXT
XBEL is the XML Bookmark Exchange Library.  This parser reads bookmarks from
the various bookmark export formats used by browsers and web services and
translates them to XBEL, CSV, JSON, or the HTML format used by Firefox.
TEXT

PKG_FILES = FileList[
    "lib/**/*", "spec/**/*", "vendor/**/*",
    "tasks/**/*", "website/**/*",
    "[A-Z]*", "Rakefile"
].exclude(/database\.yml/).exclude(/[_\.]git$/)

if RUBY_PLATFORM != "java"
  task :default => "spec:verify"
else
  task :default => "spec"
end

WINDOWS = (RUBY_PLATFORM =~ /mswin|win32|mingw|bccwin|cygwin/) rescue false
SUDO = WINDOWS ? '' : ('sudo' unless ENV['SUDOLESS'])

Dir['tasks/**/*.rake'].each { |rake| load rake }

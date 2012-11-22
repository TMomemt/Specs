require 'rubygems'

# Better to fail early and clear then during installation of pods.
#
# RubyGems 1.3.6 (which ships with OS X >= 10.7) up to 1.4.0 have a couple of
# bugs related to comparing prerelease versions.
#
# E.g. https://github.com/CocoaPods/CocoaPods/issues/398
unless Gem::Version::Requirement.new('>= 1.4.0').satisfied_by?(Gem::Version.new(Gem::VERSION))
  STDERR.puts "\e[1;31m" + "Your RubyGems version (1.8.24) is too old, please update with: `gem update --system`" + "\e[0m"
  exit 1
end

module Pod
  VERSION = '0.16.0'

  class PlainInformative < StandardError
  end

  class Informative < PlainInformative
    def message
      # TODO: remove formatting from raise calls and remove conditional
      super !~ /\[!\]/ ? "[!] #{super}\n".red : super
    end
  end

  autoload :Command,                'cocoapods/command'
  autoload :Config,                 'cocoapods/config'
  autoload :Dependency,             'cocoapods/dependency'
  autoload :Downloader,             'cocoapods/downloader'
  autoload :Executable,             'cocoapods/executable'
  autoload :Installer,              'cocoapods/installer'
  autoload :LocalPod,               'cocoapods/local_pod'
  autoload :Lockfile,               'cocoapods/lockfile'
  autoload :Platform,               'cocoapods/platform'
  autoload :Podfile,                'cocoapods/podfile'
  autoload :Project,                'cocoapods/project'
  autoload :Resolver,               'cocoapods/resolver'
  autoload :Sandbox,                'cocoapods/sandbox'
  autoload :Source,                 'cocoapods/source'
  autoload :Spec,                   'cocoapods/specification'
  autoload :Specification,          'cocoapods/specification'
  autoload :UI,                     'cocoapods/user_interface'
  autoload :Version,                'cocoapods/version'

  autoload :Pathname,               'pathname'
  autoload :FileList,               'cocoapods/file_list'

  module Generator
    autoload :BridgeSupport,        'cocoapods/generator/bridge_support'
    autoload :CopyResourcesScript,  'cocoapods/generator/copy_resources_script'
    autoload :Documentation,        'cocoapods/generator/documentation'
    autoload :Acknowledgements,     'cocoapods/generator/acknowledgements'
    autoload :Plist,                'cocoapods/generator/acknowledgements/plist'
    autoload :Markdown,             'cocoapods/generator/acknowledgements/markdown'
    autoload :DummySource,          'cocoapods/generator/dummy_source'
  end
end

if ENV['COCOA_PODS_ENV'] == 'development'
  require 'awesome_print'
  require 'pry'
end

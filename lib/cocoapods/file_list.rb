if RUBY_VERSION >= "1.9"
  require 'rake/file_list'
else
  require 'rake'
end

# This makes Rake::FileList usable with the Specification attributes
# source_files, public_header_files, preserve_paths, and resources.
#
# @todo This needs to be deprecated as we no have the PathList List
#
module Rake
  class FileList
    def prepend_patterns(pathname)
      @pending_add.map! { |pattern| (pathname + pattern).to_s }
    end

    def directory?
      false
    end

    def glob
      to_a.map { |path| Pathname.new(path) }
    end

    def inspect
      "<##{self.class} pending_add=#{@pending_add}>"
    end
    alias :to_s :inspect
  end
end

module Pod
  FileList = Rake::FileList
end

class Pathname
  alias_method :_original_sum, :+
  def +(other)
    if other.is_a?(Rake::FileList)
      other.prepend_patterns(self)
      other
    else
      _original_sum(other)
    end
  end
end

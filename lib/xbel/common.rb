# ++
# XBEL, Copyright (c) 2008 Bob Aman
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# --

require "xbel/version"

module XBEL
  module Common
    # Returns the XML node that represents this XBEL element.
    def node
      return @node
    end
    
    # Returns the XBEL element title.
    def title
      @title ||= (begin
        title_node = self.node.find_first("title")
        if title_node && title_node.content
          title = title_node.content.strip
        end
        # Eww, but prevents segfaults
        title_node = nil
        GC.start
        defined?(title) ? title : nil
      end)
    end
    
    # Sets the XBEL element title.
    def title=(new_title)
      @title = new_title
    end

    # Returns the XBEL element description.
    def desc
      @desc ||= (begin
        desc_node = self.node.find_first("desc")
        if desc_node && desc_node.content
          desc = desc_node.content.strip
        end
        # Eww, but prevents segfaults
        desc_node = nil
        GC.start
        defined?(desc) ? desc : nil
      end)
    end
    alias_method :description, :desc
    
    # Sets the XBEL element desc.
    def desc=(new_desc)
      @desc = new_desc
    end
    alias_method :description=, :desc=

    # Returns the XBEL element metadata.
    def info
      @info ||= (begin
        info = []
        metadata_nodes = self.node.find("info/metadata")
        for metadata_node in metadata_nodes
          info << XBEL::Metadata.new(metadata_node)
        end
        # Eww, but prevents segfaults
        metadata_nodes = nil
        GC.start
        info
      end)
    end
  end
end

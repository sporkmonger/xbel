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
  class Collection
    include XBEL::Common

    # Initializes an XBEL collection.
    #
    # If a node is specified, the collection's values will be initialized
    # by its contents.
    def initialize(node=nil)
      @node = node
    end

    # Returns the XBEL collection id.
    def id
      @id ||= self.node.attributes.to_h["id"]
    end
    
    # Sets the XBEL collection id.
    def id=(new_id)
      @id = new_id
    end

    # Returns the XBEL collection added/created date.
    def added
      @added ||= (begin
        added = self.node.attributes.to_h["added"]
        added ? Time.parse(added) : nil
      end)
    end
    alias_method :created, :added
    
    # Sets the XBEL collection added/created date.
    def added=(new_added)
      if new_added.kind_of?(String)
        new_added = Time.parse(new_added)
      elsif !new_added.kind_of?(Time)
        raise TypeError,
          "Expected String or Time, got #{new_added.class.name}"
      end
      @added = new_added
    end
    alias_method :created=, :added=

    # Returns an Array containing Bookmarks, Folders, Separators,
    # and/or Aliases.
    def children
      @children ||= (begin
        children = []
        if self.node
          child_nodes = self.node.children
          for child_node in child_nodes
            case child_node.name
            when "bookmark"
              children << XBEL::Bookmark.new(child_node)
            when "folder"
              children << XBEL::Folder.new(child_node)
            when "separator"
              children << XBEL::Separator.new(child_node)
            when "alias"
              children << XBEL::Alias.new(child_node)
            end
          end
        end
        children
      end)
    end
    
    # Returns a String representation of this XBEL collection.
    def inspect
      if self.title
        return sprintf(
          "#<%s:%#0x TITLE:%s CHILDREN:%d>",
          self.class.to_s, self.object_id, self.title,
          self.children.size
        )
      else
        return sprintf(
          "#<%s:%#0x CHILDREN:%d>",
          self.class.to_s, self.object_id, self.children.size
        )
      end
    end
  end
end

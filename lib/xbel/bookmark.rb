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
  class Bookmark
    include XBEL::Common

    # Initializes an XBEL bookmark.
    #
    # If a node is specified, the bookmark's values will be initialized
    # by its contents.
    def initialize(node=nil)
      @node = node
    end

    # Returns the XBEL bookmark href.
    def href
      @href ||= (begin
        href = self.node.attributes.to_h["href"]
        href ? Addressable::URI.parse(href) : nil
      end)
    end
    alias_method :uri, :href
    
    # Sets the XBEL bookmark href.
    def href=(new_href)
      if new_href.kind_of?(String)
        new_href = Addressable::URI.parse(new_href)
      elsif !new_href.kind_of?(Addressable::URI)
        raise TypeError,
          "Expected String or Addressable::URI, got #{new_href.class.name}"
      end
      @href = new_href
    end
    alias_method :uri=, :href=
    
    # Returns the XBEL bookmark id.
    def id
      @id ||= self.node.attributes.to_h["id"]
    end
    
    # Sets the XBEL bookmark id.
    def id=(new_id)
      @id = new_id
    end

    # Returns the XBEL bookmark added/created date.
    def added
      @added ||= (begin
        added = self.node.attributes.to_h["added"]
        added ? Time.parse(added) : nil
      end)
    end
    alias_method :created, :added
    
    # Sets the XBEL bookmark added/created date.
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

    # Returns the XBEL bookmark modified/updated date.
    def modified
      @modified ||= (begin
        modified = self.node.attributes.to_h["modified"]
        modified ? Time.parse(modified) : nil
      end)
    end
    alias_method :updated, :modified
    
    # Sets the XBEL bookmark modified/updated date.
    def modified=(new_modified)
      if new_modified.kind_of?(String)
        new_modified = Time.parse(new_modified)
      elsif !new_modified.kind_of?(Time)
        raise TypeError,
          "Expected String or Time, got #{new_modified.class.name}"
      end
      @modified = new_modified
    end
    alias_method :updated=, :modified=

    # Returns the XBEL bookmark visited date.
    def visited
      @visited ||= (begin
        visited = self.node.attributes.to_h["visited"]
        visited ? Time.parse(visited) : nil
      end)
    end
    
    # Sets the XBEL bookmark visited date.
    def visited=(new_visited)
      if new_visited.kind_of?(String)
        new_visited = Time.parse(new_visited)
      elsif !new_visited.kind_of?(Time)
        raise TypeError,
          "Expected String or Time, got #{new_visited.class.name}"
      end
      @visited = new_visited
    end

    # Returns a String representation of this XBEL bookmark.
    def inspect
      if self.title
        return sprintf(
          "#<%s:%#0x TITLE:%s HREF:%s>",
          self.class.to_s, self.object_id, self.title,
          self.href ? self.href.to_s : "nil"
        )
      else
        return sprintf(
          "#<%s:%#0x HREF:%s>",
          self.class.to_s, self.object_id, self.href ? self.href.to_s : "nil"
        )
      end
    end    
  end
end

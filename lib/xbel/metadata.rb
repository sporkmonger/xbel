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
  class Metadata
    # Initializes an XBEL metadata object.
    #
    # If a node is specified, the metadata's values will be initialized
    # by its contents.
    def initialize(node=nil)
      @node = node
    end
    
    # Returns the XML node that represents this XBEL metadata.
    def node
      return @node
    end
    
    # Returns the XBEL metadata owner.
    def owner
      @owner ||= (begin
        owner = self.node.attributes.to_h["owner"]
        owner ? Addressable::URI.parse(owner) : nil
      end)
    end
    
    # Sets the XBEL metadata owner.
    def owner=(new_owner)
      if new_owner.kind_of?(String)
        new_owner = Addressable::URI.parse(new_owner)
      elsif !new_owner.kind_of?(Addressable::URI)
        raise TypeError,
          "Expected String or Addressable::URI, got #{new_owner.class.name}"
      end
      @owner = new_owner
    end
    
    # Returns the XBEL metadata value.
    #
    # Returns an Array of LibXML::XML::Nodes.
    def value
      @value ||= self.node.children
    end
  end
end

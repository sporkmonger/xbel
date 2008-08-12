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
  class Alias
    # Initializes an XBEL alias.
    #
    # If a node is specified, the aliases's values will be initialized
    # by its contents.
    def initialize(node=nil)
      @node = node
    end
    
    # Returns the XML node that represents this XBEL alias.
    def node
      return @node
    end
    
    # Returns the XBEL alias ref.
    def ref
      @ref ||= self.node.attributes.to_h["ref"]
    end
    alias_method :reference, :ref
    
    # Sets the XBEL alias ref.
    def ref=(new_ref)
      @ref = new_ref
    end
    alias_method :reference=, :ref=
    
    # Returns a String representation of this XBEL element.
    def inspect
      return sprintf(
        "#<%s:%#0x REF:%s>",
        self.class.to_s, self.object_id, self.ref
      )
    end
  end
end

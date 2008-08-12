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
require "time"

module XBEL
  class Folder < XBEL::Collection
    # Returns the XBEL folder folded status.
    def folded
      @folded ||= (begin
        folded = self.node.attributes.to_h["folded"]
        folded ? (folded == "yes" ? true : false) : nil
      end)
    end
    
    # Sets the XBEL folder folded status.
    def folded=(new_folded)
      if new_folded.kind_of?(String)
        new_folded = (new_folded == "yes" ? true : false)
      elsif new_folded != true && new_folded != false && new_folded != nil
        raise TypeError,
          "Expected String, TrueClass, or FalseClass, got " +
          "#{new_folded.class.name}"
      end
      @folded = new_folded
    end
  end
end

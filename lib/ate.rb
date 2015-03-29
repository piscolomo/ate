# Copyright (c) 2015 Julio Lopez

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
class Ate
  VERSION = "1.0.0"

  class << self
    def parse(template, vars = {})
      context = vars.fetch(:context, self)
      lines = template.end_with?(".ate") ? File.read(template) : template
      lines = lines.split("\n")
      built = build_proc(lines, vars)
      @parsed = context.instance_eval(built)
      self
    end

    def build_proc(lines, vars)
      @output = "Proc.new do \n output = \"\" \n "
      declaring_local_variables(vars)
      parsing_lines(lines)
      @output << "output \n end"
    end

    def declaring_local_variables(vars)
      vars.each do |x, y|
        value = y.is_a?(String) ? "\"#{y}\"" : y
        @output << "#{x} = #{value}\n"
      end
    end

    def parsing_lines(lines)
      lines.each do |line|
        if line =~ /^\s*(%)(.*?)$/
          @output << "#{line.gsub(/^\s*%(.*?)$/, '\1') } \n"
        else
          @output << "output << %Q|#{line.gsub(/\{\{([^\r\n]*)\}\}/, '#{\1}')}\n| \n "
        end
      end
    end

    def render
      @parsed.call
    end
  end
end
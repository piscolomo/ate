class Ate
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
          @output << "output << \"#{line.gsub(/\{\{([^\r\n]*)\}\}/, '#{\1}') }\n\" \n "
        end
      end
    end

    def render
      @parsed.call
    end
  end
end
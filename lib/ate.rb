class Ate
  class << self
    def parse(template, vars = {})
      context = vars.fetch(:context, nil)
      lines = template.end_with?(".ate") ? File.read(template) : template
      lines = lines.split("\n")
      built = build_proc(lines, vars)
      @parsed = context ? context.instance_eval(built) : eval(built)
      self
    end

    def build_proc(lines, vars)
      @proc = "Proc.new do \n output = \"\" \n "
      declaring_local_variables(vars)
      parsing_lines(lines)
      @proc << "output \n end"
    end

    def declaring_local_variables(vars)
      vars.each do |x, y|
        value = y.is_a?(String) ? "\"#{y}\"" : y
        @proc << "#{x} = #{value}\n"
      end
    end

    def parsing_lines(lines)
      lines.each do |line|
        if line =~ /^\s*(%)(.*?)$/
          @proc << "#{line.gsub(/^\s*%(.*?)$/, '\1') } \n"
        else
          @proc << "output << \"#{line.gsub(/\{\{([^\r\n\{]*)\}\}/, '#{\1}') }\n\" \n "
        end
      end
    end

    def render
      @parsed.call
    end
  end
end
class Ate

  def self.parse(template, vars = "")
    lines = template.end_with?(".ate") ? File.read(template) : template
    lines = lines.split("\n")

    proc = "Proc.new do |#{vars}| \n "
    proc << "output = \"\" \n "

    lines.each do |line|
      if line =~ /^\s*(%)(.*?)$/
        proc << "#{line.gsub(/^\s*%(.*?)$/, '\1') } \n"
      else
        proc << "output << \"#{line.gsub(/\{\{([^\r\n\{]*)\}\}/, '#{\1}') }\n\" \n "
      end
    end

    proc << "output \n"
    proc << "end"

    eval(proc)
  end
end
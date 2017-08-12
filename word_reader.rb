# encoding: utf-8
#
class WordReader

  def read_from_args
    return ARGV[0]
  end

  def read_from_file(file_name)

    begin
      file = File.new(file_name, "r:UTF-8")
      lines = file.readlines
      file.close
    rescue SystemCallError
      abort "Файл не найден"
    end

    return UnicodeUtils.downcase(lines.sample.chomp)
  end
end

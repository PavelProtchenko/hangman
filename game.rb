require 'unicode_utils/downcase'

class Game

  def initialize(word)

    @letters = get_letters(word)

    @errors = 0

    @good_letters = []
    @bad_letters = []

    @status = 0
  end

  def get_letters(word)
    if (word == nil || word == "")
      abort "Загадано пустое слово, нечего отгадывать. Закрываемся"
    end

    return word.encode('UTF-8').split("")
  end

  def status
    return @status
  end

  def next_step(bukva)

    if @status == -1 || @status == 1
      return
    end

    if @good_letters.include?(bukva) || @bad_letters.include?(bukva)
      return
    end

    if @letters.include?(bukva) ||
      (bukva == "е" && letters.include?("ё")) ||
      (bukva == "ё" && letters.include?("е")) ||
      (bukva == "и" && letters.include?("й")) ||
      (bukva == "й" && letters.include?("и"))

      @good_letters << bukva

      if bukva == "е"
        @good_letters << "ё"
      elsif bukva == "ё"
        @good_letters << "е"
      elsif bukva == "и"
        @good_letters << "й"
      elsif bukva == "й"
        @good_letters << "и"
      end

      if @good_letters.uniq.sort == @letters.uniq.sort
        @status = 1
      end

      if (@letters - @good_letters).empty?
        @status = 1
      end

    else

      @bad_letters << bukva
      @errors += 1

      if @errors >= 7
        @status = -1
      end
    end
  end

  def ask_next_letter
    puts "\nВведите следующую букву"

    letter = ""
    while letter == ""
      letter = STDIN.gets.encode("UTF-8").chomp
    end

    letter = UnicodeUtils.downcase(letter)

    next_step(letter)
  end

  def errors

    @errors
  end

  def letters
    @letters
  end

  def good_letters
    @good_letters
  end

  def bad_letters
    @bad_letters
  end
end

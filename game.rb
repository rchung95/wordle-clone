class Game
  attr_accessor :total_attempts, :words, :active
  attr_reader :word, :max_attempts

  def initialize
    @word = ["t", "o", "d", "a", "y"]
    @total_attempts = 0
    @max_attempts = 5
    @words = [
      ["_", "_", "_", "_", "_"],
      ["_", "_", "_", "_", "_"],
      ["_", "_", "_", "_", "_"],
      ["_", "_", "_", "_", "_"],
      ["_", "_", "_", "_", "_"],
    ]
    @active = true
  end

  def get_word
    puts "Enter your word: "
    new_word = gets.chomp
    if new_word.length == 5 
      @words[total_attempts] = new_word.split("")
    else
      puts "Your word must be 5 characters long."
    end
  end

  def check_word
    if @words[total_attempts] == @word
      @active = false
      return "Congratulations! You solved the word \"#{@word.join("")}\" on total_attempts #{@total_attempts + 1}."
    else
      return response
    end
  end

  def active?
    @total_attempts < @max_attempts && @active
  end

  private

  def response
    response = "Result:\n"

    @words[total_attempts].each_with_index do |char, index|
      if @word[index] == char
        response += "- \"#{char}\" is correct in position #{index}.\n"
      elsif @word.include?(char)
        response += "- \"#{char}\" is in the word but not in the correct position. Or its already in the correct position.\n"
      end
    end

    @total_attempts += 1

    response
  end
end

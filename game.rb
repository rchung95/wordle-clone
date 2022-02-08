require 'paint'

class Game
  attr_accessor :attempt, :words, :active, :current_word
  attr_reader :word, :max_attempts

  def initialize
    @word = ["t", "o", "d", "a", "y"]
    @current_word = ""
    @attempt = 0
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

  def board
    @words.each do |row|
      puts row.join(" ")
    end
  end

  def get_word
    puts Paint["Enter your word: ", :blue]
    new_word = gets.chomp
    if new_word.length == 5 
      @current_word = new_word.split("")
      add_word_to_board
    else
      puts Paint["Your word must be 5 characters long.", :red]
    end
  end

  def check_word
    if @current_word == @word
      @active = false
      return "Congratulations! You solved the word #{Paint[@word.join(""), :green]} on attempt #{Paint[@attempt + 1, :green]}."
    else
      return response
    end
  end

  def add_word_to_board
    colorized_word = []
    @current_word.each_with_index do |char, index|
      if char == @word[index]
        colorized_word << Paint[char, :green]
      elsif @word.include?(char)
        colorized_word << Paint[char, :yellow]
      else
        colorized_word << char
      end
    end

    @words[@attempt] = colorized_word
  end

  def active?
    @attempt < @max_attempts && @active
  end

  private

  def response
    response = "Result:\n"

    @current_word.each_with_index do |char, index|
      if @word[index] == char
        response += "- #{Paint[char, :green]} is correct in position #{index}.\n"
      elsif @word.include?(char)
        response += "- #{Paint[char, :yellow]} is in the word but not in the correct position. Or its already in the correct position.\n"
      end
    end

    @attempt += 1

    response
  end
end

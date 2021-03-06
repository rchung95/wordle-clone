require 'paint'
require 'yaml'

class Game
  attr_accessor :attempt, :words, :active, :current_word
  attr_reader :word, :max_attempts

  def initialize
    @word = ""
    @current_word = ""
    @attempt = 0
    @max_attempts = 5
    @words = [
      "_ _ _ _ _",
      "_ _ _ _ _",
      "_ _ _ _ _",
      "_ _ _ _ _",
      "_ _ _ _ _",
    ]
    @active = true
  end

  def intro
    puts <<~INTRO
      #{Paint["Welcome to Wordle! You got #{max_attempts} attempts to guess the correct 5 letter word!", :magenta]}
      Choose your difficulty:
      #{Paint["1. Regular words", :yellow]}
      #{Paint["2. Gotta name 'em all!", :cyan]}

      Which option do you choose (1 or 2)?\n
    INTRO
    
    get_option
  end

  def board
    @words.each do |row|
      puts row
    end
  end

  def get_word
    puts Paint["Enter your word: ", :blue]
    get_input
    add_word_to_board
  end

  def check_attempt
    if @attempt == @max_attempts && !active?
      @active = false
      puts Paint["Game over! You have used up all attempts. Today's word is #{Paint[@word, :cyan]}.\n", :red]
    end
  end

  def check_word
    if @current_word.join("") == @word
      @active = false
      puts "Congratulations! You solved the word #{Paint[@word, :green]} on attempt #{Paint[@attempt + 1, :green]}."
    else
      puts response
    end
  end

  def active?
    @attempt < @max_attempts && @active
  end

  private

  def add_word_to_board
    colorized_word = ""
    @current_word.each_with_index do |char, index|
      if char == @word[index]
        colorized_word << Paint[char, :green]
      elsif @word.include?(char)
        colorized_word << Paint[char, :yellow]
      else
        colorized_word << char
      end
      colorized_word << " "
    end

    @words[@attempt] = colorized_word
  end

  def get_input
    invalid = true
    while invalid
      new_word = gets.chomp.gsub(/\s+/, "")
      
      if new_word.length == 5
        @current_word = new_word.downcase.split("")
        invalid = false
      else
        puts Paint["Your word must be 5 characters long. Try again:", :red]
      end
    end
  end

  def get_option
    invalid = true
    
    while invalid
      option = gets.chomp

      if option == "1"
        @word = YAML.load_file("words.yml").sample
        invalid = false
      elsif option == "2"
        @word = YAML.load_file("pokemon.yml").sample
        invalid = false
      else
        puts Paint["Please choose between option 1 or 2.", :red]
      end
    end
  end

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

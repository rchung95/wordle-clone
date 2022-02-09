require_relative 'game.rb'

game = Game.new
puts game.intro
while game.active?
  game.board
  game.get_word
  puts game.check_word
  game.check_attempt
end
game.board

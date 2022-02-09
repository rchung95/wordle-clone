require_relative 'game.rb'

game = Game.new
game.intro
while game.active?
  game.board
  game.get_word
  game.check_word
  game.check_attempt
end
game.board

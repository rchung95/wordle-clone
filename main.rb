require_relative 'game.rb'

game = Game.new
while game.active?
  game.board
  game.get_word
  puts game.check_word
end
game.board

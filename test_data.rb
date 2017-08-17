require "test/unit"
require_relative "game"

@@data = [
  [0,   [0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0]],
  [20,  [1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 1,1]],
  [6,   [1,1, 1,1, 1,1]], # incomplete
  [18,  [1,1, 6,4, 3]], # incomplete w/ spare
  [150, [5,5, 5,5, 5,5, 5,5, 5,5, 5,5, 5,5, 5,5, 5,5, 5,5, 5]],
  [47,  [1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 10, 10 ,9]],
  [173, [7,3, 7,3, 7,3, 7,3, 7,3, 7,3, 7,3, 7,3, 7,3, 7,3, 10]],
  [300, [10,  10,  10,  10,  10,  10,  10,  10,  10,  10,  10,  10]],
  [280, [10,  10,  10,  10,  10,  10,  10,  10,  10,  10,  5]],  # incomplete
  [300, [10,  10,  10,  10,  10,  10,  10,  10,  10,  10,  10,  10, 10, 10, 10]], # extras
  [240, [10,  10,  10,  0,0, 10,  10,  10,  10,  10,  10,  10,  10]],
  [245, [10,  10,  10,  10,  10,  10,  10,  10,  10,  1,1]]
]

class GameTest < Test::Unit::TestCase
    def  test_game

        @@data.each do |e|
            game = Game.new
            e[1].each do |el|
                game.roll el
            end
            p e
            p game.score
            assert e[0] == game.score
        end
    end
end

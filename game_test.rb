require "test/unit"
require_relative "game"

class GameTest < Test::Unit::TestCase
    def  test_no_score_game
        game = make_game [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        assert_equal game.score, 0
    end

    def  test_low_score_game
        game = make_game [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        assert_equal game.score, 20
    end

    def  test_incomplete_with_spare
        game = make_game [1,1,6,4,3]
        assert_equal game.score, 18
    end

    def  test_mid_score_game
        game = make_game [5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5]
        assert_equal game.score, 150
    end

    def  test_strike_tenth_frame
        game = make_game [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,10,10,9]
        assert_equal game.score, 47
    end

    def  test_all_spares
        game = make_game [7,3,7,3,7,3,7,3,7,3,7,3,7,3,7,3,7,3,7,3,10]
        assert_equal game.score, 173
    end

    def  test_perfect_game
        game = make_game [10,10,10,10,10,10,10,10,10,10,10,10]
        assert_equal game.score, 300
    end

    def  test_incomplete_game
        game = make_game [10,10,10,10,10,10,10,10,10,10,5]
        assert_equal game.score, 280
    end

    def  test_extras
        game = make_game [10,10,10,10,10,10,10,10,10,10,10,10,10,10,10]
        assert_equal game.score, 300
    end

    def  test_mostly_strikes
        game = make_game [10,10,10,0,0,10,10,10,10,10,10,10,10]
        assert_equal game.score, 240
    end

    def  test_mostly_strikes_until_last_frame
        game = make_game [10,10,10,10,10,10,10,10,10,1,1]
        assert_equal game.score, 245
    end

    private

    def make_game(arr)
       game = Game.new
       arr.each do |e|
           game.roll e
       end
       game
    end

end

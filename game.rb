require_relative 'frame'

class Game

    def initialize
        @rolls = []
        @frames = makeframes
    end

    def roll(pins)
        @rolls << pins
        @frames = makeframes[0..11]
    end

    def score
        score_frames + score_bonus + (@frames[11] ? @frames[11].first : 0)
    end

    def score_frames
        @frames[0..10].map { |e| e.value }.inject :+
    end

    def score_bonus
        @frames[0..8].each_with_index.map { |_, i| score_frame_bonus i }.inject :+
    end

    def score_frame_bonus(i)
        frame0 = @frames[i]
        frame1 =  !@frames[i + 1].nil? ? @frames[i + 1] : Frame.new([0,0])
        frame2 =  !@frames[i + 2].nil? ? @frames[i + 2] : Frame.new([0,0])

        if frame0.strike?
            if frame1.strike?
                frame1.first + frame2.first
            else
                frame1.first + frame1.second
            end
        elsif frame0.spare?
            frame1.first
        else
            0
        end
    end

    def makeframes
        acc = []
        i = 0
        until i > (@rolls.length - 1)
            if @rolls[i] == 10
                acc << Frame.new([@rolls[i], 0])
                i += 1
            else
                acc << Frame.new([@rolls[i], @rolls[i + 1]])
                i += 2
            end
        end
        acc
    end
end

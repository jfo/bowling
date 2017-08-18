require_relative 'frame'

class Game
    def initialize
        @rolls = []
    end

    def roll(pins)
        @rolls << pins
    end

    def score
        # Only compute frames when asking for the score
        # This is reasonable to do here since this class's api is so simple,
        # but it's also indicative of the worst of OOP internal state holding
        # patterns. I could pass a _local_ `frames` into the scoring functions
        # directly, but I'd be copying a bunch of data a bunch of times for
        # every stackframe function call. Why not just cache it in an instance
        # var?
        @frames = makeframes[0..11]

        score_frames + score_bonus
    end

    private

    def score_frames
        # the 10th frame is worth only its face value and is counted here
        # if there is a "bonus" frame 11, it is also counted here
        @frames.map { |e| e.value }.inject :+
    end

    def score_bonus
        #only the first 9 frames are ever eligible for a bonus score
        @frames[0..8].each_with_index.map { |_, i| score_frame_bonus i }.inject :+
    end

    # Takes an index and computes that frame's bonus in the context of the
    # current game.
    def score_frame_bonus(i)
        frame0 = @frames[i]

        # these nil checks allow us to iterate over the whole list of @frames
        # without running into trouble
        frame1 =  @frames[i + 1] ? @frames[i + 1] : Frame.new(0,0)
        frame2 =  @frames[i + 2] ? @frames[i + 2] : Frame.new(0,0)

        # we can just precompute what the first and second roll values would be here.
        # This de-nests the conditional below and improves readibility.
        first_roll = frame1.first
        second_roll = (frame1.strike? ?  frame2.first : frame1.second)

        # I wanted this to be recursive so bad, I can't believe I didn't know
        # how bowling works.
        if frame0.strike?
            first_roll + second_roll
        elsif frame0.spare?
            first_roll
        else
            0
        end
    end

    def makeframes
        acc = []
        i = 0
        until i > (@rolls.length - 1)
            if @rolls[i] == 10
                acc << Frame.new(@rolls[i], 0)
                i += 1
            else
                acc << Frame.new(
                    @rolls[i],
                    @rolls[i + 1] ?  @rolls[i + 1] : 0
                )
                i += 2
            end
        end
        acc
    end
end

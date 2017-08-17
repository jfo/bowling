class Frame
    attr_accessor :first, :second

    def initialize(first, second)
        @first = first
        @second = second
    end

    def value
        @first + @second
    end

    def spare?
        value == 10
    end

    def strike?
        @first == 10
    end
end


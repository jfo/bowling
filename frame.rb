class Frame
    attr_accessor :first, :second

    def initialize(arr)
        @first = arr.first
        @second = (arr[1] ? arr[1] : 0)
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


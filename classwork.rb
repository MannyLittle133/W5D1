class MaxIntSet
    attr_accessor :store
    def initialize(max = 4)
    @store = Array.new(max, false)
    end

    def insert(num)
    raise "Out of bounds" if num >= @store.length || num < 0
    return false if @store[num]
    @store[num] = true
    end

    def remove(num)
    @store[num] = false
    end

    def include?(num)
    raise 'OutOfRangeError' if num >= @store.length
    @store[num]
    end

    private

    def is_valid?(num)
    end

    def validate!(num)
    end
end


class IntSet
    attr_accessor :store
    def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    end

    def insert(num)
    @store[num % 20] << num
    end

    def remove(num)
    idx = @store[num%20].index(num)
    if !idx.nil?
        @store[num%20] = @store[num%20][0...idx].concat(@store[num%20][idx+1..-1])
    end
    end

    def include?(num)
    @store[num % 20].include?(num)
    end

    private

    def [](num)
    # optional but useful; return the bucket corresponding to `num`
    end

    def num_buckets
    @store.length
    end

end

class ResizingIntSet
    attr_reader :store, :count

    def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    end

    def insert(num)
    bucket = @store[num % @store.length]
    if !self[num].include?(num)
        bucket << num
        @count += 1
        resize! if @count >= @store.length

        return true
    end
    false
    end

    def remove(num)
    bucket = self[num]
    idx = bucket.index(num)
    puts bucket.inspect
    if !idx.nil?
        @store[num % @store.length] = bucket[0...idx].concat(bucket[idx+1..-1])
        @count -= 1
    end
    end

    def include?(num)
    self[num].include?(num)
    end

    private

    def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @store.length]

    end

    def num_buckets
    @store.length
    end

    def resize!
    all_values = @store.flatten.select{|ele| !ele.nil?}
    self.initialize(@store.length * 2)
    all_values.each{|ele| insert(ele)}
    @count = all_values.length
    end
end
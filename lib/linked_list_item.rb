class LinkedListItem
  include Comparable
  attr_reader :next_item
  attr_accessor :payload

  def initialize(value)
    @payload = value
  end

  def <=>(some_item)
    self.payload.to_s <=> some_item.payload.to_s
  end

  def next_item=(other_item)
    raise ArgumentError if self === other_item
    @next_item = other_item
  end

  def last?
    @next_item.nil?
  end

  def ===(some_item)
    self.equal? some_item
  end

end

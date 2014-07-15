class LinkedListItem
  include Comparable
  attr_reader :next_item
  attr_accessor :payload

  def initialize(value)
    @payload = value
  end

  def <=>(some_item)
    if self.payload.class == some_item.payload.class
      self.payload <=> some_item.payload
    else
      precedence = [ Fixnum, String, Symbol ]
      left  = precedence.index(self.payload.class)
      right = precedence.index(some_item.payload.class)
      left <=> right
    end
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

class LinkedList
  attr_accessor :size

  def initialize(*values)
    @size = 0
    @last = nil
    if values.size > 0
      values.each{ |value|  push(value) }
    end
  end

  def push(value)
    @size += 1
    lli = LinkedListItem.new(value)
    if @first_item
      last_item.next_item = lli
      @last = lli
    else
      @first_item = lli
      @last = @first_item
    end
  end

  def get(index,return_item=false)
    raise IndexError if index < 0 || index >= @size
    current_item = @first_item
    index.times do
      raise IndexError if current_item.nil?
      current_item = current_item.next_item
    end
    return_item ? current_item: current_item.payload
  end

  def last
    @last.nil? ? nil : @last.payload
  end

  def delete(index)
    if index === 0
      @first_item = @first_item.next_item
    else
      prev_item = get(index-1, true)
      item_to_delete = prev_item.next_item
      prev_item.next_item = item_to_delete.next_item
      @last = prev_item if item_to_delete.last?
    end
    @size -= 1
  end

  def index(value)
    count = 0
    lli = LinkedListItem.new(value)
    current_item = @first_item
    until current_item.nil?
      break if current_item == lli
      count += 1
      current_item = current_item.next_item
    end
    current_item == lli ? count : nil
  end

  def to_s
    show_list = "| "
    current_item = @first_item
    unless current_item.nil?
      until current_item.nil?
        show_list += current_item.last? ?  "#{current_item.payload} " : "#{current_item.payload}, "
        current_item = current_item.next_item
      end
    end
    show_list += "|"
  end

  def [](index)
    get(index)
  end

  def []=(index,value)
    get(index, true).payload = value
  end

  def sorted?
    return true if @size <= 1
    is_sorted = true
    prev_item = @first_item
    current_item = @first_item
    until current_item.last?
      current_item = prev_item.next_item
      return if prev_item > current_item
      prev_item = current_item
    end
    true
  end

  def swap_with_next(index)
    raise IndexError if index >= @size-1
    if index === 0
      itemA = @first_item
      itemB = @first_item.next_item
      itemC = itemB.next_item
      @first_item = itemB
      @first_item.next_item = itemA
      @first_item.next_item.next_item = itemC
    else
      itemA = get(index-1, true)
      itemB = itemA.next_item
      itemC = itemA.next_item.next_item

      itemA.next_item = itemC
      itemB.next_item = itemC.next_item
      itemC.next_item = itemB
    end
  end

  def sort!
    until sorted?
      current_item = @first_item
      count = 0
      until current_item.last?
#        puts " ###########Count is #{count}  #{self.to_s}"
        if current_item > current_item.next_item
          swap_with_next(count)
          current_item = get(count,true)
        end
        current_item = current_item.next_item
        count += 1
      end
    end
  end

  private
  def last_item
      current_item = @first_item
      until current_item.last?
        current_item = current_item.next_item
      end
      current_item
  end


end

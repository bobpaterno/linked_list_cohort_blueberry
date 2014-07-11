class LinkedList
  attr_accessor :size

  def initialize(*value)
    @size = 0
    @last = nil
    if value.size > 0
      value.each{ |value|  push(value) }
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
    raise IndexError if index < 0
    current_item = @first_item
    index.times do
      raise IndexError if current_item.nil?
      current_item = current_item.next_item
    end
    return_item ? current_item: current_item.payload
  end

  def last
    if @last.nil?
      nil
    else
      @last.payload
    end
  end

  def delete(index)
    @size -= 1
    if index === 0
      @first_item = @first_item.next_item
    else
      item_to_delete = get(index,true)
      prev_item = get(index-1, true)
      prev_item.next_item = item_to_delete.next_item
      @last = prev_item if item_to_delete.last?
      item_to_delete = nil
    end
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
    show_list
  end

  def [](index)
    get(index)
  end

  def []=(index,value)
    get(index, true).payload = value
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

module Nextable
  extend ActiveSupport::Concern

  def set_next(max_prio)
    if priority < (max_prio -  1)
      self.next = priority + 1
    else
      self.next = nil
    end
  end

  def set_prev
    if self.priority == 0
      self.prev = nil
    else
      self.prev = self.priority - 1
    end
  end

  def set_next_on_collection!(collection)
    collection.each do |item|
      item.set_next collection.size
      item.save!
    end
  end

  def set_prev_on_collection!(collection)
    collection.each do |item|
      item.set_prev
      item.save!
    end
  end
end

class Time
  # 03/03/2014 7:59am
  def to_8601
    self.strftime('%m/%d/%Y %l:%M%p').downcase
  end

  # Mar 3, 2014 7:59am
  def to_human
    "#{self.strftime('%b %d, %Y')} #{self.strftime('%l:%M%p').downcase}"
  end
end

class Date
  # 03/03/2014
  def to_8601
    self.strftime('%m/%d/%Y')
  end

  # Mar 3, 2014
  def to_human
    self.strftime('%b %d, %Y')
  end
end

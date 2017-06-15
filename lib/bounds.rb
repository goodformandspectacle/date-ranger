module Bounds
  def day_bounds str, side
    if side == :start
      start_of_day str
    else
      end_of_day str
    end
  end

  def month_bounds str, side
    if side == :start
      start_of_month str
    else
      end_of_month str
    end
  end

  def year_bounds str, side
    if side == :start
      start_of_year str
    else
      end_of_year str
    end
  end

  def decade_bounds str, side
    if side == :start
      start_of_decade str
    else
      end_of_decade str
    end
  end

  def start_of_day str
    date = Date._parse(str)
    Date.new(date[:year], date[:mon], date[:mday])
  end

  def end_of_day str
    start_of_day str
  end

  def start_of_month str
    if str.include? '-'
      deal_with_hyphenated_month str, 1
    else
      date = Date._parse(str)
      Date.new(date[:year], date[:mon], 1)
    end
  end

  def end_of_month str
    if str.include? '-'
      deal_with_hyphenated_month str, -1
    else
      date = Date._parse(str)
      Date.new(date[:year], date[:mon], -1)
    end
  end

  def start_of_year str
    Date.new(str.to_i, 1, 1)
  end

  def end_of_year str
    Date.new(str.to_i, 12, 31)
  end

  def start_of_decade str
    Date.new(str.to_i, 1, 1)
  end

  def end_of_decade str
    Date.new(str.to_i + 9, 12, 31)
  end

end

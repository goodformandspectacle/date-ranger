require 'date'

DateRanger = Struct.new(:date_str) do
  def parse
    # basic cleanup
    date_str.gsub!('c.', '')
    date_str.gsub!('circa', '')
    date_str.strip!

    if date_str.include? 'n.d.'
      # no date marker
      ranger_hash(nil, nil)
    elsif (date_str.end_with? 's')
      # we know that we’re dealing with a decade
      decade_str = date_str.chomp('s')
      ranger_hash(beginning_of_decade(decade_str), end_of_decade(decade_str))
    elsif (is_year?(date_str))
      # we have just a 4-digit year
      ranger_hash(beginning_of_year(date_str), end_of_year(date_str))
    elsif (is_month_and_year?(date_str))
      # we have a 'Nov 1756' or 'Feb-1945' format
      ranger_hash(beginning_of_month(date_str), end_of_month(date_str))
    elsif (is_day_month_and_year?(date_str))
      # we have a '23 Feb 1985' format
      ranger_hash(beginning_of_day(date_str), end_of_day(date_str))
    end
  end

  def ranger_hash beginning_date, end_date
    { beginning_date: beginning_date, end_date: end_date }
  end

  def beginning_of_day day_str
    date = Date._parse(day_str)
    Date.new(date[:year], date[:mon], date[:mday])
  end

  def end_of_day day_str
    beginning_of_day day_str
  end

  def beginning_of_month month_str
    date = Date._parse(month_str)
    Date.new(date[:year], date[:mon], 1)
  end

  def end_of_month month_str
    date = Date._parse(month_str)
    Date.new(date[:year], date[:mon], -1)
  end

  def beginning_of_year year_str
    Date.new(year_str.to_i, 1, 1)
  end

  def end_of_year year_str
    Date.new(year_str.to_i, 12, 31)
  end

  def beginning_of_decade decade_str
    Date.new(decade_str.to_i, 1, 1)
  end

  def end_of_decade decade_str
    Date.new(decade_str.to_i + 9, 12, 31)
  end

  def is_year?(date_str, start_time=1500, end_time=2099)
    # check that we have only the year
    (start_time..end_time).include?(date_str.to_i)
  end

  def is_month_and_year? date_str
    # check that we have only month and year
    date_hash = Date._parse(date_str)
    date_hash.has_key?(:year) and date_hash.has_key?(:mon) and !date_hash.has_key?(:mday)
  end

  def is_day_month_and_year? date_str
    Date.strptime(date_str, '%d %b %Y') rescue false
  end

  def cleanup str
    str.gsub!('c.', '')
    str.gsub!('circa', '')
    str.strip!
  end

end

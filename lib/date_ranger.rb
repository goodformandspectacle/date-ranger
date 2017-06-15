require 'date'
require 'bounds'

DateRanger = Struct.new(:date_str) do
  include Bounds

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
      ranger_hash(decade_bounds(decade_str, :start), decade_bounds(decade_str, :end))
    elsif (is_year?(date_str))
      # we have just a 4-digit year
      ranger_hash(year_bounds(date_str, :start), year_bounds(date_str, :end))
    elsif (is_month_and_year?(date_str))
      # we have a 'Nov 1756', 'Feb-1945' or 'Feb-45' format
      ranger_hash(month_bounds(date_str, :start), month_bounds(date_str, :end))
    elsif (is_day_month_and_year?(date_str))
      # we have a '23 Feb 1985' or '23-Feb-1985' format
      ranger_hash(day_bounds(date_str, :start), day_bounds(date_str, :end))
    end
  end

  def ranger_hash start_date, end_date
    { start_date: start_date, end_date: end_date }
  end

  def is_year?(date_str, start_time=1500, end_time=2099)
    # check that we have only the year
    (start_time..end_time).include?(date_str.to_i)
  end

  def is_month_and_year? date_str
    # check that we have only month and year
    date_hash = Date._parse(date_str)
    (date_hash.has_key?(:year) and date_hash.has_key?(:mon) and !date_hash.has_key?(:mday)) or Date.strptime(date_str, '%b-%y') rescue false
  end

  def is_day_month_and_year? date_str
    Date.strptime(date_str, '%d %b %Y') rescue false or Date.strptime(date_str, '%d-%b-%Y') rescue false
  end

  def deal_with_hyphenated_month month_str, day_int
    date = nil
    if month_str.match(/\d{4}/)
      # 4-digit year
      date = Date.strptime(month_str, '%b-%Y') rescue nil
      Date.new(date.year, date.month, day_int)
    else
      # 2-digit year
      str = month_str.split('-')
      Date.new("19#{str[1]}".to_i, Date::ABBR_MONTHNAMES.index(str[0]) , day_int)
    end
  end
end

require 'date_ranger'

RSpec.describe 'DateRanger' do
  def result_hash start_date, end_date
    { start_date: start_date, end_date: end_date }
  end

  describe 'single dates' do
    it 'converts 1990s to a range covering the nineties' do
      date_str = '1990s'
      beginning_of_nineties = Date.new(1990, 1, 1)
      end_of_nineties = Date.new(1999, 12, 31)
      expect(DateRanger.new(date_str).parse).to eq result_hash(beginning_of_nineties, end_of_nineties)
    end

    it 'converts n.d. to no date' do
      date_str = 'n.d.'
      expect(DateRanger.new(date_str).parse).to eq result_hash(nil, nil)
    end

    it 'converts a year to a year range' do
      date_str = '1975'
      expect(DateRanger.new(date_str).parse).to eq result_hash(Date.new(1975, 1, 1), Date.new(1975, 12, 31))
    end

    it 'converts c. 1856 type date to a year range' do
      date_str = 'c. 1945'
      expect(DateRanger.new(date_str).parse).to eq result_hash(Date.new(1945, 1, 1), Date.new(1945, 12, 31))
    end

    it 'converts a month to a month range' do
      date_str = 'Nov 1867'
      expect(DateRanger.new(date_str).parse).to eq result_hash(Date.new(1867, 11, 1), Date.new(1867, 11, 30))
    end

    it 'converts a month with a hyphen to a month range' do
      date_str = 'Nov-1867'
      expect(DateRanger.new(date_str).parse).to eq result_hash(Date.new(1867, 11, 1), Date.new(1867, 11, 30))
    end

    it 'converts a month with a two digit year  and a hyphen to a month range' do
      date_str = 'Nov-67'
      expect(DateRanger.new(date_str).parse).to eq result_hash(Date.new(1967, 11, 1), Date.new(1967, 11, 30))
    end

    it 'converts c. Nov 1856 type date to a month range' do
      date_str = 'c. Nov 1945'
      expect(DateRanger.new(date_str).parse).to eq result_hash(Date.new(1945, 11, 1), Date.new(1945, 11, 30))
    end

    it 'converts 17 Feb 1945 date to a day range' do
      date_str = '17 Feb 1945'
      expect(DateRanger.new(date_str).parse).to eq result_hash(Date.new(1945, 2, 17), Date.new(1945, 2, 17))
    end

    it 'converts 17-Feb-1945 date to a day range' do
      date_str = '17-Feb-1945'
      expect(DateRanger.new(date_str).parse).to eq result_hash(Date.new(1945, 2, 17), Date.new(1945, 2, 17))
    end
  end

  describe 'compound dates' do
    it 'converts 1865-1866 to the right range' do
      date_str = '1865-1866'
      expect(DateRanger.new(date_str).parse).to eq result_hash(Date.new(1865, 1, 1), Date.new(1866, 12, 31))
    end

    it 'converts 1865-1866 to the right range even with spaces' do
      date_str = '1865 - 1866'
      expect(DateRanger.new(date_str).parse).to eq result_hash(Date.new(1865, 1, 1), Date.new(1866, 12, 31))
    end

    it 'converts 1856-15 Feb 1857 to the right range' do
      date_str = '1856-15 Feb 1857'
      expect(DateRanger.new(date_str).parse).to eq result_hash(Date.new(1856, 1, 1), Date.new(1857, 2, 15))
    end

    it 'converts Feb 1875-Mar 1875 to the right range' do
      date_str = 'Feb 1875-Mar 1875'
      expect(DateRanger.new(date_str).parse).to eq result_hash(Date.new(1875, 2, 1), Date.new(1875, 3, 31))
    end

    it 'converts 1834-1990s to the right range' do
      date_str = '1834-1990s'
      expect(DateRanger.new(date_str).parse).to eq result_hash(Date.new(1834, 1, 1), Date.new(1999, 12, 31))
    end

    it 'converts Jan 1995 - c. 1997 to the right range' do
      date_str = 'Jan 1995 - c. 1997'
      expect(DateRanger.new(date_str).parse).to eq result_hash(Date.new(1995, 1, 1), Date.new(1997, 12, 31))
    end
  end

  describe 'compound dates where the first part is missing year info' do
    it 'converts Jan - Mar 1995 to the right range' do
      date_str = 'Jan - Mar 1995'
      expect(DateRanger.new(date_str).parse).to eq result_hash(Date.new(1995, 1, 1), Date.new(1995, 3, 31))
    end

    it 'converts 21 Mar - 23 Mar 1985 to the right range' do
      date_str = '21 Mar - 23 Mar 1985'
      expect(DateRanger.new(date_str).parse).to eq result_hash(Date.new(1985, 3, 21), Date.new(1985, 3, 23))
    end
  end

  describe 'compound dates where the first part is missing month and year info' do
    it 'converts 21 - 23 Mar 1985 to the right range' do
      date_str = '21 - 23 Mar 1985'
      expect(DateRanger.new(date_str).parse).to eq result_hash(Date.new(1985, 3, 21), Date.new(1985, 3, 23))
    end
  end
end

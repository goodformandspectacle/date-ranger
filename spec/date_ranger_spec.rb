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

  end
end

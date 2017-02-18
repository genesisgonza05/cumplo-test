class SBIFApi

  attr_accessor :message_errors

  def initialize
    @message_errors = ""
    @sbif = SBIF.new(api_key: ENV["SBIF_KEY"]) unless Rails.env.test?
    @start_date = @start_date ? @start_date : current
    @end_date = @end_date ? @end_date : current
  end

  def range_by(start_date, end_date)
    @start_date = to_date(start_date)
    @end_date = to_date(end_date)
  end

  def dollars_report
    dollars = []
    (@start_date..@end_date).each do |date|
      dollars.push(OpenStruct.new(date: date, value: dolar_by(date)))
    end
    dollars
  end

  def uf_report
    ufs = []
    (@start_date..@end_date).each do |date|
      ufs.push(OpenStruct.new(date: date, value: uf_by(date)))
    end
    ufs
  end

  def ranges_valid?(ranges)
    start_date = to_date(ranges[:start_date])
    end_date = to_date(ranges[:end_date])
    validate_ranges(start_date, end_date) if @message_errors.blank?
    @message_errors.blank?
  end

  def minmax_value(array)
    array_only_values(array).map(&:to_f).minmax
  end

  def average(array)
    values = array_only_values(array)
    (values.inject(0.0) { |sum, el| sum + el } / values.size).round(2)
  end

  private

  def array_only_values(array)
    values = []
    array.each{|arr| values.push(arr.value)}
    values
  end

  def validate_ranges(start_date, end_date)
    @message_errors = "End Date must be greater than Start Date." if start_date > end_date
  end

  def to_date(string)
    begin
      Date.strptime(string, "%m/%d/%Y")
    rescue TypeError
      @message_errors = date_error
    rescue ArgumentError
      @message_errors = date_error
    end
  end

  def date_error
  	"Date Invalid."
  end

  def uf_by(date)
    uf = @sbif.uf(
      day: day_formated(date),
      month: month_formated(date),
      year: year_formated(date))
    uf ? uf : 0
  end

  def dolar_by(date)
    dollar = @sbif.dolar(
      day: day_formated(date),
      month: month_formated(date),
      year: year_formated(date))
    dollar ? dollar : 0
  end

  def current
    DateTime.now
  end

  def day_formated(date)
    date.day.to_i
  end

  def month_formated(date)
    date.month.to_i
  end

  def year_formated(date)
    date.year.to_i
  end

end
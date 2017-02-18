class SBIFSuccessful

  attr_accessor :message_errors

  def initialize
    @message_errors = ""
  end

  def range_by(start_date, end_date)
    @start_date = to_date(start_date)
    @end_date = to_date(end_date)
  end

  def dollars_report
    array_returned
  end

  def uf_report
    array_returned
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

  def validate_ranges(start_date, end_date)
    @message_errors = "error" if start_date > end_date
  end

  def array_returned
    [
      OpenStruct.new(date: "Mon, 06 Feb 2017", value: 200.0),
      OpenStruct.new(date: "Mon, 07 Feb 2017", value: 0.0)
    ]    
  end

  def to_date(string)
    Date.strptime(string, "%m/%d/%Y")
  end

  def array_only_values(array)
    values = []
    array.each{|arr| values.push(arr.value)}
    values
  end

end
class Chartr::Chartdata
  attr_accessor :title, :xticks, :data, :label
  
  def initialize(data, title = nil)
    @title = title
    @data = build_data_array(data)
  end
  
private  
  # builds an array containing a series of arrays representing
  # the actual dataset associated with the xTicks.
  def build_data_array(data)
    r = []
    data.each_index do |x|
      a = [x, data[x]]
      r << a
    end
    r
  end
end
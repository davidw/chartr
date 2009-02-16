class Chartr::BarChart < Chartr::Chart
  attr_accessor :data

  def initialize(params = {})
    @options = { :bars => { :show => true } }
    super
  end

end

require "chartdata"
include ActiveSupport

class Chart  
  attr_accessor :options, :dataset
  def initialize(params = {})
    # params = params.reverse_merge!({ :colorScheme => "blue", 
    #                                  :backgroundColor => "#f2f2f2",
    #                                  :barOrientation => "vertical"})
    # @options = {
    #   :axis => {
    #     :lineWidth     => 1.0,
    #     :lineColor     => '#000000',
    #     :tickSize      => 3.0,
    #     :labelColor    => '#666666',
    #     :labelFont     => 'Tahoma',
    #     :labelFontSize => 9,
    #     :labelWidth    => 50.0,
    #     :x => {
    #       :hide          => false,
    #       :ticks         => nil,
    #       :tickCount     => 10,
    #       :tickPrecision => 1,
    #       :values        => nil
    #     },
    #     :y => {
    #       :hide          => false,
    #       :ticks         => nil,
    #       :tickCount     => 10,
    #       :tickPrecision => 1,
    #       :values        => nil
    #     }
    #   },
    #   :background => {
    #     :color     => params[:backgroundColor],
    #     :hide      => false,
    #     :lineColor => '#ffffff',
    #     :lineWidth => 1.5
    #   },
    #   :legend => {
    #     :opacity     => 0.8,
    #     :borderColor => '#000000',
    #     :style       => {},
    #     :hide        => false,
    #     :position    => {:top => '20px', :left => '40px'}
    #   },
    #   :padding => {
    #     :left   => 30,
    #     :right  => 30,
    #     :top    => 5,
    #     :bottom => 10
    #   },
    #   :stroke => {
    #     :color => '#ffffff',
    #     :hide => false,
    #     :shadow => true,
    #     :width => 2
    #   },
    #   :fillOpacity          => 1.0,
    #   :shouldFill           => true,
    #   :barWidthFillFraction => 0.75,
    #   :barOrientation       => params[:barOrientation],
    #   :xOriginIsZero        => true,
    #   :yOriginIsZero        => true,
    #   :pieRadius            => 0.4,
    #   :colorScheme          => params[:colorScheme]
    # }
    
    @axis = "x"
    @labels = []
    @xLabels = []
    @dataset = {}
    @xticks = []
    @title = nil
  end
  
  def add_data(chartdata)
    if @xLabels.any?
      title = @xLabels[@dataset.size]
    end
    @dataset[(chartdata.title || title || "Data #{(@dataset.size+1).to_s}")] = chartdata.data
  end
  
  def add_xtick(label)
    @xticks.push({:v => @xticks.size, :label => label})
  end
  
  def xLabels=(labels)
    @xLabels = labels
  end
  
  def set_xticks
    @xLabels.each do |label|
      self.add_xtick(label)
    end
    
    # Default to the dataset titles if no labels
    # have been explicitly given.
    if @xticks.empty?
      @dataset.each do |data|
        self.add_xtick(data.first)
      end
    end
  end
  
  def options
    self.set_xticks
    @options[:axis][@axis.to_sym][:ticks] = @xticks
    @options
  end
end
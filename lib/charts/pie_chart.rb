class PieChart < Chart
  def initialize(params = {})
    super
    params = params.reverse_merge!({ :axisLabelColor      => "#000000",
                                     :axisLabelFont       => "Tahoma",
                                     :axisLabelFontSize   => 9,
                                     :axisLabelWidth      => 50.0,
                                     :axisLineWidth       => 1.0,
                                     :axisLineColor       => "#000000",
                                     :axisTickSize        => 3.0,
                                     :backgroundColor     => "#f2f2f2",
                                     :colorScheme         => "blue", 
                                     :legendPositionTop   => "20px",
                                     :legendPositionLeft  => "40px",
                                     :legendHide          => false,
                                     :paddingLeft         => 30,
                                     :paddingRight        => 0,
                                     :paddingTop          => 10,
                                     :paddingBottom       => 30,
                                     :pieRadius           => "0.4" })
    @options = { 
      # Define a padding for the canvas node
      :padding => {
        :left   => params[:paddingLeft], 
        :right  => params[:paddingRight], 
        :top    => params[:paddingTop], 
        :bottom => params[:paddingBottom]
      },
      
      # Legend positioning.
      :legend => {
        :hide     => params[:legendHide],
        :position => {
          :top  => params[:legendPositionTop],
          :left => params[:legendPositionLeft]
        }
      },
      
      # Background color to render.
      :background => { :color => params[:backgroundColor] },
      
      # Use the predefined blue colorscheme.
      :colorScheme => params[:colorScheme],
      
      :axis => {
        :lineWidth      => params[:axisLineWidth],
        :lineColor      => params[:axisLineColor],
        :tickSize       => params[:axisTickSize],
        :labelColor     => params[:axisLabelColor],
        :labelFont      => params[:axisLabelFont],
        :labelFontSize  => params[:axisLabelFontSize],
        :labelWidth     => params[:axisLabelWidth],
        :x              => {
          :ticks => nil
        }
      },
      
      :pieRadius => params[:pieRadius]
    }
  end
  
  def set_xticks
    @dataset.each do |data|
      @xLabels.each do |label|
        if data.first == label
          self.add_xtick(label)
        end
      end
    end
    
    if @xticks.empty?
      super
    end
  end
  
  def output(canvasname = (@title || "chart"))
    o = "var chart = new Plotr.PieChart(#{canvasname.to_json}, #{self.options.to_json});
        chart.addDataset(#{@dataset.to_json});
        chart.render();"
  end
end
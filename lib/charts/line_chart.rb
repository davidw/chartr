class Chartr::LineChart < Chartr::Chart
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
                                     :barOrientation      => "vertical",
                                     :colorScheme         => "blue", 
                                     :fillOpacity         => 1.0,
                                     :legendPositionTop   => "20px",
                                     :legendPositionLeft  => "40px",
                                     :legendHide          => false,
                                     :paddingLeft         => 30,
                                     :paddingRight        => 0,
                                     :paddingTop          => 10,
                                     :paddingBottom       => 30,
                                     :shouldFill          => true,
                                     :strokeColor         => "#ffffff",
                                     :strokeHide          => false,
                                     :strokeShadow        => true,
                                     :strokeWidth         => 2,
                                     :xOriginIsZero       => true,
                                     :yOriginIsZero       => true })
    @options = { 
      :barOrientation => params[:barOrientation],
      
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
      
      :stroke => {
        :color  => params[:strokeColor],
        :hide   => params[:strokeHide],
        :shadow => params[:strokeShadow],
        :width  => params[:strokeWidth]
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
      
      :fillOpacity    => params[:fillOpacity],
      :shouldFill     => params[:shouldFill],
      :xOriginIsZero  => params[:xOriginIsZero],
      :yOriginIsZero  => params[:yOriginIsZero]
    }
  end
  
  def output(canvasname = (@title || "chart"))
    o = "var chart = new Plotr.LineChart(#{canvasname.to_json}, #{self.options.to_json});
        chart.addDataset(#{@dataset.to_json});
        chart.render();"
  end
end
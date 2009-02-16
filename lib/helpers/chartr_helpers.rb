module ActionView::Helpers
  module ChartrHelpers
    # easy way to include Chartr assets
    def chartr_includes
      javascript_include_tag "chartr/canvas2image.js", "chartr/canvastext.js", "chartr/flotr-min"
    end
  end
end

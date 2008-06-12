module ActionView::Helpers
  module ChartrHelpers
    # easy way to include Chartr assets
    def chartr_includes
      javascript_include_tag "chartr/excanvas", "chartr/plotr"
    end
  end
end
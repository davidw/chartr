##
## Constants
##

PLOTR_VERSION = "0.3.0"

##
## Load the library
##
require 'chartr'
require 'helpers/chartr_helpers'

##
## Inject includes for Chartr libraries
##
ActionView::Base.send(:include, ActionView::Helpers::ChartrHelpers)
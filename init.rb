# require File.dirname(__FILE__) + '/install'

ActionView::Base.class_eval do
  include BetterSelect::FormHelpers
  include BetterSelect::TimeHelpers
end
 

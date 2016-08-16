require 'logger'
require_relative 'controllers/publishing_controller.rb'

module NuviApplication

  publishing_controller = PublishingController.new

  publishing_controller.run
  
end
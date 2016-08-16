require_relative 'constraints/yml_load_attributes'
require "singleton"

module NuviApplication

  class Config
    include Singleton
    include YmlLoadAttributes

    def initialize
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::DEBUG

      self.configure(File.join(File.dirname(__FILE__), 'config.yml'))
      Dir[File.join(File.dirname(__FILE__), '/initializers/*_initializer.rb')].each do |file| 
          require file
          module_name = File.basename(file, ".rb")
          extend "ContentfulApplication::#{module_name.classify}".safe_constantize
      end
    end

    def logger
      @logger
    end

  end

end
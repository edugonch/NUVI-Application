require 'yaml'

module NuviApplication

  module YmlLoadAttributes

    def configure(yml_file)
      config = YAML::load_file(yml_file)
      parse_config config
    end

    def parse_config(config)
      config.each do |key, value|
        setter = "#{key}="
        self.class.send(:attr_accessor, key) if !respond_to?(setter)
        send setter, value
      end
    end

  end
  
end
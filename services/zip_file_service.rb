require 'logger'
require 'zip'
require_relative '../util/data_accessable'
require_relative '../config'

module NuviApplication
  class ZipFileService

    def proces_zip_file(file_name)
      Config.instance.logger.info "Extracting #{file}"
      Zip::File.open("/tmp/#{file_name}") do |zipfile|
        zipfile.each do |filetmp|
          xml_content = filetmp.get_input_stream.read
          DataAccessable.instance.push_to_list(Config.instance.redis['list'], xml_content)
        end
      end
      DataAccessable.instance.push_to_list(Config.instance.redis['list_procesed_files'], file_name)
      Config.instance.logger.info "Successfully process zip file #{file}"

      rescue Exception => ex
        Config.instance.logger.error "The file #{file_name} could not be processed, exception raise - #{ex.message}"
    end

  end
end
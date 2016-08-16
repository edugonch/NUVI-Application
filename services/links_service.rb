require 'logger'
require 'open-uri'
require 'redis'
require_relative '../util/data_accessable'
require_relative '../config'

module NuviApplication
  class LinkService

    def get_remote_links
      open(Config.instance.reports['url']) { |io| io.read }
    rescue Exception => ex
      Config.instance.logger.error "There was an exception while trying to get the links from the remote source - #{ex.message}."
      exit
    end

    def get_storage_links
      DataAccessable.instance.get_all_elements(Config.instance.redis['list_procesed_files'])
    end

    def get_file_from_link(file_name)
      Config.instance.logger.info "Downloading #{file_name} into /temp"
      `wget #{Config.instance.reports['url']}#{file_name} -O /tmp/#{file_name}`
      Config.instance.logger.info "Successfully downloaded #{file_name} into /temp"
    rescue Exception => ex
      Config.instance.logger.error "There was an exception while trying to get the remote file - #{ex.message}."
      exit
    end

    def delete_file(file_name)
      File.delete("/tmp/#{file_name}")
    end
  end
end
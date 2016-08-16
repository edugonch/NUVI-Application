require_relative '../models/news'
require_relative '../services/links_service'
require_relative '../services/zip_file_service'
require_relative '../config'


module NuviApplication
  class PublishingController

    def run
      links_service = LinkService.new
      zip_file_service = ZipFileService.new

      news = News.new(links_service.get_remote_links)
      files_to_parse = news.get_filter_links(links_service.get_storage_links)

      files_to_parse.each do |file_name|
        links_service.get_file_from_link(file_name)
        zip_file_service.proces_zip_file(file_name)
        links_service.delete_file(file_name)
      end
    end

  end
end
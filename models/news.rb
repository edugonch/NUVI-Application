require_relative '../util/data_accessable'

module NuviApplication
  class News

    @regex_for_links = /href=["|'](.+\.zip)["|']/i

    def initialize(links)
      @links = links.scan(/href=["|'](.+\.zip)["|']/i).flatten
    end

    def get_filter_links(links_to_filter)
      files_to_parse = @links - links_to_filter
    end

  end
end
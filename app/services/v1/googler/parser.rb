module V1::Googler
  class Parser
    attr_accessor :result_page, :domain

    def initialize(result_page, domain)
      @result_page = result_page
      @domain = domain
    end

    def get_page_rank
      google_attributes = V1::Googler::GOOGLE_ATTRIBUTES
      count = 0
      result_page.search(google_attributes["link"]).each do |result|
        count = count + 1
        google_aff_link = result.attr(google_attributes["attr"])
        url = clean(google_aff_link)
        google_page_domain = get_domain(url)
        if google_page_domain == domain
          parser_result = {}
          parser_result['url'] = url
          parser_result['position'] = count
          return parser_result
        end
      end
    end

    def clean(google_aff_link)
      google_aff_link.split('q=')[1].split('&')[0]
    end

    def get_domain(url)
      domainatrix_object = Domainatrix.parse(url)
      domainatrix_object.domain
    end

  end
end

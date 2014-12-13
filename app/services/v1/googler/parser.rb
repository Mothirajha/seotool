module V1::Googler
  class Parser
    attr_accessor :result_page, :domain

    def initialize(result_page, domain, public_suffix, subdomain)
      @result_page = result_page
      @domain = domain
      @public_suffix = public_suffix
      @subdomain = subdomain
    end

    def get_page_rank
      google_attributes = V1::Googler::GOOGLE_ATTRIBUTES
      count = 0
      @result_page.search(google_attributes["resultant_row"]).each do |result|
        if result.at(google_attributes["link"]).present?
          google_aff_link = result.at(google_attributes["link"]).attr(google_attributes["attr"])
          url = clean(google_aff_link)
          if uri?(url)
            count = count + 1
            google_page_domain = get_domain(url)
            google_page_subdomain = get_subdomain(url)
            google_page_public_suffix = get_public_suffix(url)
            if google_page_domain == @domain && google_page_subdomain == @subdomain && google_page_public_suffix == @public_suffix
              parser_result = {}
              parser_result['url'] = url
              parser_result['position'] = count
              return parser_result
            end
          end
        else
          next
        end
      end
    end

    def clean(google_aff_link)
      google_aff_link.split('q=')[1].split('&')[0]
    end

    def get_domain(url)
      domainatrix_object = get_domainatrix_object(url)
      domainatrix_object.domain
    end

    def get_public_suffix(url)
      domainatrix_object = get_domainatrix_object(url)
      domainatrix_object.public_suffix
    end

    def get_subdomain(url)
      domainatrix_object = get_domainatrix_object(url)
      domainatrix_object.subdomain
    end

    def get_domainatrix_object(url)
      Domainatrix.parse(url)      
    end
    def uri?(string)
      uri = URI.parse(string)
      %w( http https ).include?(uri.scheme)
    rescue URI::BadURIError
      false
    rescue URI::InvalidURIError
      false
    end

  end
end

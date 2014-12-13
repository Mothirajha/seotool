module V1::Googler

  class Scrap
    attr_accessor :engine, :keyword, :domain, :agent, :google_form, :result_page
    def initialize engine, domain, keyword
      @engine = engine
      @domain = get_proper_domain_name(domain)
      @public_suffix = get_public_suffix(domain)
      @subdomain = get_subdomain(domain)
      @keyword = keyword
    end

    def get_proper_domain_name(url)
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

    def get_keyword_position
      get_google_form
      get_first_result_page
      parser_result = parser(@result_page)
      to_hash(parser_result)
    end

    def get_keyword_position_on_100_result
      search_parameter = V1::Googler::GOOGLE_ATTRIBUTES['search_parameter']
      clean_keyword = clean_keyword(@keyword)
      @agent = Mechanize.new
      result_page = @agent.get @engine + search_parameter + clean_keyword
      parser_result = parser(result_page)
      to_hash(parser_result)
    end

    def get_google_form
      @agent = Mechanize.new
      home_page = @agent.get @engine
      @google_form = home_page.form
    end

    def get_first_result_page
      @google_form['q'] = @keyword
      @result_page = google_form.submit
    end

    def parser(result_page)
      parser_obj = V1::Googler::Parser.new(result_page, @domain, @public_suffix, @subdomain)
      parser_result = parser_obj.get_page_rank
    end

    def clean_keyword(keyword)
      keyword.split(' ').join('+')
    end

    def to_hash(parser_result)
      result = {}
      result["domain"] = @domain
      result["search_engine"] = @engine
      result["position"] = nil
      return result if parser_result == 0
      result["url"] = parser_result["url"]
      result["position"] = parser_result["position"]
      result["page_number"] = calculate_page(parser_result["position"])
      return result
    end

    def calculate_page(position)
      if position%10 == 0
        position/10
      else
        position/10 + 1
      end
    end
  end
end

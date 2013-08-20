module Calil

  class Library

    def self.find(params = {})

      params.merge!(appkey: ENV["CALIL_APP_KEY"]) unless params[:appkey]

      query = params.map {|k,v| "#{k}=#{CGI.escape(v.to_s)}" }.join("&").to_s
      url = "http://api.calil.jp/library?#{query}"

      libraries = []
      REXML::Document.new(open(url)).elements.each('Libraries/Library') do |element|
        libraries << Libray.new(element)
      end

      libraries
    end

    def initialize(element)
      @element = element
    end

    def method_missing(action, *args)

      if %w(systemid systemname libkey libid short formal url_pc address pref city post tel geocode category image).include? action.to_s
        @element.elements[action.to_s].text
      else
        super
      end

    end

  end
end

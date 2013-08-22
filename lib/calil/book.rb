module Calil

  class Book

    FIND_ENABLE_LIMIT = 100
    RETRY_LIMIT = 10
    RETRY_WAIT_TIME = 5

    module ContinueStatus
      CONTINUE = "1"
      CLOSE = "0"
    end

    def self.find(isbns, systemids, params = {})

      params.merge!({
        isbn: isbns.join(","),
        systemid: systemids.join(","),
        format: "xml"
      })

      params.merge!(appkey: ENV["CALIL_APP_KEY"]) unless params[:appkey]
      raise "calil appkey notfound" unless params[:appkey]

      session_id = nil
      continue_status = ContinueStatus::CONTINUE
      retry_count = 0
      http_response_body = nil

      RETRY_LIMIT.times do |count|

        retry_count = count

        http_response_body = request(params, session_id)

        REXML::Document.new(http_response_body).elements.each("result/continue") {|e| continue_status = e.text }
        REXML::Document.new(http_response_body).elements.each("result/session") {|e| session_id = e.text }

        break if continue_status == ContinueStatus::CLOSE

        sleep RETRY_WAIT_TIME

      end

      # retry limit error
      raise "retry error" if continue_status == ContinueStatus::CONTINUE && retry_count == (RETRY_LIMIT - 1)

      books = []
      REXML::Document.new(http_response_body).elements.each("result/books/book") do |element|
        books << Book.new(element)
      end
      books

    end

    def self.request(params, session = nil)

      params.merge!(session: session) if session
      query = params.map {|k,v| "#{k}=#{CGI.escape(v.to_s)}" }.join("&").to_s
      url = "http://api.calil.jp/check?#{query}"
      open(url).read

    end

    def initialize(element)

      @element = element
      @systems = []
      element.elements.each('system') do |system|
        @systems << Calil::System.new(system)
      end

    end

    def isbn
      @element.attributes["isbn"]
    end

    def calilurl
      @element.attributes["calilurl"]
    end

    def systems
      @systems
    end

    def reservable?
      # exsit reserveurl in current systems
      !!(@systems.find {|system| system.reservable? })
    end

    def reservables
      @systems.select {|system| system.reservable? }
    end

    def inspect
      attr_body = %w(isbn calilurl reservable?).map do |method_name|
        eval("\"#{method_name}: '#{send(method_name)}'\"")
      end.join(", ")

      systems_body = @systems.map do |sytem|
        sytem.inspect
      end.join(", ")

      "#<Book #{attr_body} systems: [#{systems_body}]>"
    end

  end

end

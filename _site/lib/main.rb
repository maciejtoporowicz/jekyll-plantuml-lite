require_relative "encoder.rb"
require 'net/http'

class Main
    def to_plantuml(content)
        encoded_content = Encoder.new.encode(content)
        server_response = Net::HTTP.get(URI("https://www.plantuml.com/plantuml/svg/#{encoded_content}"))
        return server_response.sub("<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>", "").force_encoding("utf-8")
    end
end
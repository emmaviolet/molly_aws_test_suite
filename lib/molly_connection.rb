require 'unirest'

AWS_URL = 'https://a84xihdz74.execute-api.eu-west-1.amazonaws.com/dev_toons/'

class MollyConnection

  CALL_TYPE = {
    test_connection: ["test-api", :get],
    create_incident: ["incident", :post]
  }
  HTTP_HEADERS = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  }

  def self.test_connection
    url_call(:test_connection)
  end

  def self.create_incident(incident_params)
    url_call(:create_incident, { user_id: "122353" })
  end

  def self.api_key(new_key)
    @@api_key = new_key
  end

  private

  def self.url_call(rest_method, params = nil)
    restful_method_name, http_method = CALL_TYPE[rest_method]
    case http_method
    when :post
      post(restful_method_name, params)
    when :get
      get(restful_method_name)
    else
      raise Exception.new('RESTful method missing')
    end
  end

  def self.get(rest_method)
    Unirest.get AWS_URL + rest_method,
      headers: HTTP_HEADERS
  end

  def self.post(rest_method, params)
    puts AWS_URL + rest_method
    Unirest.post AWS_URL + rest_method,
      headers: HTTP_HEADERS
  end

end

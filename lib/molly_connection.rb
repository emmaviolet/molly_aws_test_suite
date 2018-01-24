require 'unirest'

AWS_URL = 'https://a84xihdz74.execute-api.eu-west-1.amazonaws.com/dev_toons/'

class MollyConnection

  HTTP_HEADERS = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  }

  def self.test_connection
    get_from_molly_api('test-api')
  end

  def self.create_incident(incident_params)
    post_to_molly_api('incident', { user_id: "122353" })
  end

  private

  def self.post_to_molly_api(rest_method, params)
    Unirest.post AWS_URL + rest_method,
      headers: HTTP_HEADERS
  end

  def self.get_from_molly_api(rest_method)
    Unirest.get AWS_URL + rest_method,
      headers: HTTP_HEADERS
  end

end

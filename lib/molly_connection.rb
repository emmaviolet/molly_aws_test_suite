require 'unirest'


class MollyConnection


  def initialize(params)
    @aws_url = params[:api_url]
    @api_key = params[:api_key]
  end

  def test_connection
    get_from_molly_api('test-api')
  end

  def create_incident(incident_params)
    post_to_molly_api('incident', incident_params)
  end

  def aws_url
    @aws_url
  end

  def http_headers
    {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "x-api-key": @api_key
    }
  end

  private

  def post_to_molly_api(rest_method, params)
    Unirest.post @aws_url + rest_method,
      headers: http_headers,
      parameters: params.to_json
  end

  def get_from_molly_api(rest_method)
    Unirest.get @aws_url + rest_method,
      headers: http_headers
  end

end

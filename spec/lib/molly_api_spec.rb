require 'unirest'
require_relative '../../lib/molly_connection'

RSpec.describe MollyConnection do


  context "Incident" do

    let(:incident_params) { {
      client_id: 'some-client-co-uk',
      app_id: "test-server",
      reporter_email: "reporter@molly.com",
      reporter_name: "Molly Bulregard Server",
      incident_type: "API misuse",
      incident_description: "upsetting api use on an ongoing basis",
      named_party_name: "Toons"
    } }
    let(:http_headers) {
      {
        "Accept": "application/json",
        "Content-Type": "application/json"
      }
    }

    context "test connection" do

      it "should return working" do
        mc = new_molly_connection
        expect(mc.test_connection.body).to eq({"test" => "it's working"})
      end

      it "should require an API key" do
        mc = new_molly_connection({api_key: ''})
        response = mc.test_connection
        expect(response.code).to eq(403)
        expect(response.body).to eq({
          "message" => "Forbidden"
        })
      end

    end


    context "succesful incident creation" do

      it "should return a 200 response" do
        mc = new_molly_connection
        response = mc.create_incident(incident_params)
        expect(response.code).to eq(200)
      end

      it "should return a incident guid" do
        mc = new_molly_connection
        incident = mc.create_incident(incident_params).body
        expect(incident['incident_guid']).to be_a String
      end

    end

    context "creation fails" do

      [ :client_id,
        :app_id,
        :reporter_email,
        :reporter_name,
        :incident_type,
        :incident_description,
        :named_party_name ].each do |required_param|
          it "without a #{required_param}" do
            mc = new_molly_connection
            incident_without_required_param = incident_params
            incident_without_required_param.delete(required_param)
            response = mc.create_incident(incident_without_required_param)
            expect(response.code).to eq 400
          end
      end
    end
  end

  def new_molly_connection(params = {})
    MollyConnection.new({
      api_url: 'https://a84xihdz74.execute-api.eu-west-1.amazonaws.com/dev_toons/',
 #     api_url: 'localhost:8000/',
      api_key: '4vhGo3h1Kd8cSNONCCCge1jXLIHuE53p8t7Hl9JG'
    }.merge(params))
  end
end

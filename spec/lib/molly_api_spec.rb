require 'unirest'
require_relative '../../lib/molly_connection'

RSpec.describe MollyConnection do


  context "Incident" do

    let(:incident_params) { {
      client_id: 'this-is-pain-some-client-co-uk',
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

      xit "should return working" do
        mc = new_molly_connection
        expect(mc.test_connection.body).to eq({"test" => "it's working"})
      end

      xit "should require an API key" do
        mc = new_molly_connection({api_key: ''})
        response = mc.test_connection
        expect(response.code).to eq(403)
        expect(response.body).to eq({
          "message" => "Forbidden"
        })
      end

    end


    context "succesful incident creation" do

      xit "should require an API key" do
        mc = new_molly_connection({api_key: ''})
        response = mc.create_incident(incident_params)
        expect(response.code).to eq(403)
        expect(response.body).to eq({
          "message" => "Forbidden"
        })
      end

      xit "should return a 200 response" do
        mc = new_molly_connection
        response = mc.create_incident(incident_params)
        expect(response.code).to eq(200)
      end

      xit "should return a incident id" do
        mc = new_molly_connection
        puts incident_params
        incident = mc.create_incident(incident_params).body
        expect(incident['incident_id']).to be_a String
      end

      xit "should return incident object" do
        mc = new_molly_connection
        incident = mc.create_incident(incident_params).body
        incident.delete('incident_id')
        expect(incident.keys).to eq(incident_params.keys.collect {|k| k.to_s })
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
          xit "without a #{required_param}" do
            mc = new_molly_connection
            incident_without_required_param = incident_params
            incident_without_required_param.delete(required_param)
            response = mc.create_incident(incident_without_required_param)
            expect(response.code).to eq 400
          end
      end

      it "should not accept unspecified values" do
        puts "HHHHHH #{ENV['MOLLY_AWS_TEST_API_KEY']} HHHH"
        mc = new_molly_connection
        incident_with_extra_params = incident_params
        incident_with_extra_params['bad_key'] = "I'm trying to add a value I'm not supposed to"
        response = mc.create_incident(incident_with_extra_params)
        expect(response.code).to eq 400
      end
    end
  end

  def new_molly_connection(params = {})
    MollyConnection.new({
      api_url: ENV['MOLLY_AWS_TEST_URL'],
      api_key: ENV['MOLLY_AWS_TEST_API_KEY']
    }.merge(params))
  end end

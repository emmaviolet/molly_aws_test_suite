require 'unirest'
require_relative '../../lib/molly_connection'

RSpec.describe MollyConnection do


  context "Incident" do

    let(:incident_params) { {} }

    context "test connection" do

      it "should return working" do
        expect(MollyConnection.test_connection.body).to eq({"test" => "it's working"})
      end
    end


    context "creation" do

      it "should return a 200 response" do
        expect(MollyConnection.create_incident({}).code).to eq(200)
      end

      it "should return an incident object" do
        incident = MollyConnection.create_incident(incident_params).body
        expect(incident['incident_guid']).to be_a String
      end

      it "should require client_id"
      it "should make a post request"
    end
  end
end

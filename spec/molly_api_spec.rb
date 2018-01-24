require 'unirest'
require_relative '../molly_connection'

RSpec.describe MollyConnection do


  context "Incident" do

    let(:incident_params) { {} }

    context "test connection" do

      xit "should return working" do
        expect(MollyConnection.test_connection.body).to eq({"test" => "it's working"})
      end
    end


    context "creation" do

         it "should require client_id" do
           expect(MollyConnection.create_incident({}).code).to eq(400)
         end

         xit "should return an incident object" do
           expect(MollyConnection.create_incident(incident_params)).to be_a String
         end

         xit "should make a post request" do
         end

       end

    end

  end

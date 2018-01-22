RSpec.describe MollyConnection do

  context "Incident" do

    let(:incident_params) { {} }

    context "creation" do

      it "should return an incident object" do
        expect(MollyConnection.create_incident(incident_params)).to be_a String
      end

    end

  end

end

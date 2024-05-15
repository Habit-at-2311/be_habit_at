require "rails_helper"

RSpec.describe "Users", type: :request do 
	it "can create a new user" do 
		user = { email: "tigerwoods@gmail.com" }
		post "/api/v0/users", headers: { "Content-Type" => "application/json", "Accept" => "application/json" },
			params: user.to_json

		parsed = JSON.parse(response.body, symbolize_names: true)
	
		expect(response.status).to eq(200)
		expect(parsed.keys).to eq([:data])
		expect(parsed[:data]).to be_a Hash
		expect(parsed[:data].keys).to match_array([:id, :type, :attributes])
		expect(parsed[:data][:id]).to be_a String
		expect(parsed[:data][:id]).to eq(User.last.id.to_s)
		expect(parsed[:data][:type]).to eq("user")
		expect(parsed[:data][:attributes]).to be_a Hash
		expect(parsed[:data][:attributes].keys).to match_array([:email])
		expect(parsed[:data][:attributes][:email]).to be_a String
		expect(parsed[:data][:attributes][:email]).to eq(User.last.email)
	end

	it "will return an error if a proper email is not provided" do 
		post "/api/v0/users", headers: { "Content-Type" => "application/json", "Accept" => "application/json" },
			params: { email: " " }.to_json

		parsed = JSON.parse(response.body, symbolize_names: true)
		expect(response.status).to eq(422)
		expect(parsed.join(", ")).to eq("Email can't be blank, Email is invalid")
	end
end 
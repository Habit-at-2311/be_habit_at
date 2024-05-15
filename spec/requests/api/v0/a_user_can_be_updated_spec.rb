require "rails_helper"

RSpec.describe "Users", type: :request do 
	it "can update a user's data" do
		user = User.create!(email: "tigerwoods@gmail.com")
		expect(User.last.email).to eq("tigerwoods@gmail.com")
		expect(User.count).to eq(1)
		expect(user.id).to eq(User.last.id)

		patch "/api/v0/users/:id", headers: { "Content-Type" => "application/json", "Accept" => "application/json" },
			params: { id: user.id, email: "jordanspieth@gmail.com" }.to_json
		
		parsed = JSON.parse(response.body, symbolize_names: true)
		expect(response.status).to eq(200)
		expect(User.last.id.to_s).to eq(parsed[:data][:id])
		expect(User.last.email).to eq(parsed[:data][:attributes][:email])
		expect(User.last.email).to eq("jordanspieth@gmail.com")
	end

	it "will return an error if user id is not provided" do 
		patch "/api/v0/users/:id", headers: { "Content-Type" => "application/json", "Accept" => "application/json" },
			params: { email: "jordanspieth@gmail.com" }.to_json
	end
end 
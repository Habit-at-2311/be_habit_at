require "rails_helper"

RSpec.describe "Users", type: :request do 
	it "can delete a current user" do 
		user = User.create!(email: "tigerwoods@gmail.com")

		expect(User.count).to eq(1)
		expect(User.first.email).to eq("tigerwoods@gmail.com")

		delete "/api/v0/users/:user_id", headers: { "Content-Type" => "application/json", "Accept" => "application/json" },
			params: user.to_json

		parsed = JSON.parse(response.body, symbolize_names: true)
		
		expect(User.count).to eq(0)
		expect(response.status).to eq(200)
		expect(parsed).to eq({:message=> "User tigerwoods@gmail.com, was successfully deleted" })
	end

	it "will return an error if the user to be deleted can't be found" do 
		User.create!(email: "tigerwoods@gmail.com")

		expect(User.count).to eq(1)
		expect(User.first.email).to eq("tigerwoods@gmail.com")

		delete "/api/v0/users/:user_id", headers: { "Content-Type" => "application/json", "Accept" => "application/json" },
			params: { email: "wrong_email@yahoo.com" }.to_json
		
		parsed = JSON.parse(response.body, symbolize_names: true)
	
		expect(User.count).to eq(1)
		expect(response.status).to eq(404)
		expect(parsed).to eq({ :error=> "User not found" })
	end
end
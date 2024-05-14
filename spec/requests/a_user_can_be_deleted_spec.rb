require "rails_helper"

RSpec.describe "Users", type: :request do 
	it "can delete a current user" do 
		user = User.create!(email: "tigerwoods@gmail.com")
		expect(User.count).to eq(1)
		expect(User.first.email).to eq("tigerwoods@gmail.com")

		delete "/api/v0/users/:user_id", headers: { "Content-Type" => "application/json", "Accept" => "application/json" },
			params: user.to_json
		
		parsed = JSON.parse(response.body, symbolize_names: true)
	end
end
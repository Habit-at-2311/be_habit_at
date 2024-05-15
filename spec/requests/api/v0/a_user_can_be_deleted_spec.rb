require "rails_helper"

RSpec.describe "Users", type: :request do 
	it "can delete a current user" do 
		user = User.create!(name: "Tiger Woods", email: "tigerwoods@gmail.com")

		expect(User.count).to eq(1)
		expect(User.first.email).to eq("tigerwoods@gmail.com")

		delete "/api/v0/users/:user_id", headers: { "Content-Type" => "application/json", "Accept" => "application/json" },
			params: { id: user.id }.to_json

		parsed = JSON.parse(response.body, symbolize_names: true)
		
		expect(User.count).to eq(0)
		expect(response.status).to eq(200)
		expect(parsed).to eq({:message=> "User tigerwoods@gmail.com, was successfully deleted" })
	end

	it "will return an error if user ID not provided" do 
		user = User.create!(name: "Tiger Woods", email: "tigerwoods@gmail.com")

		expect(User.count).to eq(1)
		expect(User.first.email).to eq("tigerwoods@gmail.com")

		delete "/api/v0/users/:id", headers: { "Content-Type" => "application/json", "Accept" => "application/json" },
			params: { id: 283734 }.to_json
		
		parsed = JSON.parse(response.body, symbolize_names: true)
		
		expect(User.count).to eq(1)
		expect(response.status).to eq(404)
		expect(parsed).to eq({:errors=>[{:detail=>"Couldn't find User with 'id'=283734", :status_code=>404}]})
	end
end
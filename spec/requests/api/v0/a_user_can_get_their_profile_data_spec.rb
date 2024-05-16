require "rails_helper"

RSpec.describe "Users", type: :request do 
  it "can get user data" do 
    users = create_list(:user, 11)
		user = create(:user)

    get "/api/v0/users/#{user.id}", headers: { "Content-Type" => "application/json", "Accept" => "application/json" },
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
    expect(parsed[:data][:attributes].keys).to match_array([:name, :email])
    expect(parsed[:data][:attributes][:name]).to be_a String
    expect(parsed[:data][:attributes][:name]).to eq(user.name)
    expect(parsed[:data][:attributes][:email]).to be_a String
    expect(parsed[:data][:attributes][:email]).to eq(user.email)
	end

	it "will return an error if a user can't be found" do
		users = create_list(:user, 12)
		user = users.sample

		get "/api/v0/users/#{21232}", headers: { "Content-Type" => "application/json", "Accept" => "application/json" },
			params: user.to_json

		parsed = JSON.parse(response.body, symbolize_names: true)

		expect(response.status).to eq(404)
		expect(parsed).to eq({:errors=>[{:detail=>"Couldn't find User with 'id'=21232", :status_code=>404}]})
	end
end
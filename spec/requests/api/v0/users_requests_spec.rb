require "rails_helper"

RSpec.describe "Users", type: :request do 
  it "can get user data" do 
    create_list(:user, 11)
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

  it "can create a new user" do 
    user = { name: "Eldrick Woods", email: "tigerwoods@gmail.com" }
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
    expect(parsed[:data][:attributes].keys).to match_array([:name, :email])
    expect(parsed[:data][:attributes][:name]).to be_a String
    expect(parsed[:data][:attributes][:name]).to eq("Eldrick Woods")
    expect(parsed[:data][:attributes][:email]).to be_a String
    expect(parsed[:data][:attributes][:email]).to eq("tigerwoods@gmail.com")
  end

  it "will return an error if a proper email is not provided" do 
    post "/api/v0/users", headers: { "Content-Type" => "application/json", "Accept" => "application/json" },
      params: { email: " " }.to_json

    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(422)
    expect(parsed).to eq({:errors=>[{:detail=>"Record invalid", :status_code=>422}]})
  end

  it "can update a user's data" do
		user = User.create!(name: "Tiger Woods", email: "tigerwoods@gmail.com")
		expect(User.last.email).to eq("tigerwoods@gmail.com")
		expect(User.count).to eq(1)
		expect(user.id).to eq(User.last.id)

		patch "/api/v0/users/:id", headers: { "Content-Type" => "application/json", "Accept" => "application/json" },
			params: { id: user.id, email: "jordanspieth@gmail.com" }.to_json
		
		parsed = JSON.parse(response.body, symbolize_names: true)
		expect(response.status).to eq(200)
		expect(User.last.id.to_s).to eq(parsed[:data][:id])
		expect(User.last.name).to eq(parsed[:data][:attributes][:name])
		expect(User.last.email).to eq(parsed[:data][:attributes][:email])
		expect(User.last.email).to eq("jordanspieth@gmail.com")
	end

	it "will return an error if user id is not provided" do 
		patch "/api/v0/users/:id", headers: { "Content-Type" => "application/json", "Accept" => "application/json" },
			params: { email: "jordanspieth@gmail.com" }.to_json
		
		parsed = JSON.parse(response.body, symbolize_names: true)

		expect(response.status).to eq 404
		expect(parsed).to eq({:errors=>[{:detail=>"Couldn't find User without an ID", :status_code=>404}]})
	end

  it "can delete a current user" do 
		user = User.create!(name: "Tiger Woods", email: "tigerwoods@gmail.com")

		expect(User.count).to eq(1)
		expect(User.first.email).to eq("tigerwoods@gmail.com")

		delete "/api/v0/users/#{user.id}", headers: { "Content-Type" => "application/json", "Accept" => "application/json" },
			params: { user: user }.to_json

		parsed = JSON.parse(response.body, symbolize_names: true)
		
		expect(User.count).to eq(0)
		expect(response.status).to eq(200)
		expect(parsed).to eq({:message=> "User tigerwoods@gmail.com, was successfully deleted" })
	end

	it "will return an error if user ID is incorrect" do 
		user = User.create!(name: "Tiger Woods", email: "tigerwoods@gmail.com")

		expect(User.count).to eq(1)
		expect(User.first.email).to eq("tigerwoods@gmail.com")

		delete "/api/v0/users/324432323", headers: { "Content-Type" => "application/json", "Accept" => "application/json" },
			params: { user: user }.to_json
		
		parsed = JSON.parse(response.body, symbolize_names: true)
		
		expect(User.count).to eq(1)
		expect(response.status).to eq(404)
		expect(parsed).to eq({:errors=>[{:detail=>"Couldn't find User with 'id'=324432323", :status_code=>404}]})
	end
end
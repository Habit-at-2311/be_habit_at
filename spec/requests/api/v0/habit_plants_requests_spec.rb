require "rails_helper"

RSpec.describe "HabitPlant Api", type: :request do
  before do
    @headers = { "Content-Type" => "application/json", accept: 'application/json' }

    @user = User.create!({
      name: "John Doe",
      email: "john@testing.com"
    })

    @plant_1 = Plant.create!({
      style: "Flower1001",
      stem: "Stem.008",
      seed: "Seed.007",
      petal: "Petal.007",
      leaf: "Leaf.009",
      scale: 1,
      grow_rate: 0.4
    })

    @habit = Habit.create!({
      user_id: @user.id,
      plant_id: @plant_1.id,
      name: "swimming",
      description: "swimming is fun",
      frequency: 1,
      custom_frequency: {
          'Monday': true,
          'Tuesday': false,
          'Wednesday': true,
          'Thursday': false,
          'Friday': true,
          'Saturday': false,
          'Sunday': true
        },
      start_datetime: DateTime.new(2024,6,2),
      end_datetime: DateTime.new(2024,6,9),
      status: 0
    })
  end

  describe "habit_plant#show" do
    it "shows the habit_plant of the specified habit" do
      get "/api/v0/users/#{@user.id}/habits/#{@habit.id}/habit_plant", headers: @headers

      expect(response.status).to eq(200)

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response[:data]).to be_a Hash
      expect(json_response[:data][:id]).to be_a String
      expect(json_response[:data][:type]).to eq("habit_plant")
      expect(json_response[:data][:attributes]).to be_a Hash
      expect(json_response[:data][:attributes][:plant_id]).to eq(@plant_1.id)
      expect(json_response[:data][:attributes][:habit_id]).to eq(@habit.id)
      expect(json_response[:data][:attributes][:grow_rate]).to eq(@plant_1.grow_rate)
      expect(json_response[:data][:attributes][:scale]).to eq(@plant_1.scale)
      expect(json_response[:data][:attributes][:status]).to eq("growing")
    end
  end
end

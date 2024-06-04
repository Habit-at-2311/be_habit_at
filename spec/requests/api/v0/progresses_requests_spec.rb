require "rails_helper"

RSpec.describe "Progresses API", type: :request do
  before do
    @headers = { "Content-Type" => "application/json", accept => 'application/json' }

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
      name: "Coding",
      description: "Spend 1 hour per day to practice coding",
      frequency: "daily",
      custom_frequency: {
          'Monday': true,
          'Tuesday': true,
          'Wednesday': true,
          'Thursday': true,
          'Friday': true,
          'Saturday': true,
          'Sunday': true
        },
      start_datetime: "2024-05-12 20:00:00",
      end_datetime: "2024-05-16 20:00:00",
      status: "in_progress"
    })

    @progress_params = {
      status: "completed"
    }
  end

  describe "progresses#index" do
    it "shows all progresses of a habit" do
      get "/api/v0/users/#{@user.id}/habits/#{@habit.id}/progresses"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response[:data]).to be_an(Array)
      expect(json_response[:data].count).to eq(5)
    end
  end

  describe "progresses#update" do
    it "updates the status of a specified progress" do
      patch "/api/v0/users/#{@user.id}/habits/#{@habit.id}/progresses/#{@habit.progresses.first.id}", headers: @headers, params: JSON.generate(@progress_params)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response[:data][:attributes][:status]).to eq("completed")
    end
  end
end

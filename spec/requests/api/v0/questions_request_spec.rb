require "rails_helper"

RSpec.describe "Questions API", type: :request do
  before do
    @headers = { "Content-Type" => "application/json", "Accept" => 'application/json' }

    @user = User.create!({
      name: "John Doe",
      email: "john@gmail.com"
    })

    @plant_1 = Plant.create!({
      style: "Flower1001",
      stem: "Stem.008",
      seed: "Seed.007",
      petal: "Petal.007",
      leaf: "Leaf.009",
      scale: 1,
      grow_rate:0.4
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
      end_datetime: "2024-05-25 20:00:00",
      status: "in_progress"
    })

    @question_params = {
      question: "What is my completion rate?"
    }
  end

  describe "#create" do
    it "renders a JSON response for the question" do
      post "/api/v0/users/#{@user.id}/habits/#{@habit.id}/questions", headers: @headers, params: @question_params.to_json

      expect(response).to be_successful
      expect(response.status).to eq(200)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to eq({ :response => "Your completion rate for the habit \"Coding\" is currently 0%." })
    end
  end
end

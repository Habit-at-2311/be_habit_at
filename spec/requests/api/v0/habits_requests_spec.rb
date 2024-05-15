require "rails_helper"

RSpec.describe "Habits Api", type: :request do
  before do
    @headers = { "Content-Type" => "application/json", accept => 'application/json' }

    @user = User.create!({
      name: "John Doe",
      email: "john@gmail.com"
    })

    @habit_1 = Habit.create!({
      user_id: @user.id,
      name: "swimming",
      description: "swimming is fun",
      frequency: 0,
      start_datetime: DateTime.new(2024,5,1),
      end_datetime: DateTime.new(2024,5,10),
      status: 0
    })

    @habit_2 = Habit.create!({
      user_id: @user.id,
      name: "Coding",
      description: "Spend 1 hour per day to practice coding",
      frequency: "daily",
      start_datetime: "2024-05-1 20:00:00",
      end_datetime: "2024-05-13 20:00:00",
      status: "completed"
    })

    @habit_3 = Habit.create!({
      user_id: @user.id,
      name: "Mediate",
      description: "Spend 10 minutes meditating right after waking up",
      frequency: "daily",
      start_datetime: "2024-05-1 6:30:00",
      end_datetime: "2024-05-30 6:30:00",
      status: "in_progress"
    })

    describe "habits#index" do
      it "show all user's habits" do
        get "/api/v1/users/#{@user.id}/habits"

        expect(response).to be_successful
        expect(response.status).to eq(200)

        json_response = JSON.parse(response.body)
        expect(json_response[:data]).to be_a(Array)
        expect(json_response[0]['id']).to eq(@habit_1.id.to_s)
        expect(json_response[1]['id']).to eq(@habit_2.id.to_s)
        expect(json_response[2]['id']).to eq(@habit_2.id.to_s)
      end
    end
  end
end

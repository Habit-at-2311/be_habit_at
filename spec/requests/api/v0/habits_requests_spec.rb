require "rails_helper"

RSpec.describe "Habits Api", type: :request do
  before do
    @headers = { "Content-Type" => "application/json", accept => 'application/json' }

    @user = User.create!({
      name: "John Dunbar",
      email: "john@gmail.com"
    })

    @plant_1 = Plant.create!({
      style: "Flower1001",
      stem: "Stem.008",
      seed: "Seed.007",
      petal: "Petal.007",
      leaf: "Leaf.009",
      scale: 1
    })

    @plant_2 = Plant.create!({
      style: "Flower2001",
      stem: "Stem.009",
      seed: "Seed.008",
      petal: "Petal.008",
      leaf: "Leaf.010",
      scale: 0.4
    })

    @plant_3 = Plant.create!({
      style: "Flower3001",
      stem: "Stem.010",
      seed: "Seed.009",
      petal: "Petal.009",
      leaf: "Leaf.011",
      scale: 1
    })

    @plant_4 = Plant.create!({
      style: "Flower4001",
      stem: "Stem.011",
      seed: "Seed.010",
      petal: "Petal.010",
      leaf: "Leaf.012",
      scale: 1
    })

    @habit_1 = Habit.create!({
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
      start_datetime: DateTime.new(2024,5,1),
      end_datetime: DateTime.new(2024,5,10),
      status: 0
    })

    @habit_2 = Habit.create!({
      user_id: @user.id,
      plant_id: @plant_2.id,
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
      start_datetime: "2024-05-1 20:00:00",
      end_datetime: "2024-05-13 20:00:00",
      status: "completed"
    })

    @habit_3 = Habit.create!({
      user_id: @user.id,
      plant_id: @plant_3.id,
      name: "Mediate",
      description: "Spend 10 minutes meditating right after waking up",
      frequency: "weekly",
      custom_frequency: {
          'Monday': true,
          'Tuesday': false,
          'Wednesday': true,
          'Thursday': false,
          'Friday': true,
          'Saturday': false,
          'Sunday': true
        },
      start_datetime: "2024-05-1 6:30:00",
      end_datetime: "2024-05-30 6:30:00",
      status: "in_progress"
    })

    @habit_params = {
      plant_id: @plant_1.id,
      name: "Travel to a new place",
	    description: "travel at least once per month",
	    frequency: "monthly",
      custom_frequency: {
          'Monday': true,
          'Tuesday': false,
          'Wednesday': false,
          'Thursday': false,
          'Friday': false,
          'Saturday': false,
          'Sunday': false
        },
	    start_datetime: "2024-05-14 8:35:20",
      end_datetime: "2024-12-14 8:35:20"
    }
  end

  describe "habits#index" do
    it "show all user's habits" do
      get "/api/v0/users/#{@user.id}/habits"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response[:data]).to be_an(Array)
      expect(json_response[:data][0][:id]).to eq(@habit_1.id.to_s)
      expect(json_response[:data][1][:id]).to eq(@habit_2.id.to_s)
      expect(json_response[:data][2][:id]).to eq(@habit_3.id.to_s)
    end
  end

  describe "habits#create" do
    it "creates a new habit for a specified user" do
      post "/api/v0/users/#{@user.id}/habits", headers: @headers, params: { habit: @habit_params }.to_json

      expect(response).to be_successful
      expect(response.status).to eq(201)

      result = JSON.parse(response.body, symbolize_names: true)

      data = result[:data]

      expect(data).to have_key(:id)
      expect(data[:id]).to be_a(String)
      expect(data).to have_key(:type)
      expect(data[:type]).to eq("habit")
      expect(data).to have_key(:attributes)
      expect(data[:attributes]).to be_a(Hash)

      attributes = data[:attributes]

      expect(attributes).to have_key(:user_id)
      expect(attributes[:user_id]).to eq(@user.id)
      expect(attributes).to have_key(:plant_id)
      expect(attributes[:plant_id]).to eq(@plant_1.id)
      expect(attributes).to have_key(:name)
      expect(attributes[:name]).to eq("Travel to a new place")
      expect(attributes).to have_key(:description)
      expect(attributes[:description]).to eq("travel at least once per month")
      expect(attributes).to have_key(:frequency)
      expect(attributes[:frequency]).to eq("monthly")
      expect(attributes).to have_key(:start_datetime)
      expect(attributes[:start_datetime]).to eq("2024-05-14T08:35:20.000Z")
      expect(attributes).to have_key(:end_datetime)
      expect(attributes[:end_datetime]).to eq("2024-12-14T08:35:20.000Z")
      expect(attributes).to have_key(:status)
      expect(attributes[:status]).to eq("in_progress")
    end
  end

  # describe "habits#update" do
  # # Correct misspelled habit name with PATCH
  #   it "updates a habit for a given user" do
  #     habit = @user.habits.find(@habit_3.id)
  #     expect(habit.name).to eq("Mediate")

  #     patch "/api/v0/users/#{@user.id}/habits/#{@habit_3.id}", headers: @headers, params: { name: "Meditate" }.to_json

  #     habit_updated = @user.habits.find(@habit_3.id)
  #     expect(habit_updated.name).to eq("Meditate")

  #     expect(response).to be_successful
  #     expect(response.status).to eq(202)

  #     result = JSON.parse(response.body, symbolize_names: true)

  #     data = result[:data]

  #     expect(data).to have_key(:id)
  #     expect(data[:id]).to be_a(String)
  #     expect(data).to have_key(:type)
  #     expect(data[:type]).to eq("habit")
  #     expect(data).to have_key(:attributes)
  #     expect(data[:attributes]).to be_a(Hash)
  #     attributes = data[:attributes]

  #     expect(attributes).to have_key(:user_id)
  #     expect(attributes[:user_id]).to eq(@user.id)
  #     expect(attributes).to have_key(:plant_id)
  #     expect(attributes[:plant_id]).to eq(@plant_3.id)
  #     expect(attributes).to have_key(:name)
  #     expect(attributes[:name]).to eq("Meditate")
  #     expect(attributes).to have_key(:description)
  #     expect(attributes[:description]).to eq("Spend 10 minutes meditating right after waking up")
  #     expect(attributes).to have_key(:frequency)
  #     expect(attributes[:frequency]).to eq("weekly")
  #     expect(attributes).to have_key(:start_datetime)
  #     expect(attributes[:start_datetime]).to eq("2024-05-01T06:30:00.000Z")
  #     expect(attributes).to have_key(:end_datetime)
  #     expect(attributes[:end_datetime]).to eq("2024-05-30T06:30:00.000Z")
  #     expect(attributes).to have_key(:status)
  #     expect(attributes[:status]).to eq("in_progress")
  #   end

  #   it "will return an error if it can't find a user" do
  #     habit = @user.habits.find(@habit_3.id)
  #     expect(habit.name).to eq("Mediate")

  #     patch "/api/v0/users/#{@user.id}/habits/48340957309478", headers: @headers, params: { name: "Meditate" }.to_json

  #     expect(response).to_not be_successful
  #     expect(response.status).to eq(404)

  #     result = JSON.parse(response.body, symbolize_names: true)
  #     expect(result).to eq({:errors=>[{:detail=>"Couldn't find Habit with 'id'=48340957309478", :status_code=>404}]})

  #     habit = @user.habits.find(@habit_3.id)
  #     # habit name did not get updated
  #     expect(habit.name).to eq("Mediate")

  #     result = JSON.parse(response.body, symbolize_names: true)
  #   end
  # end

  describe "habits#delete" do
    it "deletes a habit for a given user" do
      # assigning first habit in list
      habit = @user.habits.find(@habit_1.id)
      # user has three habits at start of request
      expect(@user.habits.count).to eq(3)
      expect(habit.id).to eq(@habit_1.id)
      expect(habit.frequency).to eq("weekly")
      expect(habit.name).to eq("swimming")
      expect(habit.description).to eq("swimming is fun")
      expect(habit.frequency).to eq("weekly")
      expect(habit.status).to eq("in_progress")

      delete "/api/v0/users/#{@user.id}/habits/#{habit.id}", headers: @headers,
        params: { name: "Meditate" }.to_json

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(202)
      expect(result).to eq({:message=>"swimming has been deleted"})

      # @user now only has two total habits in his account
      expect(@user.habits.count).to eq(2)

      # @habit_1 attributes and values are not in database anymore
      expect(@user.habits.pluck(:id)).to_not include(@habit_1.id)
      expect(@user.habits.pluck(:name)).to_not include("swimming")
      expect(@user.habits.pluck(:description)).to_not include("swimming is fun")
      # @habit_1 has been succeessfully destroyed
    end
  end

  describe "habits#delete" do
    it "will return an error if user can't be found" do
      habit = @user.habits.find(@habit_1.id)
      # user has three total habits they are tracking
      expect(@user.habits.count).to eq(3)
      expect(habit.id).to eq(@habit_1.id)
      expect(habit.frequency).to eq("weekly")
      expect(habit.name).to eq("swimming")
      expect(habit.description).to eq("swimming is fun")
      expect(habit.frequency).to eq("weekly")
      expect(habit.status).to eq("in_progress")

      delete "/api/v0/users/#{@user.id}/habits/342334231", headers: @headers

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)
      expect(result).to eq({:errors=>[{:detail=>"Couldn't find Habit with 'id'=342334231", :status_code=>404}]})

      # count has not been decremented
      expect(@user.habits.count).to eq(3)

      # @habit_1 attributes and values still in the system
      expect(@user.habits.pluck(:id)).to include(@habit_1.id)
      expect(@user.habits.pluck(:name)).to include("swimming")
      expect(@user.habits.pluck(:description)).to include("swimming is fun")
    end
  end
end

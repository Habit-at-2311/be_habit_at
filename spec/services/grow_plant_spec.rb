require 'rails_helper'

RSpec.describe GrowPlantService, type: :service do
  let(:user) { User.create!({
      name: "John Dunbar",
      email: "john@gmail.com"
    })  }

  let(:plant) { Plant.create!({
    style: "Flower1001",
    stem: "Stem.008",
    seed: "Seed.007",
    petal: "Petal.007",
    leaf: "Leaf.009",
    scale: 1,
    grow_rate: 0.4
  }) }

  let(:habit) { Habit.create!({
    user_id: user.id,
    plant_id: plant.id,
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
    start_datetime: DateTime.new(2024,6,1),
    end_datetime: DateTime.new(2024,6,9),
    status: 0
  })  }
  let(:habit_plant) { HabitPlant.create!({
      plant_id: plant.id,
      habit_id: habit.id,
      grow_rate: plant.grow_rate,
      scale: plant.scale,
      status: 0
  })  }
  describe "#update" do
    it "increases the scale and updates the status of habit_plant when the plant grows" do
      service = GrowPlantService.new(habit_plant, true)
      service.update
      expect(habit_plant.scale).to eq(1.4)
      expect(habit_plant.status).to eq("growing")
    end

    it "decreases the scale and updates the status of habit_plant when the plant is wilting" do
      service = GrowPlantService.new(habit_plant, true)
      service.update
      expect(habit_plant.scale).to eq(1.4)

      service = GrowPlantService.new(habit_plant, false)

      service.update

      expect(habit_plant.scale).to eq(1)
      expect(habit_plant.status).to eq("wilting")
    end

    it "can't increase the scale more than the max scale" do
      service = GrowPlantService.new(habit_plant, true)
      12.times do
        service.update
      end
      expect(habit_plant.scale).to eq(4)
      expect(habit_plant.status).to eq("healthy")
    end

    it "can't decrease the scale if the scale is less than the (initial_scale - grow_rate)" do
      service = GrowPlantService.new(habit_plant, false)
      3.times do
        service.update
      end
      expect(habit_plant.scale).to eq(0.6)
      expect(habit_plant.status).to eq("death")
    end


  end
end

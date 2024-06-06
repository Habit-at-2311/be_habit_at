class GrowPlantService
  # progress is updated: incomplete -> completed/ skipped (can't be vice versa)
  def initialize(habit_plant, plant_growing = true)
    @habit_plant = habit_plant
    @plant_growing = plant_growing
  end

  def update
    initial_scale = @habit_plant.scale
    updated_scale =
      if @plant_growing
        increase_scale
      else
        decrease_scale
      end
    @habit_plant.scale = updated_scale
    get_status(initial_scale, updated_scale)

    @habit_plant.save

  end

  def increase_scale
    # increase scale of habit_plant by 0.4 if the status of the progress is updated from "incomplete" to "completed"
    scale = @habit_plant.scale
    new_scale = (scale + @habit_plant.grow_rate).round(1)

    return @habit_plant.max_scale if new_scale > @habit_plant.max_scale
    new_scale
  end

  def decrease_scale
    # decrease scale of habit_plant by 0.4 if the status of the progress is updated from "incomplete" to "skipped".
    scale = @habit_plant.scale
    new_scale = (scale - @habit_plant.grow_rate).round(1)

    return scale if new_scale < @habit_plant.initial_scale - @habit_plant.grow_rate

    [new_scale, @habit_plant.initial_scale].min
  end

  def get_status(initial_scale, scale)
    # status of the plant in habit_plant: growing, death?
    if scale == @habit_plant.initial_scale - @habit_plant.grow_rate
      @habit_plant.death!
    elsif scale == @habit_plant.max_scale
      @habit_plant.healthy!
    elsif initial_scale < scale
      @habit_plant.growing!
    elsif initial_scale > scale
      @habit_plant.wilting!
    end
  end
end

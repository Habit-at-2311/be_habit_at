class Api::V0::QuestionsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    habit = user.habits.find(params[:habit_id])

    question = question_params[:question]

    progresses = get_habit_progress(habit)
    message = generate_message(question, progresses)

    analysis_chatgpt = ChatGptService.analyze(message)

    render json: { response: analysis_chatgpt }
  end

  private
  def get_habit_progress(habit)
    progresses = habit.progresses.where("datetime < ?", Date.current)
    ProgressSerializer.new(progresses).as_json
  end

  def generate_message(question, progresses)
    <<~PROMPT
    Below is the progresses' data of a specified habit and the question of a user who is doing the habit.

    Habit Progress Data:
      The data appears to be JSON, representing an array of progress records for a habit.
      Each element in the array represents a single progress record.
      Using the attributes key contains an object with the actual data for the progress record, including:
        status: The status of the habit progress. 'incomplete' is the progress hasn't happened yet. 'skipped' means the user
        didn't do the habit on the day. 'completed' means the user did finish the habit on the day.
        datetime: The date and time of the progress record.
        habit_name: The name of the habit.
      #{progresses.to_json}
    Question: #{question}

    Using the habit progress data to answer the question and dont explain the calculation. Use habit name from habit_name attribute when referring to the habit
    PROMPT
  end

  def question_params
    params.permit(:question)
  end
end

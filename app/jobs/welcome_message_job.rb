class WelcomeMessageJob < ApplicationJob
  queue_as :default

  def perform
    # Do something latersssss
  end
end

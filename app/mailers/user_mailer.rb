class UserMailer < ApplicationMailer
  default :from => 'hoangocdam@gmail.com'

  def reminder_email
    @user = params[:user]
    @habit = params[:habit]
    mail(to: @user.email, subject: 'Reminder: Your habit is due tomorrow')
  end
end

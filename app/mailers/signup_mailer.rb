class SignupMailer < ApplicationMailer
  def signup(email)
    @email = email

    mail(to: Rails.application.secrets.admin_email, subject: 'New Midwest Dev Chat request.')
  end
end

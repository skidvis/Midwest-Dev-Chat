class SignupMailer < ApplicationMailer
  def signup(email, name, referral)
    @email = email
    @name = name
    @referral = referral

    mail(to: Rails.application.secrets.admin_email, subject: 'New Midwest Dev Chat request.')
  end
end

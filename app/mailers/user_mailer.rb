class UserMailer < ActionMailer::Base
  default from: "avalente111@gmail.com"
  # default from: "LoginPal <avalente111@gmail.com>"

  def password_reset(user)
    @user = user
    mail :to => user.email, subject: "Password reset"
  end

  # def welcome(user)
  #   @user = user
  #   mail :to => user.email, subject: "Welcome to LoginPal!"
  # end
end

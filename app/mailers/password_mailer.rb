# frozen_string_literal: true

class PasswordMailer < ApplicationMailer
  def reset
    @token = params[:token]
    mail to: params[:user].email, subject: 'Reset Password Instructions'
  end
end

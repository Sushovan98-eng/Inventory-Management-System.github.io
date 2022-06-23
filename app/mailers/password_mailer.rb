class PasswordMailer < ApplicationMailer
  

    def reset
        @token = params[:token]
        mail to: params[:user].email
    end
end
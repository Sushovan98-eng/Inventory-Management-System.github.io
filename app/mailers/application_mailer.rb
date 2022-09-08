# frozen_string_literal: true

# # This class is for Application Mailer
class ApplicationMailer < ActionMailer::Base
  default from: 'inventorymanagenent@gmail.com'
  layout 'mailer'
end

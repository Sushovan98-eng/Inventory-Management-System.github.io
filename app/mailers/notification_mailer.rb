# frozen_string_literal: true

# # This class is for Notification Mailer
class NotificationMailer < ApplicationMailer
  helper :items

  def item_shortage_notification(user, item)
    @user = user
    @item = item
    mail to: user.email, subject: 'Item stock shortage!'
  end

  def issue_notification(user, issue)
    @user = user
    @issue = issue
    mail to: user.email, subject: "Solved issue ISN0#{issue.id}"
  end
end

# frozen_string_literal: true

module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Inventory Management System'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def notify_for_shortage_item(item)
    if item.in_stock <= item.minimum_required_stock
      User.where(admin: true).each do |user|
        NotificationMailer.item_shortage_notification(user, item).deliver_now
      end
    end
  end
end

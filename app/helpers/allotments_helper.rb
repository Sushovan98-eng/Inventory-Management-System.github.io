# frozen_string_literal: true

# Here define the helper methods for allotment
module AllotmentsHelper
  include ItemsHelper
  def get_deallotment_status(allotment)
    if allotment.dealloted_at.nil?
      'Currently alloted.'
    else
      allotment.dealloted_at.strftime('%d-%m-%Y %H:%M:%S')
    end
  end

  def get_allotment_count(user)
    @allotment_count = if user.admin
                         Allotment.where(dealloted_at: nil).count
                       else
                         Allotment.where({ user_id: user.id, dealloted_at: nil }).count
                       end
  end

  def item_quantity_validation
    return unless item_id.present?

    item = Item.find_by(id: item_id)
    return unless get_item_in_stock(item) < allotment_quantity.to_i

    errors.add(:allotment_quantity, 'is more than the available stock')
  end

  def any_allotment?
    Allotment.exists?(dealloted_at: nil)
  end

  def allotment_exists?(user_id, item_id)
    Allotment.where(user_id: user_id, item_id: item_id, dealloted_at: nil).exists?
  end
end

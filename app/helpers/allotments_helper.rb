# frozen_string_literal: true

module AllotmentsHelper
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
    if item_id.present?
      item = Item.find(item_id)
      if Allotment.where(user_id: user_id, item_id: item_id, dealloted_at: nil).exists?
        previous_quantity = Allotment.where(user_id: user_id, item_id: item_id).last.allotment_quantity
        total_stock = item.in_stock + previous_quantity
        if allotment_quantity.to_i > previous_quantity && total_stock < allotment_quantity.to_i
          errors.add(:allotment_quantity, ' is not sufficient for this allotment.')
        end
      elsif item.in_stock < allotment_quantity.to_i
        errors.add(:allotment_quantity, 'is more than the available stock')
      end
    end
  end

  def any_allotment?
    Allotment.exists?(dealloted_at: nil)
  end
end

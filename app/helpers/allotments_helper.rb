module AllotmentsHelper
    def get_deallotment_status(allotment)
      if allotment.dealloted_at.nil?
        "Currently alloted."
      else
        allotment.dealloted_at
      end
    end

    def get_allotment_count(user)
      if user.admin?
        @allotment_count = Allotment.where(dealloted_at: nil).count
      else
        @allotment_count = Allotment.where({user_id: user.id, dealloted_at: nil}).count
      end 
    end 

    def item_quantity_validation
      if item_id.present?
        item = Item.find(item_id)
          if Allotment.where(user_id: self.user_id, item_id: self.item_id, dealloted_at: nil).exists?
            previous_quantity = Allotment.where(user_id: self.user_id, item_id: self.item_id).first.allotment_quantity
            total_stock = item.in_stock + previous_quantity
            if allotment_quantity.to_i > previous_quantity && total_stock < allotment_quantity.to_i
              errors.add(:allotment_quantity, " is not sufficient for this allotment.")
            end
          elsif item.in_stock < allotment_quantity.to_i
          errors.add(:allotment_quantity, "is more than the available stock")
          end
      end
    end
end
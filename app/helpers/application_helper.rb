module ApplicationHelper

  def remaining_days
    ((current_photographer.created_at + 10.days).to_date - Date.today).round
  end

  def liked_images(event)
    event.images.where(is_liked: true)
  end

  def any_pending_plan?(plan)
    if current_photographer.photographer_plans.pending_plan?
      "#"
    else
      plan_update_path(plan_id: plan)
    end
  end

  def default_url
		if photographer_signed_in?
			photographer_path(current_photographer)
		else
			root_path
		end
	end
end
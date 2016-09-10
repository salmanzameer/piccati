module PhotographersHelper
	 def events_ajax_previous_link
    ->(param, date_range) { link_to raw("&laquo;"), {param => date_range.first - 1.day}, remote: :true}
   end
 
   def events_ajax_next_link
    ->(param, date_range) { link_to raw("&raquo;"), {param => date_range.last + 1.day}, remote: :true}
   end

   def profile_completeness
    contribution = Photographer::ProfileContributions
    profile = 45
    profile += contribution[:feature_image] if current_photographer.feature_image.present?
    profile += contribution[:avatar] if current_photographer.avatar.present?
    profile += contribution[:package] if current_photographer.packages.count > 0
    profile
   end
end

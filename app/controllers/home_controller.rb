class HomeController < ApplicationController
	
	def expires  
		if current_photographer.photographer_plans.active_plan?
			redirect_to photographer_path(current_photographer)
		end
	end

	def download
		photographer_client = PhotographerClient.find_by_token(params[:token])
		client = photographer_client.client
		if client
			file_name  = "#{client.firstname}.zip"
			temp_file  = Tempfile.new("#{file_name}-#{Date.today}")
			images = client.get_event_images
			
			Zip::ZipOutputStream.open(temp_file.path) do |zos|
		    images.each do |file|
			    zos.put_next_entry(file.image_file_name)
			    zos.print IO.read(file.image.path)
			  end
			end

			send_file temp_file.path, :type => 'application/zip',
			                          :disposition => 'attachment',
			                          :filename => file_name
			temp_file.close
		else

		end
	end
end

class PackagesController < ApplicationController

  def create
    @package = current_photographer.packages.create(package_params)
    @packages = current_photographer.packages
    return render partial: "photographers/package_list", locals: { packages: @packages }
  end

  def show
    @package = Package.find_by_id params[:id]
    return render partial: "photographers/package", locals: { package: @package }
  end

  def client_package_update
    @package = Package.find_by_id params[:package_id]
    return render text: @package.price
  end

  def update
    @package = Package.find_by_id params[:id]
    @package.update(package_params)
    @packages = current_photographer.packages
    return render partial: "photographers/package_list", locals: { packages: @packages }
  end

  protected 

  def package_params
    params.require(:package).permit(:name, :picture_dslr_count, :video_dslr_count, :album_leaves, :other_city_charges, :price)
  end
end

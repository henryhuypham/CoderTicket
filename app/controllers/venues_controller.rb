class VenuesController < ApplicationController
  before_action :required_login

  def index
    @venues = Venue.all
  end

  def new
    region = Region.find_by(id: params[:venue][:region_id])

    if region.present?
      Venue.create(venue_params)
      flash[:success] = 'Venue created!'
      redirect_to venues_index_path
    else
      flash[:error] = 'Invalid region!'
      redirect_to :back
    end
  end

  private

  def venue_params
    params.require(:venue).permit(:name, :full_address, :region_id)
  end
end

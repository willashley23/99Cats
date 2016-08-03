class CatRentalRequestsController < ApplicationController

  def index
    @cat_rental_request = Cat.all
  end

  def show
    @cat_rental_request = cat_rental_request.find_by_id(params[:id])
  end

  def new
    @cat_rental_request = cat_rental_request.new
  end

  def create
    @cat_rental_request = cat_rental_request.new(cat_rental_request_params)
      if @cat_rental_request.save
        redirect_to cat_rental_request_url(@cat_rental_request)
      else
        render @cat_rental_request.errors.full_messages
      end
  end

  def edit
    @cat_rental_request = cat_rental_request.find_by_id(params[:id])
  end

  def update
    @cat_rental_request = cat_rental_request.find_by_id(params[:id])
    if @cat_rental_request.update(cat_rental_request_params)
      redirect_to cat_rental_request_url(@cat_rental_request)
    else
      render @cat_rental_request.errors.full_messages
    end
  end

  private

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status)
  end
end

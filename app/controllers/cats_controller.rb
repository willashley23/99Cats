class CatsController < ApplicationController
  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find_by_id(params[:id])
  end

  def new
    @cat = Cat.new
  end

  def create
    @cat = Cat.new(cat_params)
      if @cat.save
        redirect_to cat_url(@cat)
      else
        render @cat.errors.full_messages
      end
  end

  def edit
    @cat = Cat.find_by_id(params[:id])
  end

  def update
    @cat = Cat.find_by_id(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      render @cat.errors.full_messages
    end
  end


  private

  def cat_params
    params.require(:cat).permit(:name, :sex, :color, :birth_date, :description)
  end





end

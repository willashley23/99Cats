class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find_by_id(params[:id])
    render :show
  end

  def new
    if logged_in?
      @cat = Cat.new
      render :new
    else
      redirect_to new_session_url
    end
  end

  def create
    @cat = current_user.cats.new(cat_params)
    # @cat = Cat.new(cat_params)
      if @cat.save
        redirect_to cat_url(@cat)
      else
        flash.now[:errors] = @cat.errors.full_messages
        render :new
      end
  end

  def edit
    @cat = Cat.find_by_id(params[:id])
    render :edit
  end

  def update
    @cat = current_user.cats.find(params[:id])
    # @cat = Cat.find_by_id(params[:id])
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

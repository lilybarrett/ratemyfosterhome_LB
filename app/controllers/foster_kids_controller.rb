class FosterKidsController < ApplicationController
  before_action :authenticate_user

  def index
    if current_user.admin?
      @foster_kids = FosterKid.all
    else
      @user = current_user
      @foster_kids = @user.foster_kids
    end
  end

  def show
    @foster_kid = FosterKid.find(params[:id])
    # @user = @foster_kid.user
    # @homes = @foster_kid.homes
  end

  def new
    if current_user.admin?
      @foster_kid = FosterKid.new
    else
      raise_error
    end
  end

  def create
    @foster_kid = FosterKid.new(foster_kid_params)
    if @foster_kid.save
      flash[:notice] = "Child successfully added to site"
      redirect_to foster_kid_path(@foster_kid)
    else
      flash[:error] = @foster_kid.errors.full_messages.join('. ')
      render :new
    end
  end

  def edit
    @foster_kid = FosterKid.find(params[:id])
  end

  def update
    @foster_kid = FosterKid.find(params[:id])
    if @foster_kid.update_attributes(foster_kid_params)
      flash[:notice] = "Child's information successfully updated"
      redirect_to foster_kid_path(@foster_kid)
    else
      flash[:error] = "Please fill out all required fields."
      render :edit
    end
  end

  private

  def foster_kid_params
    params.require(:foster_kid).permit(
      :first_name,
      :last_name
    )
  end
end

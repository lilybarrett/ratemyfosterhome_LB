class FosterParentsController < ApplicationController
  before_action :authenticate_user

  def index
    if current_user.admin?
      @foster_parents = FosterParent.all
    else
      @user = current_user
      @foster_home = @user.foster_home
      @foster_parents = @foster_home.foster_parents
    end
  end

  def show
    @foster_parent = FosterParent.find(params[:id])
  end

  def new
    if current_user.admin?
      @foster_parent = FosterParent.new
    else
      raise_error
    end
  end

  def create
    @foster_parent = FosterParent.new(foster_parent_params)
    if @foster_parent.save
      flash[:notice] = "Foster Parent successfully added to site"
      redirect_to foster_parent_path(@foster_parent)
    else
      flash[:error] = @foster_parent.errors.full_messages.join('. ')
      render :new
    end
  end

  def edit
    @foster_parent = FosterParent.find(params[:id])
  end

  def update
    @foster_parent = FosterParent.find(params[:id])
    if @foster_parent.update_attributes(foster_parent_params)
      flash[:notice] = "Foster Parent's information successfully updated"
      redirect_to foster_parent_path(@foster_parent)
    else
      flash[:error] = "Please fill out all required fields."
      render :edit
    end
  end

  private

  def foster_parent_params
    params.require(:foster_parent).permit(
      :first_name,
      :last_name
    )
  end
end

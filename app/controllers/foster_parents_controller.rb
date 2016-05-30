class FosterParentsController < ApplicationController
  before_action :authenticate_user

  def index
    if current_user.admin?
      @foster_parents = FosterParent.all.order("last_name ASC")
    else
      raise_error
    end
  end

  def show
    @foster_parent = FosterParent.find(params[:id])
    if current_user.admin? || FosterHome.exists?(foster_parent_id: @foster_parent, user_id: current_user)
      render :show
    else
      raise_error
    end
  end

  def new
    if current_user.admin?
      @foster_parent = FosterParent.new
    else
      raise_error
    end
  end

  def create
    if current_user.admin?
      @foster_parent = FosterParent.new(foster_parent_params)
      if @foster_parent.save
        flash[:notice] = "Foster Parent successfully added to site"
        redirect_to foster_parent_path(@foster_parent)
      else
        flash[:error] = @foster_parent.errors.full_messages.join('. ')
        render :new
      end
    else
      raise_error
    end
  end

  def edit
    @foster_parent = FosterParent.find(params[:id])
    if current_user.admin? || FosterHome.exists?(foster_parent_id: @foster_parent, user_id: current_user)
      render :edit
    else
      raise_error
    end
  end

  def update
    @foster_parent = FosterParent.find(params[:id])
    if current_user.admin? || FosterHome.exists?(foster_parent_id: @foster_parent, user_id: current_user)
      if @foster_parent.update_attributes(foster_parent_params)
        flash[:notice] = "Foster Parent's information successfully updated"
        redirect_to foster_parent_path(@foster_parent)
      else
        flash[:error] = "Please fill out all required fields."
        render :edit
      end
    else
      raise_error
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

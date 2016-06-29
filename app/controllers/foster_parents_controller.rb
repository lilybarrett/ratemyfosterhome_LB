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

  def create
    if current_user.admin?
      @foster_parent = FosterParent.new(foster_parent_params)
      unless FosterParent.exists?(first_name: @foster_parent.first_name, last_name: @foster_parent.last_name)
        if @foster_parent.save
          flash[:notice] = "Foster Parent successfully added to site"
          redirect_to foster_parent_path(@foster_parent)
        else
          flash[:error] = @foster_parent.errors.full_messages.join('. ')
          redirect_to authenticated_root_path
        end
      else
        flash[:notice] = "This foster parent already exists in the database."
        redirect_to authenticated_root_path
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
        edit_origin = Rails.application.routes.recognize_path params[:route]
        if edit_origin.include?(:foster_home_id)
          redirect_to foster_home_path(edit_origin[:foster_home_id])
        else
          redirect_to foster_parent_path(@foster_parent)
        end
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

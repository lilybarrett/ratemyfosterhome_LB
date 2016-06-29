class FosterKidsController < ApplicationController
  before_action :authenticate_user

  def index
    if current_user.admin?
      @foster_kids = FosterKid.all.order("last_name ASC")
    else
      raise_error
    end
  end

  def show
    @foster_kid = FosterKid.find(params[:id])
    if current_user.admin? || FosterHome.exists?(foster_kid_id: @foster_kid, user_id: current_user)
      render :show
    else
      raise_error
    end
  end

  def create
    if current_user.admin?
      @foster_kid = FosterKid.new(foster_kid_params)
      unless FosterKid.exists?(first_name: @foster_kid.first_name, last_name: @foster_kid.last_name)
        if @foster_kid.save
          flash[:notice] = "Youth successfully added to site"
          redirect_to foster_kid_path(@foster_kid)
        else
          flash[:error] = @foster_kid.errors.full_messages.join('. ')
          redirect_to authenticated_root_path
        end
      else
        flash[:notice] = "This youth already exists in the database."
        redirect_to authenticated_root_path
      end
    else
      raise_error
    end
  end

  def edit
    @foster_kid = FosterKid.find(params[:id])
    if current_user.admin? || FosterHome.exists?(foster_kid_id: @foster_kid, user_id: current_user)
      render :edit
    else
      raise_error
    end
  end

  def update
    @foster_kid = FosterKid.find(params[:id])
    @foster_home = FosterHome.find_by(foster_kid_id: @foster_kid)
    if current_user.admin? || FosterHome.exists?(foster_kid_id: @foster_kid, user_id: current_user)
      if @foster_kid.update_attributes(foster_kid_params)
        flash[:notice] = "Child's information successfully updated"
        edit_origin = Rails.application.routes.recognize_path params[:route]
        if edit_origin.include?(:foster_home_id)
          redirect_to foster_home_path(@foster_home)
        else
          redirect_to foster_kid_path(@foster_kid)
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

  def foster_kid_params
    params.require(:foster_kid).permit(
      :first_name,
      :last_name
    )
  end
end

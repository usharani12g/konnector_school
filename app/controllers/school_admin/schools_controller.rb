class SchoolAdmin::SchoolsController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_school_admin

  def edit
    @school = current_user.school
  end

  def update
    @school = current_user.school
    if @school.update(school_params)
      redirect_to edit_school_admin_school_path, notice: "School updated successfully"
    else
      render :edit
    end
  end

  private

  def school_params
    params.require(:school).permit(:name, :address)
  end

  def ensure_school_admin
    redirect_to root_path unless current_user.school_admin?
  end

end

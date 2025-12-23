class Admin::SchoolsController < ApplicationController

  before_action :authorize_admin!
  before_action :set_school, only: [:edit, :update, :destroy]

  def index
    @schools = School.all
  end

  def new
    @school = School.new
  end

  def create
    @school = School.new(school_params)
    if @school.save
      redirect_to admin_schools_path, notice: "School created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @school.update(school_params)
      redirect_to admin_schools_path, notice: "School updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @school.destroy
    redirect_to admin_schools_path, notice: "School deleted successfully"
  end

  private

  def authorize_admin!
    redirect_to root_path, alert: "Access denied" unless current_user.admin?
  end

  def set_school
    @school = School.find(params[:id])
  end

  def school_params
    params.require(:school).permit(:name, :address)
  end

end

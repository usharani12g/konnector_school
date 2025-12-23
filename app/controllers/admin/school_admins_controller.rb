class Admin::SchoolAdminsController < ApplicationController
  before_action :authorize_admin!
  before_action :set_school

  def index
    @school_admins = @school.users.school_admin
  end

  def new
    @school_admin = User.new
  end

  def create
    @school_admin = User.new(school_admin_params)
    @school_admin.role = :school_admin
    @school_admin.school = @school
    @school_admin.password = "test1234"

    if @school_admin.save
      redirect_to admin_school_school_admins_path(@school),
                  notice: "School admin created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_school
    @school = School.find(params[:school_id])
  end

  def school_admin_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end

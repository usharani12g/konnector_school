class SchoolAdmin::StudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_school_admin

  def index
    @students = current_user.school.users.student
  end

  def new
    @student = User.new
  end

  def create
    @student = User.new(student_params)
    @student.role = :student
    @student.school = current_user.school
    @student.password = "test1234"

    if @student.save
      redirect_to school_admin_students_path, notice: "Student created"
    else
      render :new
    end
  end

  private

  def student_params
    params.require(:user).permit(:email)
  end

  def ensure_school_admin
    redirect_to root_path unless current_user.school_admin?
  end
end
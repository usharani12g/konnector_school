class SchoolAdmin::CoursesController < ApplicationController
  before_action :authorize_school_admin!
  before_action :set_course, only: [:edit, :update, :destroy]

  def index
    @courses = current_user.school.courses
  end

  def new
    @course = current_user.school.courses.new
  end

  def create
    @course = current_user.school.courses.new(course_params)
    if @course.save
      redirect_to school_admin_courses_path, notice: "Course created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to school_admin_courses_path, notice: "Course updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy
    redirect_to school_admin_courses_path, notice: "Course deleted successfully"
  end

  private

  def set_course
    @course = current_user.school.courses.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name)
  end
end

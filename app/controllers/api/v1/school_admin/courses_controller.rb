class Api::V1::SchoolAdmin::CoursesController < Api::V1::BaseController
  before_action :authorize_school_admin!

  def index
    render json: current_user.school.courses
  end

  def create
    course = current_user.school.courses.create!(course_params)
    render json: course, status: :created
  end

  private

  def course_params
    params.require(:course).permit(:name)
  end
end

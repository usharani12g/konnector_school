class Api::V1::Student::EnrollmentsController < Api::V1::BaseController
  before_action :authorize_student!

  def index
    render json: current_user.enrollments
  end

  def create
    enrollment = current_user.enrollments.create!(
      batch_id: params[:batch_id],
      status: "pending"
    )
    render json: enrollment, status: :created
  end
end

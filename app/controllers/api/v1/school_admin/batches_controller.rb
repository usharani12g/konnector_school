class Api::V1::SchoolAdmin::BatchesController < Api::V1::BaseController
  before_action :authorize_school_admin!

  def index
    batches = Batch.joins(:course)
                   .where(courses: { school_id: current_user.school_id })
    render json: batches
  end

  def create
    batch = Batch.create!(batch_params)
    render json: batch, status: :created
  end

  def assign_students
    batch = Batch.find(params[:id])

    params[:student_ids].each do |sid|
      Enrollment.find_or_create_by!(
        user_id: sid,
        batch_id: batch.id,
        status: "approved"
      )
    end

    render json: { message: "Students assigned successfully" }
  end

  private

  def batch_params
    params.require(:batch).permit(:name, :course_id)
  end
end

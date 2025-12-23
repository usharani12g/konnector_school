class EnrollmentsController < ApplicationController

  before_action :authorize_student!

  def index
    @enrollments = current_user.enrollments.includes(batch: :course)
    @batches = Batch.joins(course: :school)
                    .where(courses: { school_id: current_user.school_id })
  end

  def create
    enrollment = current_user.enrollments.new(batch_id: params[:batch_id], status: :pending)

    if enrollment.save
      redirect_to enrollments_path, notice: "Enrollment request sent"
    else
      redirect_to enrollments_path, alert: "Already requested or error occurred"
    end
  end

  private

  def authorize_student!
    redirect_to root_path, alert: "Access denied" unless current_user.student?
  end

end

class SchoolAdmin::EnrollmentsController < ApplicationController

  before_action :authorize_school_admin!
  before_action :set_enrollment, only: [:approve, :reject]

  def index
    @enrollments = Enrollment
                     .joins(batch: { course: :school })
                     .where(schools: { id: current_user.school_id })
                     .pending
  end

  def approve
    @enrollment.approved!
    redirect_to school_admin_enrollments_path, notice: "Enrollment approved"
  end

  def reject
    @enrollment.rejected!
    redirect_to school_admin_enrollments_path, notice: "Enrollment rejected"
  end

  private

  def set_enrollment
    @enrollment = Enrollment
                    .joins(batch: { course: :school })
                    .where(schools: { id: current_user.school_id })
                    .find(params[:id])
  end

end

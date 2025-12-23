class BatchesController < ApplicationController
  before_action :authorize_student!
  before_action :set_batch
  before_action :ensure_approved_enrollment!

  def classmates
    @classmates = @batch.enrollments
                        .approved
                        .includes(:user)
                        .where.not(user_id: current_user.id)
                        .map(&:user)
  end

  private

  def authorize_student!
    redirect_to root_path, alert: "Access denied" unless current_user.student?
  end

  def set_batch
    @batch = Batch.find(params[:id])
  end

  def ensure_approved_enrollment!
    unless current_user.enrollments.exists?(batch: @batch, status: :approved)
      redirect_to enrollments_path, alert: "You are not approved for this batch"
    end
  end
end

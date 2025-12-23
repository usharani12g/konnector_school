class SchoolAdmin::BatchesController < ApplicationController
  before_action :authorize_school_admin!

  before_action :set_course, only: [:index]
  before_action :set_batch, only: [:edit, :update, :destroy, :assign_students, :save_students, :students]

  def index
    @batches = @course.batches
  end

  def all_batches
    @batches = Batch
                 .joins(:course)
                 .where(courses: { school_id: current_user.school_id })
                 .includes(:course)
  end

  def new
    @batch = Batch.new
    @courses = current_user.school.courses
  end

  def create
    @batch = Batch.new(batch_params)

    if @batch.save
      redirect_to school_admin_batches_path,
                  notice: "Batch created successfully"
    else
      @courses = current_user.school.courses
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @courses = current_user.school.courses
  end

  def update
    if @batch.update(batch_params)
      redirect_to school_admin_batches_path,
                  notice: "Batch updated successfully"
    else
      @courses = current_user.school.courses
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @batch.destroy
    redirect_to school_admin_batches_path,
                notice: "Batch deleted successfully"
  end

  def assign_students
    @students = current_user.school.users.student
  end

  def save_students
    student_ids = params[:student_ids] || []

    student_ids.each do |student_id|
      Enrollment.find_or_create_by!(
        user_id: student_id,
        batch_id: @batch.id
      ) do |enrollment|
        enrollment.status = "approved"
      end
    end

    redirect_to school_admin_batches_path,
                notice: "Students assigned to batch successfully"
  end

  def students
    @students = @batch.users
  end

  private

  def set_course
    @course = current_user.school.courses.find(params[:course_id])
  end

  def set_batch
    @batch = Batch
               .joins(:course)
               .where(courses: { school_id: current_user.school_id })
               .find(params[:id])
  end

  def batch_params
    params.require(:batch).permit(:name, :course_id)
  end
end

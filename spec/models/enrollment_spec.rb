require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  it "prevents duplicate enrollment for same batch" do
    student = create(:user, :student)
    batch = create(:batch, course: create(:course, school: student.school))

    create(:enrollment, user: student, batch: batch)

    duplicate = Enrollment.new(user: student, batch: batch)

    expect(duplicate.valid?).to be_falsey
  end

  it "allows status to be approved" do
    enrollment = create(:enrollment)

    enrollment.approved!

    expect(enrollment.status).to eq("approved")
  end
end

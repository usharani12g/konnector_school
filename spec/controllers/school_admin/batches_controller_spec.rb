RSpec.describe SchoolAdmin::BatchesController, type: :controller do
  let(:school) { create(:school) }
  let(:course) { create(:course, school: school) }
  let(:school_admin) { create(:user, :school_admin, school: school) }

  before do
    sign_in school_admin
  end

  it "creates a batch" do
    expect {
      post :create, params: {
        batch: {
          name: "Morning Batch",
          course_id: course.id
        }
      }
    }.to change(Batch, :count).by(1)
  end

  it "assigns students to batch" do
    student = create(:user, :student, school: school)
    batch = create(:batch, course: course)

    post :save_students, params: {
      id: batch.id,
      student_ids: [student.id]
    }

    expect(batch.users).to include(student)
  end

end

require 'rails_helper'

RSpec.describe EnrollmentsController, type: :controller do
  let(:school) { create(:school) }
  let(:student) { create(:user, :student, school: school) }
  let(:batch) { create(:batch, course: create(:course, school: school)) }

  before do
    sign_in student
  end

  it "allows student to create enrollment request" do
    post :create, params: { batch_id: batch.id }

    expect(Enrollment.count).to eq(1)
    expect(Enrollment.first.status).to eq("pending")
  end
end

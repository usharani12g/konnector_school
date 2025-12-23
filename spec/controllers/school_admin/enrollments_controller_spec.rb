require 'rails_helper'

RSpec.describe SchoolAdmin::EnrollmentsController, type: :controller do
  let(:school) { create(:school) }
  let(:school_admin) { create(:user, :school_admin, school: school) }
  let(:student) { create(:user, :student, school: school) }
  let(:batch) { create(:batch, course: create(:course, school: school)) }
  let(:enrollment) { create(:enrollment, user: student, batch: batch) }

  before do
    sign_in school_admin
  end

  it "approves enrollment" do
    patch :approve, params: { id: enrollment.id }

    expect(enrollment.reload.status).to eq("approved")
  end
end

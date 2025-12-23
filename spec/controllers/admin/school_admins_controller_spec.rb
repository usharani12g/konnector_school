require "rails_helper"

RSpec.describe Admin::SchoolAdminsController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:school) { create(:school) }

  before do
    sign_in admin
  end

  it "creates a school admin" do
    expect {
      post :create, params: {
        school_id: school.id,
        user: {
          email: "admin1@school.com",
          password: "test1234",
          password_confirmation: "test1234"
        }
      }
    }.to change(User.school_admin, :count).by(1)
  end
end

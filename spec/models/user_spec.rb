RSpec.describe User, type: :model do
  it "defaults role correctly" do
    user = build(:user)
    expect(user.role).to be_present
  end

  it "allows only valid roles" do
    expect {
      User.new(role: "invalid")
    }.to raise_error(ArgumentError)
  end
end

class Api::V1::AuthController < ActionController::API
  def login
    user = User.find_by(email: params[:email])

    if user&.valid_password?(params[:password])
      sign_in(user)
      render json: {
        message: "Login successful",
        role: user.role,
        school_id: user.school_id
      }
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end
end

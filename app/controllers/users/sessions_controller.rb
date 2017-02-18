class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  def create
    if valid_session?
      set_flash_message :success, :signed_in
      sign_in(resource_name, @resource_user)
      redirect_to root_path
    else
      error_session
    end
  end

  protected

  def message_error
    'Invalid Email Address or Password.'  
  end

  def valid_session?
    @resource_user = User.find_by_email(params[:user][:email])
    error_session and return if not_exist_session?
    Devise.secure_compare(password_manager(@resource_user), @resource_user.encrypted_password)
  end

  def error_session
    flash[:danger] = message_error
    redirect_to(new_user_session_path) and return 
  end

  def not_exist_session?
    @resource_user.blank? || @resource_user.encrypted_password.blank?
  end

  def password_manager(resource)
    bcrypt = BCrypt::Password.new(resource.encrypted_password)
    BCrypt::Engine.hash_secret("#{params[:user][:password]}#{resource.class.pepper}", bcrypt.salt)
  end

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:user, keys: [:email, :password])
  end
end

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    @user = User.from_omniauth(request.env["omniauth.auth"])
    store_location_for(@user, current_user_profile_path) if @user.new_record?
    if @user.persisted? || @user.save
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Twitter") if is_navigational_format?
    else
      session["devise.omniauth_data"] = request.env["omniauth.auth"]
      flash[:error] = "There was a problem signing you in through Twitter. Please register or try signing in later."
      redirect_to new_user_registration_url
    end
  end

  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    store_location_for(@user, current_user_profile_path) if @user.new_record?
    if @user.persisted? || @user.save
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.omniauth_data"] = request.env["omniauth.auth"]
      flash[:error] = "There was a problem signing you in through Facebook. Please register or try signing in later."
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end

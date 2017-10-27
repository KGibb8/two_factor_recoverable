require 'devise/version'

class Devise::TwoFactorRecoveryController < DeviseController
  prepend_before_action :authenticate_scope!
  before_action :prepare_and_validate

  def show
  end

  def update
    render :show and return if params[:recovery_code].nil?

    if resource.authenticate_recovery(params[:recovery_code])
      after_recovery_success_for(resource)
    else
      after_recovery_fail_for(resource)
    end
  end

  private

  def after_recovery_success_for(resource)
    set_remember_two_factor_cookie(resource)

    warden.session(resource_name)[TwoFactorAuthentication::NEED_AUTHENTICATION] = false

    if respond_to?(:bypass_sign_in)
      bypass_sign_in(resource, scope: resource_name)
    else
      sign_in(resource_name, resource, bypass: true)
    end
    set_flash_message :notice, :success
    resource.update_attribute(:second_factor_recovery_count, 0)

    redirect_to after_recovery_success_path_for(resource)
  end

  def set_remember_two_factor_cookie(resource)
    expires_seconds = resource.class.remember_otp_session_for_seconds

    if expires_seconds && expires_seconds > 0
      cookies.signed[TwoFactorAuthentication::REMEMBER_TFA_COOKIE_NAME] = {
          value: "#{resource.class}-#{resource.public_send(Devise.second_factor_resource_id)}",
          expires: expires_seconds.from_now
      }
    end
  end

  def after_recovery_success_path_for(resource)
    stored_location_for(resource_name) || :root
  end

  def after_recovery_fail_for(resource)
    resource.second_factor_recovery_count += 1
    resource.save
    set_flash_message :alert, :attempt_failed, now: true

    if resource.max_login_attempts?
      sign_out(resource)
      render :max_login_attempts_reached
    else
      render :show
    end
  end

  def authenticate_scope!
    self.resource = send("current_#{resource_name}")
  end

  def prepare_and_validate
    redirect_to :root and return if resource.nil?
    @limit = resource.max_login_attempts
    if resource.max_login_attempts?
      sign_out(resource)
      render :max_login_attempts_reached and return
    end
  end
end

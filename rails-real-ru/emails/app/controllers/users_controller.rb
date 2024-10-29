# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])

    flash[:notice] = t('.require_activation') unless @user.active?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) # Предполагается, что эта строка должна быть

    if @user.save
      confirmation_token = @user.generate_confirmation_token

      UserMailer.with(
        user: @user,
        confirmation_token:
      ).account_activation.deliver_later
      redirect_to @user, notice: 'Please check your email to activate your account.'
      session[:user_id] = @user.id
    else
      render :new
    end
  rescue StandardError => e
    Rails.logger.error "Failed to create user: #{e.message}"
    render :new, alert: 'Something went wrong. Please try again.'
  end

  def confirm
    redirect_to :new unless params[:confirmation_token]

    user = User.find_by confirmation_token: params[:confirmation_token]

    if user.may_activate?
      user.activate!
      sign_in user

      redirect_to user, notice: t('.activated')
    else
      redirect_to root_url, notice: t('.activate_problems')
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end

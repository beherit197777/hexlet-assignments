# frozen_string_literal: true

class Api::V2::UsersController < Api::ApplicationController
  # BEGIN
  def index
    render json: User.all, each_serializer: UserSerializer
  end

  def show
    render json: User.find(params[:id]), serializer: UserSerializer
  end
  # END
end

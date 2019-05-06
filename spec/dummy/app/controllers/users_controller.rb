# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find_by_username(params[:username])

    if current_user&.username&.casecmp(params[:username])&.zero?
      # user looking at own profile is as good a time as any
      # to pull info from keybase about proofs (i.e. to see if any
      # have been revoked).
      @user.keybase_proofs.each(&:refresh)
    end
  end

  def create
    params.permit!
    @user = User.new(params.slice(:username, :password))
    if @user.save
      flash[:alert] = 'user create worked'
    else
      flash[:alert] = 'user not created'
    end

    redirect_to root_url
  end
end

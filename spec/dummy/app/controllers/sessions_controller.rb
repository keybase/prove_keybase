# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:alert] = 'logged in!'
    else
      flash[:alert] = 'invalid'
    end
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    flash[:alert] = 'logged out'
    redirect_to root_url
  end
end

# frozen_string_literal: true

class ProfileController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = current_user

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render xml: @user }
    end

    @discussions = @user.discussions.order('created_at desc').page params[:page]
    @arguments = @user.arguments
    @replies = @user.replies
  end
end

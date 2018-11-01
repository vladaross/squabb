# frozen_string_literal: true

class ArgumentsController < ApplicationController
  before_action :set_argument, only: %i[update destroy]
  before_action :set_discussion, only: %i[new create edit]
  before_action :authenticate_user!

  def new
    @argument = Argument.new
  end

  def edit
    @argument = Argument.find(params[:argument_id])
  end

  def create
    @argument = Argument.new(params[:argument].permit(:content, :discussion_id))
    @argument.user_id = current_user.id

    respond_to do |format|
      if @argument.save
        format.html { redirect_to @argument.discussion, notice: 'Argument was successfully created.' }
        format.json { render :show, status: :created, location: @argument }
      else
        format.html { redirect_to @argument.discussion, alert: 'Ouch! Some problem here' }
        format.json { render json: @argument.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if EditPolicy.argument_can_be_edited?(@argument, current_user) && @argument.update_attributes(params[:argument].permit(:content))
        format.html { redirect_to @argument.discussion, notice: 'Argument was successfully updated.' }
        format.json { render :show, status: :ok, location: @argument }
      else
        format.html { redirect_to @argument.discussion, alert: 'You dont have permition!' }
        format.json { render json: @argument.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if current_user.has_role?(:admin) && @argument.destroy
        format.html { redirect_to @argument.discussion, notice: 'Argument was successfully destroyed.' }
      else
        format.html { redirect_to @argument.discussion, alert: 'You dont have permition!' }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_argument
    @argument = Argument.find(params[:id])
  end

  def set_discussion
    @discussion = Discussion.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def argument_params
    params.require(:argument).permit(:argument)
  end
end

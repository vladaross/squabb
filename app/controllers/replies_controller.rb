# frozen_string_literal: true

class RepliesController < ApplicationController
  before_action :set_reply, only: %i[show update destroy]
  before_action :authenticate_user!

  # GET /replies/new
  def new
    @argument_id = params[:argument_id]
    @reply = Reply.new
  end

  # GET /replies/1/edit
  def edit
    @reply = Reply.find(params[:reply_id])
  end

  # POST /replies
  # POST /replies.json
  def create
    @reply = Reply.new(params[:reply].permit(:content, :argument_id))
    @reply.user_id = current_user.id

    respond_to do |format|
      if @reply.save
        format.html { redirect_to @reply.argument.discussion, notice: 'Reply was successfully created.' }
        format.json { render :show, status: :created, location: @reply }
      else
        format.html { redirect_to @reply.argument.discussion, notice: 'Ouch! Some problem here' }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /replies/1
  # PATCH/PUT /replies/1.json
  def update
    respond_to do |format|
      if EditPolicy.reply_can_be_edited?(@reply, current_user) && @reply.update_attributes(params[:reply].permit(:content))
        format.html { redirect_to @reply.argument.discussion, notice: 'Reply was successfully updated.' }
        format.json { render :show, status: :ok, location: @reply }
      else
        format.html { redirect_to @reply.argument.discussion, alert: 'You dont have permition!' }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replies/1
  # DELETE /replies/1.json
  def destroy
    respond_to do |format|
      if current_user.has_role?(:admin) && @reply.destroy
        format.html { redirect_to @reply.argument.discussion, notice: 'Reply was successfully destroyed.' }
      else
        format.html { redirect_to @reply.argument.discussion, alert: 'You dont have permition!' }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reply
    @reply = Reply.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def reply_params
    params.require(:reply).permit(:reply)
  end
end

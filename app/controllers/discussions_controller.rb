# frozen_string_literal: true

class DiscussionsController < ApplicationController
  before_action :set_discussion, only: %i[show edit update destroy vote]
  before_action :authenticate_user!, except: %i[index show popular most_upvoted]

  # GET /discussions
  # GET /discussions.json
  def index
    @discussions = Discussion.all.order('created_at desc').page params[:page]
  end

  def popular
    # This better to be a column in Discussion if your base is big
    @discussions = Discussion.all.sort_by { |m| m.arguments.count }.reverse
    @discussions = Kaminari.paginate_array(@discussions).page(params[:page]).per(10)
  end

  def most_upvoted
    # This better to be a column in Discussion if your base is big
    @discussions = Discussion.all.sort_by { |m| m.votes.sum(:value) }.reverse
    @discussions = Kaminari.paginate_array(@discussions).page(params[:page]).per(10)
  end

  # GET /discussions/1
  # GET /discussions/1.json
  def show
    @discussions = Discussion.all.order('created_at desc')
  end

  # GET /discussions/new
  def new
    @discussion = current_user.discussions.build
    @categories = Category.all
  end

  # GET /discussions/1/edit
  def edit
    @categories = Category.all
  end

  # POST /discussions
  # POST /discussions.json
  def create
    @discussion = current_user.discussions.build(discussion_params)
    respond_to do |format|
      if @discussion.save
        format.html { redirect_to @discussion, notice: 'Discussion was successfully created.' }
        format.json { render :show, status: :created, location: @discussion }
      else
        @categories = Category.all
        format.html { render :new, categories: @categories }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /discussions/1
  # PATCH/PUT /discussions/1.json
  def update
    respond_to do |format|
      if (EditPolicy.discussion_can_be_edited?(@discussion, current_user) || current_user.has_role?(:admin)) && @discussion.update(discussion_params)
        format.html { redirect_to @discussion, notice: 'Discussion was successfully updated.' }
        format.json { render :show, status: :ok, location: @discussion }
      else
        format.html { redirect_to @discussion, notice: 'You dont have permition!' }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discussions/1
  # DELETE /discussions/1.json
  def destroy
    respond_to do |format|
      if (EditPolicy.discussion_can_be_edited?(@discussion, current_user) || current_user.has_role?(:admin)) && @discussion.destroy
        format.html { redirect_to discussions_url, notice: 'Discussion was successfully destroyed.' }
      else
        format.html { redirect_to discussions_url, alert: 'You dont have permition!' }
        format.json { head :no_content }
      end
    end
  end

  # POST /discussions/1/vote
  def vote
    respond_to do |format|
      if DiscussionsMembersWorker.create(@discussion.id, current_user.id, params[:side])
        format.html { redirect_to @discussion, notice: 'You vote successfully.' }
        format.json { render :show, status: :ok, location: @discussion }
      else
        format.html { render :show }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /discussions/search
  def search
    @discussions = Discussion.search(params[:search])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_discussion
    @discussion = Discussion.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def discussion_params
    params.require(:discussion).permit(:left_side, :right_side, :question, :category_id, :side)
  end
end

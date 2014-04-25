class DiscussionsController < ApplicationController
  before_action :authorize, only: [:new, :create]

  def new
    @discussion_form = DiscussionForm.new
    @types = ["Image", "Document", "Code", "Video", "Audio"]
  end

  def show
    @discussion = Discussion.find_by(token: params[:id])
    @comments = @discussion.comments.recent
    @comment = Comment.new
    @content = @discussion.content
  end

  def create
    @discussion_form = DiscussionForm.new(form_params)
    @types = ["Image", "Document", "Code", "Video", "Audio"]
    if @discussion_form.valid?
      content = @discussion_form.persist
      redirect_to content.discussion
    else
      render :new
    end
  end

  private

  def form_params
    params.require(:discussion_form).
      permit(
        :name,
        :type,
        :subject
        ).
      merge(user: current_user)
  end

  def discussion_params
    params.require(:discussion).permit(:name)
  end
end

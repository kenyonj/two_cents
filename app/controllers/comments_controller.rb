class CommentsController < ApplicationController
  respond_to :js, :html

  def create
    discussion = find_discussion
    if discussion.open?
      comment = discussion.comments.create(comment_params)
      process_comment(comment)
    else
      render :closed
    end
  end

  private

  def comment_params
    params.require(:comment).
      permit(
        :body,
        :username
      )
  end

  def find_discussion
    Discussion.find_by(token: params[:discussion_id])
  end
end

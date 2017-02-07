class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = Micropost.find_by id: params[:id]
    @comment = @micropost.comments.build comment_params
    @comment.user_id = params[:user_id]
    if @comment.save
      respond_to do |format|
        format.html {redirect_to root_url}
        format.js
      end
    else
      @feed_items = []
      render "static_pages/home"
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

end

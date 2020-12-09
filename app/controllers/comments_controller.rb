class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      # redirect_to "/prototypes/#{@comment.prototype.id}"
      redirect_to prototype_path(@comment.prototype.id)
      # redirect_to prototype_path, method: :get
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render "prototypes/show"
    end
  end

  def show
    @comment  = Comment.new
    @comments = @prototype.comments.includes(:user)
    # @comments = @prototype.comments
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
    # params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:id])
  end
end

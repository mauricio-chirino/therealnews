class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :admin_only, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @post, notice: 'Comentario creado con éxito.'
    else
      redirect_to @post, alert: 'No se pudo crear el comentario.'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @comment.post, notice: 'Comentario eliminado.'
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def admin_only
    redirect_to root_path, alert: 'No autorizado' unless current_user.admin?
  end
end

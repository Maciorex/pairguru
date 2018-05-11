class CommentsController < ApplicationController
  def create
    @movie = Movie.find(params[:movie_id])
    if current_user.comments.where(movie_id: @movie.id).count >= 1
      flash[:danger] = "You can only post one comment under each movie"
    else
      @comment = @movie.comments.create(comment_params)
      @comment.user_id = current_user.id

      if @comment.save
        flash[:success] = "Successfully created a comment"
      else
        flash[:danger] = "Your comment is invalid, check it again"
      end
    end
    redirect_to movie_path(@movie)
  end

  def edit
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.find(params[:id])
    if @comment.update(comment_params)
      flash[:success] = "Comment edited"
      redirect_to movie_path(@movie)
    end
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.find(params[:id])
    @comment.destroy
    flash[:danger] = "Your comment has been deleted!"
    redirect_to movie_path(@movie)
  end

  def commenters
    @commenters = User.joins(:comments).group("users.id").where("comments.created_at >= ?", 1.week.ago.utc).order("count(comments.id) desc").limit(10)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end

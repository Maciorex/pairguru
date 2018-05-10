class CommentsController < ApplicationController
before_action :find_movie

  def create
    if current_user.comments.where(movie_id: @movie.id).count >= 1
      flash[:danger] = "You can only post one comment under each movie"
      redirect_to movie_path(@movie)
    else
      @comment = @movie.comments.create(comment_params)
      @comment.user_id = current_user.id
      @comment.save
      
      if @comment.save
        flash[:success] = "Successfully created a comment"
        redirect_to movie_path(@movie)
      else
        flash[:danger] = "Your comment is invalid, check it again"
        redirect_to movie_path(@movie)
      end
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def find_movie
      @movie = Movie.find(params[:movie_id])
    end
end

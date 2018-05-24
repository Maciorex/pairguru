class GradesController < ApplicationController

  def create
    @movie = Movie.find(params[:movie_id])
    @grade = @movie.grades.create(grade_params)
    
    unless @grade.errors.any?
      flash[:notice] = "Movie grade saved, thanks buddy!"
    else
      flash[:notice] = "Grade not saved"
    end
    redirect_to movie_path(@movie)
  end



  private

  def grade_params
    params.require(:grade).permit(:value, :user_id)
  end
end

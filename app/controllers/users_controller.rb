class UsersController < ApplicationController
  def index
    @user = current_user
    @users = User.all
    @new_book = Book.new
  end
  def show
  	@user = User.find(params[:id])
    @new_book = Book.new
  	@books = @user.books.all
  end
  def edit
  	@user = current_user
    @correct_user = User.find(params[:id])
    if @correct_user.id == current_user.id
      render "edit"
    else
      redirect_to(user_url(current_user))  
    end
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "successfully updated!"
    redirect_to user_path(@user.id) 
    else
      render "edit"
    end
  end
  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end

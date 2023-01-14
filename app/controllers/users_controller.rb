class UsersController < ApplicationController
  before_action:is_matching_login_user,only:[:edit,:update]
  
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end
  
  def index
    @book = Book.new
    @user = current_user
    @user_all = User.all
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if  @user.update(user_params)
        flash[:notice] = "You have updated user successfully."
        redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end
  
  def is_matching_login_user
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
  
end

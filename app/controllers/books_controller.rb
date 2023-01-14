class BooksController < ApplicationController
  before_action:is_matching_login_user,only:[:edit,:update]
  
  def index
    @book = Book.new
    @book_all = Book.all
    @user = current_user
  end
  
  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
       flash[:notice] = "You have created book successfully."
       redirect_to book_path(@book.id)
    else
      @book_all = Book.all
      @user = current_user
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "You have updated book successfully."
       redirect_to book_path(@book.id)
    else
       render :edit
    end
  end

  def show
    @book = Book.new
    @book_find = Book.find(params[:id])
    @user = @book_find.user
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
    
  private
  
  def book_params
    params.require(:book).permit(:title,:body)
  end
  
  def is_matching_login_user
   book = Book.find(params[:id].to_i)
    unless book.user_id == current_user.id
     redirect_to books_path
    end
  end
 
end

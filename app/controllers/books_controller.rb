class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, {only: [:edit]}

  def index
  	@book = Book.new
  	@books = Book.all
  	@user = current_user
  	@users = User.all
  end

  def create
  	@book = Book.new(book_params)
  	@books = Book.all
  	@book.user_id = current_user.id
  	@user = current_user
  	@users = User.all
  	if @book.save
  	redirect_to books_path(@book), flash: {notice: "You have creatad book successfully."}
  else
  	render :index
    end
  end

  def show
  	@book = Book.find(params[:id])
    @books = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to book_path(@book), flash: {notice: "You have updated book successfully."}
    else
    	render :edit
    end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path
  end

  private
  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    @book.user.id = current_user.id
    if @current_user.id != @book.user_id
      redirect_to books_path
    end
  end

end

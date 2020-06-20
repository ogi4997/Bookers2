class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @book = Book.new
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_path(@user.id), flash: {notice: "You have updated user successfully.4"}
     else
      render :edit
    end
  end

  def index
  	@users = User.all
  	@user = current_user
    @book = Book.new
  end

  def create
    book = Book.new(book_params)
    book.save
    redirect_to books_path(@book.id)
  end

  private
  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def book_paramas
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @user = current_user
    user = User.find(params[:id])
    redirect_to current_user if current_user != user
  end
end

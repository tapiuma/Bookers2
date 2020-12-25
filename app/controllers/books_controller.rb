class BooksController < ApplicationController
  def new
  	@book = Book.new
  	book = Book.new(book_params)
  end

  def create
  	 book = Book.new(book_params)
  	 book.user_id = current_user.id
     @new_book = book
     @user = current_user
		if book.save
      flash[:notice] = "successfully create!"
			redirect_to book_path(book.id)
    else
      @msg='error!'
      @book = book
      @books = Book.all
      render 'index'
		end
  end

  def index
  	@books = Book.all
  	@user = current_user
  	@new_book = Book.new
    @book = Book.new
  end

  def show
  	@book = Book.find(params[:id])
  	@user = User.find_by(id: @book.user_id)
  	@new_book = Book.new
  end

  def edit
  	@book = Book.find(params[:id])
    if @book.user.id == current_user.id
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
  	book = Book.find(params[:id])
  	if book.update(book_params)
      flash[:notice] = "successfully updated!"
  	  redirect_to book_path(book.id)
    else
      @msg='error!'
      @user =current_user
      @book = book
      render 'edit'
    end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	redirect_to books_path
  end

    private
  	def book_params
  		params.require(:book).permit(:title, :body)
    end
end
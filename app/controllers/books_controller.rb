class BooksController < ApplicationController

  def index
  @books=Book.all

  @book=Book.new

  end

  def create

    @book = Book.new(book_params)

    @book.user_id = current_user.id

    if @book.save
       flash[:success]='Book was successfully updated'

    redirect_to book_path(@book)

    else
      @books = Book.all.order(id: :asc)
      render :index

    end

  end

 def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
 end

 def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
 end

 def edit
   @book = Book.find(params[:id])
   if @book.user == current_user
        render :edit
   else
        redirect_to books_path
   end
 end

 def update
    @book = Book.find(params[:id])


    if @book.update(book_params)
        flash[:success]='Book was successfully updated'

    redirect_to book_path(@book.id)

    else

    render 'edit'

    end

 end

  private
  def book_params
    params[:book].permit(:title, :body, :user_id)

  end



end

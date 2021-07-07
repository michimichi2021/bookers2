class UsersController < ApplicationController



 def index
    @user = current_user
    @users = User.all
    @book = Book.new
 end



  def show
    @book = Book.new
    @user=User.find(params[:id])
    @books = @user.books
  end

  def edit
   @user = User.find(params[:id])
    if @user == current_user
        render :edit
    else
        redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])

   if @user.update(user_params)
     flash[:success]='Profile was successfully updated'

    redirect_to user_path(@user.id)
   else

      render 'edit'
   end
  end

  

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end



end

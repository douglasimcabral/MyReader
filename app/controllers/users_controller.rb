class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :retrieve]
  

   
  def show
    @user = User.find(params[:id])
  end
  
  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end
  
  def create
    
    @user = User.new(user_params)
    
    if @user.name.delete(' ') == '' or @user.password.delete(' ') == '' or @user.email.delete(' ') == ''
      redirect_to '/signup', notice: 'Nenhum dos campos podem ficar vazio!'
    else
      if @user.save
       flash[:success] = "Welcome to the Sample App!"
       redirect_to @user
      else
        render 'new'
      end
    end
  end
  
  
  # PATCH/PUT /feeds/1
  def update
     @user = User.find(params[:id])
     @user.update(user_params)
   redirect_to @user
  end
  
  # DELETE /feeds/1
  def destroy
    
      @user.destroy
      redirect_to @user
      
  end

  

  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    
    
    
   

end

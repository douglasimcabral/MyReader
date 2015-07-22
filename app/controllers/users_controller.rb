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
        redirect_to '/signup', notice: 'Favor preencher todos os campos!'
    else
      existeUser = User.find_by_email(@user.email)
     
      if existeUser.nil?
          if @user.save
           flash[:success] = "Bem-vindo ao MyReader!"
           redirect_to @user
          else
            render 'new'
          end
      else   
        redirect_to '/signup', notice: 'Email ja cadastrado!'
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
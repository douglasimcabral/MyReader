class SessionsController < ApplicationController


  def new
    
  end

  def create
    
    user = User.find_by(email: params[:session][:email].downcase, password: params[:session][:password])
   
    if user.nil?
      redirect_to '/login', notice: 'Usuário e senha não encontrado!'
    else
      log_in user
      redirect_to root_url
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end

class Admin::UsersController < AdminController
  require 'rubygems'
  require 'mini_magick'
 # require 'carrierwave/orm/activerecord'
 # mount_uploader :avatar, AvatarUploader
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    respond_to do |format|
      if @user.save
        # Tell the UserMailer to send a welcome email after save
        UserMailer.welcome_email(@user).deliver_now

        format.html { redirect_to [:admin, @user, notice: 'User was successfully created.' ]}
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        
      end
    end
  end
    
  def edit
    @user = User.find(params[:id])
  end

  def update
        @user = User.find(params[:id])

        if @user.update(user_params)
          #save_picture
          redirect_to [:admin, @user]
        else
          render 'edit'
        end
  end

  def destroy
        @user = User.destroy(params[:id])
        redirect_to admin_users_url
  end

  def index
        @users = User.all
  end

  def show
        @user = User.find(params[:id])
  end

  private

  def user_params
        params.require(:user).permit(:avatar, :name, :email, :password, :password_confirmation, :admin)
  end
  
end

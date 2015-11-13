class UsersController < ApplicationController
    # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
 
    respond_to do |format|
      if @user.save
        UserMailer.welcome_email(@user).deliver_later
 
        format.html { redirect_to(@user, notice: 'User was successfully created.') }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    
    def edit
    @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])

        if @user.update(user_params)
          save_picture
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
        params.require(:user).permit(:title, :description, :price, :category_id)
    end
  end
end

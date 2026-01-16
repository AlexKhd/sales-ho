class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]

  def index
    authorize User
    @roles = Role.all
    @users = User.all.order(:userid)
    if params[:role]
      @users = User.with_role(params[:role])
    end
  end

  def show
    authorize @user
  end

  def new
    authorize User
    @user = User.new
  end

  def edit
    authorize @user
  end

  def create
    authorize User
    @user = User.new(user_params)
    # Temporary password generation like in sales app
    initial_fake_pwd = Array.new(8) { [ *"A".."Z", *"0".."9" ].sample }.join
    @user.password = initial_fake_pwd
    @user.password_confirmation = initial_fake_pwd
    @user.skip_confirmation!

    if @user.save
      redirect_to users_path, notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @user
    if params[:user][:password].present? && params[:user][:password].length > 5
    # If password provided, update it
    else
       params[:user].delete(:password)
       params[:user].delete(:password_confirmation)
    end

    if @user.update(user_params)
      redirect_to users_path, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @user
    @user.destroy
    redirect_to users_url, notice: "User was successfully deleted."
  end

  private
    def set_user
      @user = User.find_by!(userid: params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :name, :blocked, :nickname, :password, :password_confirmation, role_ids: [])
    end
end

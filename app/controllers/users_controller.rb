class UsersController < ApplicationController
    
    before_action :find_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user, only: [:edit, :update]
    before_action :check_same_user_or_admin, only: [:edit, :update]
    before_action :require_admin, only: [:destroy]
    
    def index
        @users = User.paginate(page: params[:page], per_page: 2)
    end
    
    def new
        @user = User.new
    end
    
    def show
        @user_comments = @user.comments.paginate(page: params[:page], per_page: 2)
    end
    
    def edit
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:success] = "Wellcome to the Comment section #{@user.username}"
            redirect_to user_path(@user)
        else
            render :new
        end
    end
    
    def update
        if @user.update(user_params)
            flash[:success] = "Your profile was successfully edited"
            redirect_to user_path(@user)
        else
            render "edit"
        end
    end
    
    def destroy
        @user.destroy
        flash[:danger] = "User and all articles created by user have been deleted"
        redirect_to users_path
    end
    
    def user_params
       params.require(:user).permit(:username, :email, :password) 
    end
    
    def find_user
        @user = User.find(params[:id])
    end
    
    def check_same_user_or_admin
        if current_user != @user and !current_user.admin?
            flash[:danger] = "You can only edit your own account"
            redirect_to users_path
        end
    end
    
    def require_admin
        if logged_in? and !current_user.admin?
            flash[:danger] = "Only admin users can perform that action"
            redirect_to root_path
        end
    end
    
    def home
    end
end

#debugger
        #render plain: params[:user].inspect
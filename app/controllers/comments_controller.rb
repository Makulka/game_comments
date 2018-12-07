class CommentsController < ApplicationController 
    before_action :find_comment, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:index, :show]
    before_action :check_same_user_or_admin, only: [:edit, :update, :destroy]
    
    def index
        @comments = Comment.paginate(page: params[:page], per_page: 3)
    end
    
    def show
    end
    
    def new
        @comment = Comment.new
    end
    
    def edit
    end
    
    def create
        @comment = Comment.new(comment_params)
        @comment.user = current_user
        if @comment.save
            flash[:success] = "Thank you for submitting a comment"
            redirect_to comment_path(@comment)
        else
            render "new"
        end
    end
    
    def update
        if @comment.update(comment_params)
            flash[:success] = "Thank you for updating your comment"
            redirect_to comment_path(@comment)
        else
            render "edit"
        end
    end
    
    def destroy
        @comment.destroy
        flash[:danger] = "your comment was deleted"
        redirect_to comments_path
    end
    
    
    
    def comment_params
        params.require(:comment).permit(:title, :description, category_ids: [])
    end
    
    def find_comment
        @comment = Comment.find(params[:id])
    end
    
    def check_same_user_or_admin
        if current_user != @comment.user and !current_user.admin?
            flash[:danger] = "You can only edit your own comments"
            redirect_to comments_path
        end
    end
end


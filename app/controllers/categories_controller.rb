class CategoriesController < ApplicationController
    
    before_action :find_category, only: [:show, :edit, :update]
    before_action :require_user, except: [:index, :show]
    before_action :require_admin, except: [:index, :show]
    
    def index
        @categories = Category.paginate(page: params[:page], per_page: 5)
    end
    
    def show
        @category_comments = @category.comments.paginate(page: params[:page], per_page: 2)
    end
    
    def new
        @category = Category.new
    end
    
    def edit
    end
    
    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:success] = "Category was successfully created"
            redirect_to categories_path
        else
            render :new
        end
    end
    
    def update
        if @category.update(category_params)
            flash[:success] = "Category was successfully updated"
            redirect_to category_path(@category)
        else
            render :new
        end
    end
    
    def category_params
        params.require(:category).permit(:name)
    end
    
    def find_category
        @category = Category.find(params[:id])
    end
    
    
end
class CommentCategory < ApplicationRecord 
    belongs_to :comment
    belongs_to :category
end
class Category < ApplicationRecord
    has_many :comment_categories
    has_many :comments, through: :comment_categories
    
    validates :name, presence: true, length: {minimum: 3, maximum: 25}
    validates_uniqueness_of :name
end
class Batch < ApplicationRecord
    belongs_to :course
    has_many :enrollments, dependent: :destroy
    has_many :users, through: :enrollments
end

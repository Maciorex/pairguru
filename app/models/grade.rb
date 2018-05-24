class Grade < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  validates :value, inclusion: { in: 1..10 }
  validates :user_id, uniqueness: { scope: :movie_id }
end

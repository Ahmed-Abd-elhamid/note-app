class Note < ApplicationRecord
  belongs_to :user
  has_many :collaborations, dependent: :destroy

  default_scope { order(created_at: :desc)}

  validates :title, presence: true, length: { in: 3..50 }
  validates :body, length: { maximum: 10000 }
end

class Issue < ActiveRecord::Base
  belongs_to :created_by, class_name: "User"
  has_many :threads, class_name: "MessageThread"

  validates :title, presence: true

  validates :created_by, presence: true
end

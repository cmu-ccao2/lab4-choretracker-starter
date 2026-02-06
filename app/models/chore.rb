class Chore < ApplicationRecord
  belongs_to :child
  belongs_to :task

  validates :child_id, presence: true
  validates :task_id, presence: true
  validates :due_date, presence: true

  scope :due_soon, -> { where('due_date <= ?', Date.today + 3.days).order(:due_date) }
end

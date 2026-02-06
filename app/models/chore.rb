class Chore < ApplicationRecord
  belongs_to :child
  belongs_to :task

  validates_presence_of :child_id
  validates_presence_of :task_id
  validates_presence_of :due_on
  validates_date :due_on

  scope :due_on, ->(date) { where(due_on: date) }
  scope :by_task, -> { joins(:task).order('tasks.name ASC') }
  scope :chronological, -> { order(:due_on) }
  scope :pending, -> { where(completed: false) }
  scope :done, -> { where(completed: true) }
  scope :upcoming, -> { where('due_on >= ?', Date.today) }
  scope :past, -> { where('due_on < ?', Date.today) }

  def status
    completed ? "Completed" : "Pending"
  end
end

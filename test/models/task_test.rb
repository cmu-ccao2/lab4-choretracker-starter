require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  # 1. Association tests
  should have_many(:chores)
  should have_many(:children).through(:chores)

  # 2. Validation tests
  should validate_presence_of(:name)
  
  # 3. Numericality tests
  # 'only_integer' ensures it's an integer; 'is_greater_than(0)' ensures it's positive
  should validate_numericality_of(:points).only_integer.is_greater_than(0)

  # Scope: alphabetical
  test "alphabetical scope orders tasks by name" do
    # Create tasks in non-alphabetical order
    @zeta = Task.create!(name: "Zeta", points: 1, active: true)
    @alpha = Task.create!(name: "Alpha", points: 1, active: true)
    @beta = Task.create!(name: "Beta", points: 1, active: true)

    assert_equal ["Alpha", "Beta", "Zeta"], Task.alphabetical.map(&:name)
  end

  # Scope: active
  test "active scope only returns active tasks" do
    @active_task = Task.create!(name: "Clean", points: 1, active: true)
    @inactive_task = Task.create!(name: "Sweep", points: 1, active: false)

    assert_includes Task.active, @active_task
    refute_includes Task.active, @inactive_task
  end
end

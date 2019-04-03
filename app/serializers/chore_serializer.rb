class ChoreSerializer < ActiveModel::Serializer
  attributes :id, :child_id, :task, :due_on, :completed
  #has_many :tasks 

  def task
    ChoreTaskSerializer.new(object.task)
  end

  def completed
	  object.status
	end
end

class TaskSerializer < ApplicationSerializer
  attributes :id, :title, :done, :position, :deadline

  has_many :comments
end

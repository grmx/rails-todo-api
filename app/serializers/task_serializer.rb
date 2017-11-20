class TaskSerializer < ApplicationSerializer
  attributes :id, :title, :done, :position, :deadline
end

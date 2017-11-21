class ProjectSerializer < ApplicationSerializer
  attributes :id, :title

  has_many :tasks
end

class Astronaut < ApplicationRecord
  has_many :astronaut_missions
  has_many :missions, through: :astronaut_missions

  validates_presence_of :name, :age, :job

  def total_space_time
    missions.sum(:time_in_space)
  end

  def average_age
    Astronaut.average(:age)
  end
end

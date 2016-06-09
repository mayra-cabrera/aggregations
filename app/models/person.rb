class Person < ActiveRecord::Base
  belongs_to :location
  belongs_to :role
  belongs_to :manager, class_name: "Person", foreign_key: :manager_id
  has_many :employees, class_name: "Person", foreign_key: :manager_id

  def self.maximum_salary_by_location
    group("location_id").maximum(:salary)
  end

  def self.managers_by_average_salary_difference
    joins("LEFT JOIN people employees ON employees.manager_id = people.id").
    group("people.name").
    average("employees.salary")
  end
end

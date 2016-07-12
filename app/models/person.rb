class Person < ActiveRecord::Base
  belongs_to :location
  belongs_to :role
  belongs_to :manager, class_name: "Person", foreign_key: :manager_id
  has_many :employees, class_name: "Person", foreign_key: :manager_id

  def self.maximum_salary_by_location
    group("location_id").maximum(:salary)
  end

  def self.managers_by_average_salary_difference
    select("people.name, AVG(people.salary) as avg_people_salary").
      joins(:employees).
      group("people.manager_id, people.name").order("avg_people_salary")
  end
end

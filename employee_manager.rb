class Employee
  attr_reader :name, :title, :boss

  def initialize name, salary, title, boss
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    boss.add_employee(self) unless boss.nil?
  end

  def bonus(multiplier)
    salary * multiplier
  end

  protected
  attr_reader :salary
end


class Manager < Employee

  attr_reader :employees
  def initialize name, salary, title, boss
    super
    @employees = []
  end

  def bonus multiplier
    total_salary = 0
    emps = employees.dup
    until emps.empty?
      current_employee = emps.shift
      total_salary += current_employee.salary
      if current_employee.is_a?(Manager)
        emps += current_employee.employees
      end
    end

    total_salary * multiplier
  end

  def add_employee(emp)
    employees << emp unless employees.include?(emp)
  end
end


ned = Manager.new("Ned",1000000, "Founder", nil)
darren = Manager.new("Darren", 78000, "TA Manager", ned)
shawna = Employee.new("Shawna", 12000, "TA", darren )
david = Employee.new("David", 10000, "TA", darren )


p ned.bonus(5)
p darren.bonus(4)
p david.bonus(3)

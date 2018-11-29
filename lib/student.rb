class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @name = name
    @id = id
    @grade = grade
  end

  def self.create_table
    sql = <<-SQL
    create table students (id integer primary key, name text, grade integer);
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
    drop table students
    SQL

    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
    insert into students(name, grade) values(?,?);
    SQL
    DB[:conn].execute(sql, @name, @grade)
    @id = DB[:conn].execute("select * from students desc limit 1")[0][0]
  end

  def self.create(name:, grade:)
    new_student = Student.new(name, grade)
    @id = new_student.save
    new_student
  end

end

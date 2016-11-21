require 'sqlite3'

class Task
  attr_reader :title, :description, :id

  def initialize(params)
    @description = params["description"]
    @title = params["title"]
    @database = SQLite3::Database.new('db/task_manager_development.db')
    @database.results_as_hash = true
    @id = params["id"] if params["id"]
  end

  def save
    @database.execute("INSERT INTO tasks (title, description) VALUES (?,?);", @title, @description)
  end

  def self.all
    tasks = database.execute("SELECT * FROM tasks")
    tasks.map do |task|
      Task.new(task)
    end
  end

  def self.database
    database = SQLite3::Database.new('db/task_manager_development.db')
    database.results_as_hash = true
    database
  end

  def self.find(id)
    task = database.execute("SELECT * FROM tasks WHERE id = ?", id).first
    Task.new(task)
  end
end

require 'task'
require 'pg'

DB = PG.connect(:dbname => "to_do_test")

RSpec.configure do |config|
  config.after(:each) do 
    DB.exec("DELETE FROM tasks *;")
  end
end

describe Task do 
  it 'is initialized with a name' do 
    task = Task.new('learn SQL')
    task.should be_an_instance_of Task
  end

  it 'tells you its name' do 
    task = Task.new("learn SQL")
    task.name.should eq "learn SQL"
  end

  it 'starts with no tasks in the database' do
    Task.all.should eq []
  end

  it 'lets you save tasks to the database' do 
    task = Task.new("learn SQL")
    task.save
    Task.all.should eq [task]
  end

  it 'is the same task if it has the same name' do 
    task1 = Task.new("learn SQL")
    task2  = Task.new("learn SQL")
    task1.should eq task2
  end


end
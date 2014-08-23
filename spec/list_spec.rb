require 'list'
require 'pg'

DB = PG.connect(:dbname => "to_do_test")

RSpec.configure do |config|
  config.after(:each) do 
    DB.exec("DELETE FROM lists *;")
  end
end

describe List do 
  it 'is initialized with a name' do 
    list = List.new('My stuff')
    list.should be_an_instance_of List
  end

  it 'tells you its name' do 
    list = List.new('My stuff')
    list.name.should eq 'My stuff'
  end
end
require 'spec_helper'

describe List do 
  it 'is initialized with a name' do 
    list = List.new('My stuff')
    list.should be_an_instance_of List
  end

  it 'tells you its name' do 
    list = List.new('My stuff')
    list.name.should eq 'My stuff'
  end

  it 'is the same list if it has the same name' do 
    list1 = List.new("My stuff")
    list2  = List.new("My stuff")
    list1.should eq list2
  end

  it 'starts off with no lists' do 
    List.all.should eq []
  end

  it 'lets you save lists to the database' do 
    list = List.new("My stuff")
    list.save
    List.all.should eq [list]
  end

  it 'sets its id when you save it' do 
    list = List.new('My stuff')
    list.save
    list.id.should be_an_instance_of Fixnum
  end
end
require './lib/task'
require './lib/list'
require 'pg'
DB = PG.connect(:dbname => "to_do")

def greeting
  spc
  puts "Welcome to Todo CLI"
  main_menu
end

def main_menu
  spc
  puts "Type 'c' to create a list, 't' to create a task, 's' to show your lists or 'd' to delete a list"
  spc
  menu_sel = gets.chomp.downcase
  case menu_sel
  when 'c'
    create_list
  when 't'
    create_task
  when 's'
    show_lists
  when 'd'
    delete_list
  else
    puts "Try again."
    main_menu
  end
end

def spc
  puts "\n"
end

def create_list
  spc
  puts "List name?"
  spc
  list_name = gets.chomp.split.map(&:capitalize).join(' ')
  @list = List.new(list_name)
  @list.save
  spc
  puts "List '#{list_name}' has been created."
  main_menu
end

def show_lists
  spc
  results = DB.exec("SELECT * FROM lists;")
  results.each do |result|
    puts "List #{result['id']}: #{result['name']}" 
  end
  main_menu
end

def create_task
  spc
  puts "You have the following lists:"
  spc
  list_ids = []
  results = DB.exec("SELECT * FROM lists;")
  results.each do |result|
    puts "List #{result['id']}: #{result['name']}"
    list_ids << result['id']
  end
  spc
  puts "Type the number of the list you'd like to use or 'c' to create a new one"
  spc
  create_sel = gets.chomp.downcase
  if list_ids.include?(create_sel)
    id = create_sel
    spc
    puts "Type a name for your task"
    spc
    task_name = gets.chomp.split.map(&:capitalize).join(' ')
    task = Task.new(task_name, id)
    task.save
    spc
    puts "Task '#{task_name}' has been created"
  elsif create_sel == 'c'
    create_list
  else
    puts "Follow the instructions next time. Returning to the Main menu"
  end
  main_menu

end


def delete_list
end

greeting
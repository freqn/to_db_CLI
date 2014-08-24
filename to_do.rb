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
  puts "Type 'c' to create a list, 's' to show your lists or 'd' to delete a list"
  spc
  menu_sel = gets.chomp.downcase
  case menu_sel
  when 'c'
    create_list
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


def delete_list
end

greeting
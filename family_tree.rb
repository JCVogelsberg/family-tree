require 'bundler/setup'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def menu
  puts 'Welcome to the family tree!'
  puts 'What would you like to do?'

  loop do
    puts 'Press a to add a family member.'
    puts 'Press l to list out the family members.'
    puts 'Press m to add who someone is married to.'
    puts 'Press s to see who someone is married to.'
    puts 'Press c add a child to a family.'
    puts "Press p to see a child's parents."
    puts 'Press e to exit.'
    choice = gets.chomp

    case choice
    when 'a'
      add_person
    when 'l'
      list
    when 'm'
      add_marriage
    when 's'
      see_marriage
    when 'c'
      add_child
    when 'p'
      list
      puts "Enter the child to see their parents."
      child_id = gets.chomp.to_i
      child = Person.find(child_id)
      see_parents(child)
    when 'e'
      exit
    end
  end
end

def add_person
  puts 'What is the name of the family member?'
  name = gets.chomp
  Person.create(:name => name)
  puts name + " was added to the family tree.\n\n"
end

def add_marriage
  list
  puts 'What is the number of the first spouse?'
  spouse1 = Person.find(gets.chomp.to_i)
  puts 'What is the number of the second spouse?'
  spouse2 = Person.find(gets.chomp.to_i)
  new_marriage = Parent.create(:person1_id => spouse1.id, :person2_id => spouse2.id)
  puts spouse1.name + " is now married to " + spouse2.name + "."
end

def list
  puts 'Here are all your relatives:'
  people = Person.all
  people.each do |person|
    puts person.id.to_s + " " + person.name
  end
  puts "\n"
end

def see_marriage
  list
  puts "Enter the number of the relative and I'll show you who they're married to."
  person_id = gets.chomp.to_i
  first_spouse = Person.find(person_id)

  spouse = Parent.find_spouse(first_spouse)
  puts "#{first_spouse.name} is married to " + spouse.name + ".\n\n"
end

def show_all_marriages
  Parent.all.each do |couple|
    spouse1 = Person.find(couple.person1_id)
    spouse2 = Person.find(couple.person2_id)
    puts "#{couple.id} #{spouse1.name} is married to #{spouse2.name}."
  end
  puts "\n\n"
end

def add_child
  show_all_marriages
  puts "Select the parents that are having a child: "
  parent_id = gets.chomp.to_i
  parent = Parent.find(parent_id)
  list
  puts "Select the number of your child:"
  child_id = gets.chomp.to_i
  full_child = Person.find(child_id)
  if full_child.parent_id
    puts "This child has already been assigned parents.\n\n"
  elsif parent.person1_id == child_id || parent.person2_id == child_id
    puts "You cannot enter a parent as their own child.\n\n"
  else
    full_child.update({:parent_id => parent_id})
    puts "#{full_child.name} is the child of #{full_child.parent_id}\n\n"
  end
end

def see_parents(child)
  id = child.parent_id
  parents = Parent.find(id)
  spouse1 = Person.find(parents.person1_id)
  spouse2 = Person.find(parents.person2_id)
  puts "#{child.name} is the child of:"
  puts "#{spouse1.name} and #{spouse2.name}\n\n"
end

system "clear"
menu









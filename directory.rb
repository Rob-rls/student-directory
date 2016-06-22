#let's put all students into an array
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  students = []
  name = gets.chomp
  while !name.empty? do
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------------"
end

def print(students)
  counter = students.size
  print_list = []
  while counter > 0
    print_list << "#{counter}. #{students[counter-1][:name]} (#{students[counter-1][:cohort]} cohort)"
    counter -= 1
  end
  puts print_list.reverse
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

student_list = input_students
print_header
print(student_list)
print_footer(student_list)

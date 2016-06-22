#let's put all students into an array
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  students = []
  name = gets.chomp
  while !name.empty? do
    students << {name: name, cohort: :november, nationality: "", age: ""}
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
  counter = 0
  while counter < students.size
    puts "#{counter + 1}. #{students[counter][:name]} (#{students[counter][:cohort]} cohort) nationality: #{students[counter][:nationality]}"
    counter += 1
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

student_list = input_students
print_header
print(student_list)
print_footer(student_list)

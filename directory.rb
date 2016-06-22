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

def print_header(linewidth)
  puts "The students of Villains Academy"
  puts "#".ljust(4) + "Name".ljust(linewidth) + "Cohort".ljust(linewidth/2)
  puts "-"*4 + "-"*(linewidth) + "-"*(linewidth/2)
end

def print(students, linewidth)
  students.each_with_index do |student, i|
      puts "#{i+1}.".ljust(4) + "#{student[:name]}".ljust(linewidth) + "(#{student[:cohort]} cohort)".ljust(linewidth/2)
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

linewidth = 36
student_list = input_students
print_header(linewidth)
print(student_list, linewidth)
print_footer(student_list)

#let's put all students into an array
def pluraler(n, singular, plural=nil)
  if n == 1
    "#{singular}"
  elsif plural
    "#{plural}"
  else
    "#{singular}s"
  end
end
    
def input_students
  cohort_month = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]
  puts "Please enter the names of the students"
  puts "To finish, hit enter twice"
  students = []
  name = gets.chomp
  while !name.empty? do
    puts "Enter the cohort month"
    cohort = gets.chomp.downcase
    cohort = "november" if cohort == ""
    while !cohort_month.include?(cohort.to_sym)
      puts "Enter a valid cohort"
      cohort = gets.chomp.downcase
      cohort = "november" if cohort == ""
    end
    students << {name: name, cohort: cohort.to_sym, nationality: "", age: ""}
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
  cohort_group = []
  cohort_group = students.map.sort do |student1, student2|
    student1[:cohort] <=> student2[:cohort] 
  end
  cohort_group.each_with_index do |student, i|
      puts "#{i+1}.".ljust(4) + "#{student[:name]}".ljust(linewidth) + "(#{student[:cohort]} cohort)".ljust(linewidth/2)
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great #{pluraler(names.count, "student")}"
end

linewidth = 36
student_list = input_students
print_header(linewidth)
print(student_list, linewidth)
print_footer(student_list)

@student_list = []

def interactive_menu
#  student_list = []
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "Pleae select a valid option"
  end
end

def load_students (filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    @student_list << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@student_list.count} from #{filename}"
  else
    puts "Sorry #{filename} doesn't exist."
    exit
  end
end

def save_students
  file = File.open("students.csv", "w")
  @student_list.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
  puts "...file saved"
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  linewidth = 36
  print_header(linewidth)
  if @student_list.size > 0
    print(linewidth)
    print_footer
  else
    puts "No Students entered"
  end
end

def pluraler(n, singular, plural=nil) #make a sting plural if required
  if n == 1
    "#{singular}"
  elsif plural
    "#{plural}"
  else
    "#{singular}s"
  end
end

def input_students
  cohort_month = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]
  puts "Please enter the names of the students"
  puts "To finish, hit enter twice"
  #students = []
  name = STDIN.gets.chomp
  while !name.empty? do
    puts "Enter the cohort month"
    cohort = STDIN.gets.chomp.downcase.capitalize
    cohort = "november" if cohort == ""
    while !cohort_month.include?(cohort.to_sym)
      puts "Enter a valid cohort"
      cohort = STDIN.gets.chomp.downcase.capitalize
      cohort = "november" if cohort == ""
    end
    @student_list << {name: name, cohort: cohort.to_sym, nationality: "", age: ""}
    puts "Now we have #{@student_list.count} #{pluraler(@student_list.count, "student")}"
    name = STDIN.gets.chomp
  end
#  students
end

def print_header(linewidth)
  puts "The students of Villains Academy"
  puts "#".ljust(4) + "Name".ljust(linewidth) + "Cohort".ljust(linewidth/2)
  puts "-"*4 + "-"*(linewidth) + "-"*(linewidth/2)
end

def print(linewidth)
  cohort_group = []
  cohort_group = @student_list.map.sort do |student1, student2|
    student1[:cohort] <=> student2[:cohort]
  end
  cohort_group.each_with_index do |student, i|
      puts "#{i+1}.".ljust(4) + "#{student[:name]}".ljust(linewidth) + "(#{student[:cohort]} cohort)".ljust(linewidth/2)
  end
end

def print_footer
  puts "Overall, we have #{@student_list.count} great #{pluraler(@student_list.count, "student")}"
end

try_load_students
interactive_menu

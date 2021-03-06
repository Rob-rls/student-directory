require 'csv'
@student_list = []
@filename = ""

def interactive_menu
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
    file_exist(load_input)
  when "5"
    check_my_code
  when "9"
    exit
  else
    puts "Pleae select a valid option"
  end
end

def check_my_code
  contents = File.open($0, "r") {|file| file.read}
  puts contents
end

def load_input
  puts "Enter the filename you want to load.\nHit enter to use the default file 'students.csv'"
  filename = STDIN.gets.chomp
end

def load_students (filename)
  @student_list.clear
  CSV.foreach(filename) do |line|
      name = line[0]
      cohort = line[1]
      add_to_list(name, cohort)
  end
  puts "#{filename} loaded..."
  @filename = filename
end

def try_load_students
  filename = ARGV.first
  file_exist(filename)
end

def file_exist (filename)
  filename = "students.csv" if filename.nil? || filename == ""
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@student_list.count} from #{filename}"
  else
    puts "Sorry #{filename} doesn't exist."
    exit
  end
end

def save_students
  puts "Enter name of file to save, or hit enter to save to loaded file #{@filename}"
  filename = STDIN.gets.chomp
  filename = @filename if filename == ""
  CSV.open(filename, "w") do |file|
    @student_list.each do |student|
      file << student.values
    end
  end
  @filename = filename
  puts "...file saved to #{@filename}"
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "5. Check my code"
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

def add_to_list (name, cohort)
  @student_list << {name: name, cohort: cohort.to_sym}
end

def input_students
  cohort_month = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]
  puts "Please enter the names of the students"
  puts "To finish, hit enter twice"
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
    add_to_list(name, cohort)
    puts "Now we have #{@student_list.count} #{pluraler(@student_list.count, "student")}\nEnter a new student or hit enter to return to menu."
    name = STDIN.gets.chomp
  end
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

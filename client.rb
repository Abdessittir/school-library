class Client
  attr_reader :option

  def initialize()
    options = [
      'List all books',
      'List all people',
      'Create a person',
      'Create a book',
      'Create a rental',
      'List all rentals for a given person id',
      'Exit'
    ]
    puts 'Please shoose an option by entring a number:'

    options.each_with_index do |option, i|
      puts "#{i + 1} - #{option}"
    end

    @option = gets.chomp
  end

  def validate_input(message, validation = lambda do |input| input != '' end)
    while true
      print message
      input = gets.chomp
      if validation.call(input)
        return input
      end
    end
  end

  def get_person_info()
    message = 'Do you wants to create a student (1) or a teacher (2)? [input the number]: '
    number = validate_input(message, lambda do |input| input == '1' || input == '2' end)
    
    message = 'Age: '
    age = validate_input(message, lambda do |input| input.to_i.is_a? Integer end)

    message = 'Name: '
    name = validate_input(message)

    person_info = {
      age: age,
      name: name,
    }
    if number == '1'
      message = 'Has parent permission? [Y/N]: '
      parent_permission = validate_input(
        message,
        lambda do |input| input.upcase == 'Y' || input.upcase == 'N' end
      )
      person_info[:type] = 'student'
      person_info[:parent_permission] = parent_permission.upcase == 'Y'
    else
      message = 'specialization: '
      specialization = validate_input(message)
      person_info[:type] = 'teacher'
      person_info[:specialization] = 'specialization'
    end

    person_info
  end

  def get_book_info()
    title = validate_input('Title: ')
    author = validate_input('Author: ')
    book_info = {
      title: title,
      author: author
    }

    book_info
  end

  def get_rental_info(books, people)
    message = "Select a book from the following list by number:\n"
    books.each do |book|
      message += book.to_s
      message += "\n"
    end
    index = validate_input(
      message,
      lambda do |input| input.to_i >= 0 && input.to_i < books.length end
    )
    book = books[index.to_i]

    message = "Select a book from the following list by number (not id):\n"
    people.each do |person|
      message += person.to_s
      message += "\n"
    end
    index = validate_input(
      message,
      lambda do |input| input.to_i >= 0 && input.to_i < people.length end
    )
    person = people[index.to_i]
    
    # I should add date validation here
    date = validate_input('Date: ')

    rental_info = {
      person: person,
      book: book,
      date: date
    }
    rental_info
  end

  def get_person_id()
    message = 'ID of person: '
    id = validate_input(message, lambda do |input| input.to_i.is_a? Integer end)
    id
  end
end

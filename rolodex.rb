class Rolodex
	attr_reader :contacts

	def initialize
		@contacts = []
		@id = 1000
		
	end
	
	def add_contact(contact)
		contact.id = @id
		@contacts << contact
		@id += 1
	end


	def modify_a_contact(contact)

		puts "\nChoose an attribute to modify: \n[1] First Name \n[2] Last Name \n[3] Email \n[4] Note"
		answer = gets.chomp.to_i

		case answer
		when 1 
			puts "Enter a modified First Name"
			firstname = gets.chomp.capitalize
			contact.first_name = firstname
		when 2
			puts "Enter a modified Last Name"
			lastname = gets.chomp.capitalize
			contact.last_name = lastname
		when 3 
			puts "Enter a modified Email Address"
			emailaddress = gets.chomp
			contact.email = emailaddress
		when 4 
			puts "Enter a modified note"
			newnote = gets.chomp
			contact.note = newnote
		end
		
	end

	def find(contact_id)
    @contacts.find {|contact| contact.id == contact_id }
  end

  def remove_contact(contact)
    @contacts.delete(contact)
  end
end
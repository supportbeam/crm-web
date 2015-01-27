class Contact
  attr_accessor :id, :first_name, :last_name, :email, :note
  #sets up a getter and a setter

  def initialize(first_name, last_name, email, note)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note
  end

  def to_s
   "Name: #{@first_name} #{@last_name} \nEmail: #{@email} \nNote: #{@note} \nID: #{@id}"
  end
  
end
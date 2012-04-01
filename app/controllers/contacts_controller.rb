class ContactsController < ApplicationController
  def create
    nums = params[:nums] 
    for number in nums do
      @contact = Location.new(:number =>  number)  
      @contact.save
    end
    puts "hello"
  end
end

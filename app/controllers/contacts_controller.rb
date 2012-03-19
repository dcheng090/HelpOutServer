class ContactsController < ApplicationController
  def create
    numbers = params[:numbers].split(',') 
    for number in numbers do
      @contact = Location.new(:number =>  number)  
      @contact.save
    end
  end
end

class ContactsController < ApplicationController
  def create
    nums = params[:nums] 
    for number in nums do
      @location = Location.new(:number =>  number)  
      if @location
        @location.save
      end
      @user = User.new(:number => number, :username => number, :password => number, :password_confirmation => number, :name => number)
      if @user 
        @user.save
      end
    end
    render :text =>  "hello"
  end
end

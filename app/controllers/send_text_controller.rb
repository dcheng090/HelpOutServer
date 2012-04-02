require 'net/http'
require 'uri'

class SendTextController < ApplicationController
  def index
      @restt = get_location
      #respond_to do |format|
      #  format.html # index.html.erb
      #  format.xml  { render :xml => @locations }
      #end
  end
  
  def get_location
    @location=Location.find("5")
    @lat=@location.lat
    @lon=@location.lon
    response=Net::HTTP.get_response("maps.googleapis.com","/maps/api/geocode/json?latlng=37.8679425,-122.2549152&sensor=false")
    @restt=ActiveSupport::JSON.decode(response.body)['results'][0]["formatted_address"]
    return @restt
  end 
   
  def mass_send_text_message_for
    if params[:whom]="5107097228"
       
    end
  end
   
  def get_closest_numbers
  
  end 

  def send_message_to(whom)
    location=Location.find_by_number("5107097228")
    number_to_send_to = whom
    twilio_sid = "AC9c5e8f23415c4b8e8f28ced554c29e9d"
    twilio_token = "73b5199b0a176444dc7f26bdafa4d559"
    twilio_phone_number = "4155992671"

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => "Hi #{number_to_send_to}, your friend is at http://maps.google.com?q=#{location.lat},#{location.lon} !"
    )
  end

  def send_text_message
    send_message_to(params[:number_to_send_to])
  end
  
  def send_text_message_old
    location=Location.find("5")
    number_to_send_to = params[:number_to_send_to]

    twilio_sid = "AC9c5e8f23415c4b8e8f28ced554c29e9d"
    twilio_token = "73b5199b0a176444dc7f26bdafa4d559"
    twilio_phone_number = "4155992671"

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => "Hi #{number_to_send_to}, your friend is at http://maps.google.com?q=#{location.lat},#{location.lon} !"
    )
  end
end

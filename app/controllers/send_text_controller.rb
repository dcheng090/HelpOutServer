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
    distressed = User.first
    @location=Location.find_by_number(distressed.number)
    @lat=@location.lat
    @lon=@location.lon
    response=Net::HTTP.get_response("maps.googleapis.com","/maps/api/geocode/json?latlng=37.8679425,-122.2549152&sensor=false")
    @restt=ActiveSupport::JSON.decode(response.body)['results'][0]["formatted_address"]
    return @restt
  end 
   
  def mass_send_text_message
    closeNumbers = get_closest_numbers(User.first.number)
    for num in closeNumbers
      send_message_to(num)
    end
  end
   
  def get_closest_numbers(distressedNum)
    locations = Location.where("dist IS NOT NULL AND number != ?",distressedNum).order("dist ASC").limit(2)
    locations.each do |location|
      send_message_to(location.number)
    end
  end 

  def get_audio_file
    distressed=User.first
    audio = Audio.find_by_username(distressed.username)
    if audio
      return audio.data
    end
  end

  def send_message_to(whom)
    distressed=User.first
    location=Location.find_by_number(distressed.number)
    number_to_send_to = whom
    audio_file = get_audio_file
    twilio_sid = "AC9c5e8f23415c4b8e8f28ced554c29e9d"
    twilio_token = "73b5199b0a176444dc7f26bdafa4d559"
    twilio_phone_number = "4155992671"

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => "Hi #{number_to_send_to}, your friend #{distressed.name} is at http://maps.google.com?q=#{location.lat},#{location.lon} #{audio_file} !"
      :body => "Hi #{number_to_send_to}, your friend #{distressed.name} is at http://maps.google.com?q=#{location.lat},#{location.lon} !"
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

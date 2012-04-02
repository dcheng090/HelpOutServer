class LocationsController < ApplicationController
  # GET /locations
  # GET /locations.xml
  def index
    @locations = Location.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.xml
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.xml
  def new
    @location = Location.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  def setDistance(loc)
    if loc.number==User.first.number
      locations=Location.all
    else
      locations=[loc]
    end
    
    locations.each do |location| 
      if location.lon and location.lat
        mainlocation = Location.find_by_number("5107097228")
        location.dist= Math.sqrt((location.lon-mainlocation.lon).abs**2 + (location.lat-mainlocation.lat).abs**2)
        location.save
      end
    end
  end
  
  # POST /locations
  # POST /locations.xml
  def create
    @location = Location.new(params[:location])
   
    respond_to do |format|
      if @location.save
        setDistance(@location)
        format.html { redirect_to(@location, :notice => 'Location was successfully created.') }
        format.xml  { render :xml => @location, :status => :created, :location => @location }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end
   
  # endpoint to update from phone
  # post paramaters include :username, :lon, :lat
  def updateFromPhone
    user = User.find_by_username(params[:username])
    if user  
      @location = Location.find_by_number(user.number)
    end
    if @location
      @location.lon=params[:lon]
      @location.lat=params[:lat]
      @location.save
      setDistance(@location)
      render :text => "OK"
    end
  end 

  # PUT /locations/1
  # PUT /locations/1.xml
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        setDistance(@location)
        format.html { redirect_to(@location, :notice => 'Location was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.xml
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to(locations_url) }
      format.xml  { head :ok }
    end
  end
end

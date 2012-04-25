class AudiosController < ApplicationController 
  
  # GET /audios
  # GET /audios.xml
  def index
    @audios = Audio.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @audios }
    end
  end

  # GET /audios/1
  # GET /audios/1.xml
  def show
    @audio = Audio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @audio }
    end
  end

  # GET /audios/new
  # GET /audios/new.xml
  def new
    @audio = Audio.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @audio }
    end
  end

  # GET /audios/1/edit
  def edit
    @audio = Audio.find(params[:id])
  end
  
  #POST /audios/create_from_phone
  def create_from_phone
    @audio = Audio.new({:data => params[:data], :username => params[:username]})
    if @audio.save
      upload(@audio.data)
    end
  end
  
  def upload
    uploaded_io = params[:data]
    @audio=Audio.new({:data => params[:data].original_filename,:username => params[:username]})
    @audio.save
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'w') do |file|
      file.write(uploaded_io.read.to_s.force_encoding("UTF-8"))
    end
  end
  
  # POST /audios
  # POST /audios.xml
  def create
    @audio = Audio.new(params[:audio])

    respond_to do |format|
      if @audio.save
        #upload(params[:audio][:data])
        format.html { redirect_to(@audio, :notice => 'Audio was successfully created.') }
        format.xml  { render :xml => @audio, :status => :created, :location => @audio }
      else
        format.html { render :action => "" }
        format.html { redirect_to(@audio, :notice => 'Audio was successfully created.') }
        format.xml  { render :xml => @audio, :status => :created, :location => @audio }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @audio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /audios/1
  # PUT /audios/1.xml
  def update
    @audio = Audio.find(params[:id])

    respond_to do |format|
      if @audio.update_attributes(params[:audio])
        format.html { redirect_to(@audio, :notice => 'Audio was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @audio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /audios/1
  # DELETE /audios/1.xml
  def destroy
    @audio = Audio.find(params[:id])
    @audio.destroy

    respond_to do |format|
      format.html { redirect_to(audios_url) }
      format.xml  { head :ok }
    end
  end
end

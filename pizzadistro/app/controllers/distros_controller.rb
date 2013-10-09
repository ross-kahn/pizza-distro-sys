class DistrosController < ApplicationController
  # GET /distros
  # GET /distros.json
  def index
    @distros = Distro.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @distros }
    end
  end

  # GET /distros/1
  # GET /distros/1.json
  def show
    @distro = Distro.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @distro }
    end
  end

  # GET /distros/new
  # GET /distros/new.json
  def new
    @distro = Distro.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @distro }
    end
  end

  # GET /distros/1/edit
  def edit
    @distro = Distro.find(params[:id])
  end

  # POST /distros
  # POST /distros.json
  def create
	@loc = Location.new(:x => params[:xval], :y =>params[:yval])
    @distro = Distro.new()

	if @loc.save
		@distro.location = @loc
		
		respond_to do |format|
		  if @distro.save
			@loc.distro = @distro
			format.html { redirect_to distros_path, notice: 'Distro was successfully created.' }
			format.json { render json: @distro, status: :created, location: @distro }
		  else
			@loc.destroy
			format.html { render action: "new" }
			format.json { render json: @distro.errors, status: :unprocessable_entity }
		  end
		end
	else
		respond_to do |format|
			estring = "Error: "
			@loc.errors.full_messages.each do |err|
				estring += err
			end
			flash[:alert] = estring
			format.html { render action: "new"}
		end
	end
	
    
  end

  # PUT /distros/1
  # PUT /distros/1.json
  def update
    @distro = Distro.find(params[:id])

    respond_to do |format|
      if @distro.update_attributes(params[:distro])
        format.html { redirect_to @distro, notice: 'Distro was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @distro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /distros/1
  # DELETE /distros/1.json
  def destroy
    @distro = Distro.find(params[:id])
    @distro.destroy

    respond_to do |format|
      format.html { redirect_to distros_url }
      format.json { head :no_content }
    end
  end
end

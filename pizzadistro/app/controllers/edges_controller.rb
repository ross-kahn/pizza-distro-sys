class EdgesController < ApplicationController

  before_filter :get_locations, :only => [:new, :create]
  before_filter :get_types, :only => [:new, :create]

  def get_locations
	@locations = Location.all
  end
  
  def get_types
	@types = Type.all
  end

  # GET /edges
  # GET /edges.json
  def index
    @edges = Edge.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @edges }
    end
  end

  # GET /edges/1
  # GET /edges/1.json
  def show
    @edge = Edge.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @edge }
    end
  end

  # GET /edges/new
  # GET /edges/new.json
  def new
    @edge = Edge.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @edge }
    end
  end

  # GET /edges/1/edit
  def edit
    @edge = Edge.find(params[:id])
  end

  # POST /edges
  # POST /edges.json
  def create
    @edge = Edge.new()
	@edge.location1 = Location.find(params[:edge][:location1_id])
	@edge.location2 = Location.find(params[:edge][:location2_id])
	@edge.type = Type.find(params[:edge][:type_id])
	@edge.uid = @edge.find_uid

    respond_to do |format|
      if @edge.save
        format.html { redirect_to edges_path, notice: 'Edge was successfully created.' }
        format.json { render json: @edge, status: :created, location: @edge }
      else
        format.html { render action: "new" }
        format.json { render json: @edge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /edges/1
  # PUT /edges/1.json
  def update
    @edge = Edge.find(params[:id])
	
    respond_to do |format|
      if @edge.update_attributes(params[:edge])
        format.html { redirect_to @edge, notice: 'Edge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @edge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /edges/1
  # DELETE /edges/1.json
  def destroy
    @edge = Edge.find(params[:id])
    @edge.destroy

    respond_to do |format|
      format.html { redirect_to edges_url }
      format.json { head :no_content }
    end
  end
end

class DijkstraController < ApplicationController

  # GET /dijkstra
  # GET /dijkstra.json
  def index
  
	if (params[:loc1] && params[:loc2] && params[:amount])
		loc1 = Distro.find(params[:loc1].to_i).location
		loc2 = Store.find(params[:loc2].to_i).location
		amount = params[:amount].to_i
		
		if !loc1 || !loc2 || !amount
			flash[:alert] = "Improper input!"
			return
		else
			comp = Computer.new
			loc_list = comp.shortest_path(loc1, loc2, amount)
			loc_list << loc1
			
			path = []
			loc_list.each do |location|
				path << location.inverse_s
			end
			path.reverse!
						
			cost = comp.cost_for_path(loc_list.reverse, amount)
			flash[:alert] = "Shortest Path: [" + path.join(",") + "]"
			flash[:notice] = "Path Cost: $" + cost.to_s
			redirect_to map_path
			return
		end
		
	end
  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dijkstra }
    end
  end

end

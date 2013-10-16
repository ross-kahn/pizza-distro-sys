# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

drawGrid = (cellsize) ->
  bw = 400
  bh = 400
  max = (bw / cellsize) - 1
  
  p = (cellsize/4)
  cw = bw + (p * 2) + 1
  ch = bh + (p * 2) + 1
  
  canvas = $("<canvas/>").attr(
    width: cw
    height: ch
  ).appendTo("body")
  
  context = canvas.get(0).getContext("2d")

  context.font = "bold 12px sans-serif"  
  x = 0
  while x <= bw
    context.fillText (x/cellsize + 1), x+(cellsize/2), 10 if ((x/cellsize)+ 1)%5 == 0
    context.moveTo 0.5 + x + p, p
    context.lineTo 0.5 + x + p, bh + p
    x += cellsize
  x = 0

  while x <= bh
    context.fillText (x/cellsize + 1), 0, x+(cellsize) if ((x/cellsize)+ 1)%5 == 0
    context.moveTo p, 0.5 + x + p
    context.lineTo bw + p, 0.5 + x + p
    x += cellsize
  context.strokeStyle = "black"
  context.stroke()
	
  context
  
drawNodes = (context, stores, distros, cellsize) ->
  p = cellsize/4
  i=0
  
  while i< stores.length
    s = stores[i]
    drawLocation(context, s.x-1, s.y-1, cellsize, p, false, stores[i+1])
    i=i+2  

  i=0
  while i< distros.length
    d = distros[i]
    drawLocation(context, d.x-1, d.y-1, cellsize, p, true, distros[i+1])
    i=i+2


drawLocation = (context, x, y, cellsize, p, isDistro, name) ->

  truex = (cellsize/2) + (x * cellsize) + p + .5
  truey = (cellsize/2) + (y * cellsize) + p + .5
  
  context.fillStyle = "#000099"
  context.fillStyle = "#CC0000" if isDistro
  
  context.beginPath()
  context.arc truex, truey, p*2, 0, Math.PI * 2, true
  context.fill()
  
  context.fillStyle = "#FFFFFF"
  context.fillText name, truex - (cellsize/2), truey + p
  context.closePath() 
  
drawEdges = (context, startNodes, endNodes, cellsize) ->
  i = 0
  while i < startNodes.length
    drawEdge(context, startNodes[i], endNodes[i], cellsize)
    i = i+1
  
drawEdge = (context, startLoc, endLoc, cellsize) ->
  p = cellsize / 4
  context.beginPath()
  
  context.moveTo (startLoc.x * cellsize)-p, (startLoc.y * cellsize)-p
  context.lineTo (endLoc.x * cellsize)-p, (endLoc.y * cellsize)-p
  context.strokeStyle = "green"
  context.lineWidth=5
  context.stroke()
  context.closePath()
  
$ ->
  stores = gon.stores if gon
  distros = gon.distros if gon
  startNodes = gon.startNodes
  endNodes = gon.endNodes
  cellsize = 20
  
  context = drawGrid(cellsize)
  drawEdges(context, startNodes, endNodes, cellsize)
  drawNodes(context, stores, distros, cellsize)

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
  context.strokeStyle = "#E2E2DC"
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
  
  context.fillStyle = "#008F00"
  context.fillStyle = "#000000" if isDistro
  
  context.beginPath()
  context.arc truex, truey, p*2, 0, Math.PI * 2, true
  context.fill()
  
  context.fillStyle = "#FFFFFF"
  context.fillText name, truex - (cellsize/2), truey + p
  context.closePath() 
  
drawEdges = (context, edges, cellsize) ->
  i = 0
  a = Object.keys(edges)
  
  while i < a.length
    epackage = edges[a[i]]
    drawEdge(context, epackage.start, epackage.end, epackage.colors, cellsize)
    i = i+1
  
drawEdge = (context, startLoc, endLoc, colors, cellsize) ->
  p = cellsize / 4
  context.beginPath()
  
  context.moveTo (startLoc.x * cellsize)-p, (startLoc.y * cellsize)-p
  context.lineTo (endLoc.x * cellsize)-p, (endLoc.y * cellsize)-p

  gradient = context.createLinearGradient(200,0,225,0)
  
  i=0
  while i < colors.length
    if colors.length > 2
      gradient.addColorStop(i/2, colors[i])
    else
      gradient.addColorStop(i, colors[i])
    i++
  
  context.strokeStyle = gradient
  context.lineWidth=5
  context.stroke()
  context.closePath()
  
$ ->
  stores = gon.stores if gon
  distros = gon.distros if gon
  edges = gon.edges if gon
  cellsize = gon.mapSize if gon
  
  context = drawGrid(cellsize)
  drawEdges(context, edges, cellsize)
  drawNodes(context, stores, distros, cellsize)

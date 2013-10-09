# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

drawGrid = () ->
  cellsize = 20
  bw = 400
  bh = 400
  sx = 10
  sy = 10
  max = (bw / cellsize) - 1
  
  p = (cellsize/4)
  cw = bw + (p * 2) + 1
  ch = bh + (p * 2) + 1
  
  canvas = $("<canvas/>").attr(
    width: cw
    height: ch
  ).appendTo("body")
  
  context = canvas.get(0).getContext("2d")
  
  x = 0

  while x <= bw
    context.moveTo 0.5 + x + p, p
    context.lineTo 0.5 + x + p, bh + p
    x += cellsize
  x = 0

  while x <= bh
    context.moveTo p, 0.5 + x + p
    context.lineTo bw + p, 0.5 + x + p
    x += cellsize
  context.strokeStyle = "black"
  context.stroke()
  
  drawStore(context, sx, sy, cellsize, p)
  


drawStore = (context, x, y, cellsize, p) ->

  truex = (cellsize/2) + (x * cellsize) + p + .5
  truey = (cellsize/2) + (y * cellsize) + p + .5
  
  context.fillStyle = "#FF1C0A"
  context.beginPath()
  context.arc truex, truey, p*2, 0, Math.PI * 2, true
  context.closePath()
  context.fill()


  
$ ->
  drawGrid()
module(..., package.seeall)
require 'musica'

local _W = display.contentWidth
local _H = display.contentHeight
local muteSound = true  

function inicio(isMute)

   if (isMute == false) then
      muteSound = false
   else
      muteSound = true
   end
   
   musica.inicio("musicaTienda", muteSound)
   
   TiendaGroup = display.newGroup()

   fondoTienda = display.newImage( "image/tienda_bg.png" )
   
   volver_btn = display.newImage("image/volver_btn.png")
   volver_btn.x = _W/2; volver_btn.y = 280
   volver_btn.name = "volver_btn"
   
   marco = display.newImage("image/marco.png")
   marco.x = 210; marco.y = 90
   marco.name = "marco"   
   
   marco2 = display.newImage("image/marco2.png")
   marco2.x = marco.x + 230; marco2.y = marco.y
   marco2.name = "marco2"
   
   chupetaInvu = display.newImage("image/objetos/LolRed.png")
   chupetaInvu.x = marco2.x; chupetaInvu.y = marco2.y
   chupetaInvu.name = "chupetaInvu"
   
   local contCan
   local path2 = system.pathForFile("archivos/caramelos.txt")
   local file2 = io.open(path2, "r")
   if file2 then
      contCan = file2:read( "*a" )
      io.close( file2 )
   end
   local contador1 = contCan
   contCan = tonumber(contCan)
 
   local costChup = 0
   local pathInv = system.pathForFile("archivos/costoInvulnerabilidad.txt")
   local fileInv = io.open(pathInv, "r")
   if fileInv then
      costChup = fileInv:read( "*a" )
      io.close( fileInv )
   end
   local contador2 = costChup
   costChup = tonumber(costChup)
   
   function llamarCompra()
      compraInvulnerabilidad(costChup, contCan)
   end
   
   cantidadCaramelos = display.newText("", 0, 0, native.systemFont, 20)
   cantidadCaramelos:setTextColor(34, 177, 76)
   cantidadCaramelos.x = _W/2
   cantidadCaramelos.y = 40
   cantidadCaramelos.text = "Caramelos: " .. contador1
   
   chupetaInv = display.newText("", 0, 0, native.systemFont, 17)
   chupetaInv:setTextColor(34, 177, 76)
   chupetaInv.x = marco.x + 5
   chupetaInv.y = marco.y
   chupetaInv.text = "Chupeta de Invulnerabilidad: " .. contador2 .. " Caramelos."
   
   TiendaGroup:insert(fondoTienda)
   TiendaGroup:insert(volver_btn)
   TiendaGroup:insert(marco)
   TiendaGroup:insert(marco2)
   TiendaGroup:insert(chupetaInvu)
   volver_btn:addEventListener("tap", loadMenu)
   marco2:addEventListener("tap", llamarCompra)

end
------------------------------------------------------------------------
function loadMenu(event)
   if event.target.name == "volver_btn" then
      volver_btn:removeEventListener("tap", loadMenu)
      fondoTienda:removeSelf()
      volver_btn:removeSelf()
      marco:removeSelf()
	  marco2:removeSelf()
	  chupetaInvu:removeSelf()
	  cantidadCaramelos:removeSelf()
	  chupetaInv:removeSelf()
      media.pauseSound()
      transition.to(finJuego,{onComplete = menu.principal(muteSound)})
   end 
end

function compraInvulnerabilidad(costo, caramelos)
   if costo <= caramelos then
      caramelos = caramelos - costo
	  costo = costo * 2
	  
      local costChup = 0
      local pathInv = system.pathForFile("archivos/costoInvulnerabilidad.txt")
      local fileInv = io.open(pathInv, "r")
      if fileInv then
         costChup = fileInv:read( "*a" )
         io.close( fileInv )
      end
      costChup = tonumber(costChup)  
      costChup = costo
      fileInv = io.open(pathInv, "w")
      fileInv:write(costChup)
      io.close( fileInv )
	  
	  local contCan
      local path2 = system.pathForFile("archivos/caramelos.txt")
      local file2 = io.open(path2, "r")
      if file2 then
         contCan = file2:read( "*a" )
         io.close( file2 )
      end
      contCan = tonumber(contCan)
      contCan = caramelos
      file2 = io.open(path2, "w")
      file2:write(contCan)
      io.close( file2 )
	  
	  local tiempoInv
      local pathTime = system.pathForFile("archivos/tiempoInvulnerabilidad.txt")
      local fileTime = io.open(pathTime, "r")
      if fileTime then
         tiempoInv = fileTime:read( "*a" )
         io.close( fileTime )
      end
      tiempoInv = tonumber(tiempoInv)
      tiempoInv = tiempoInv + 5
      fileTime = io.open(pathTime, "w")
      fileTime:write(tiempoInv)
      io.close( fileTime )
	  
	  volver_btn:removeEventListener("tap", loadMenu)
      fondoTienda:removeSelf()
      volver_btn:removeSelf()
      marco:removeSelf()
	  marco2:removeSelf()
	  chupetaInvu:removeSelf()
	  cantidadCaramelos:removeSelf()
	  chupetaInv:removeSelf()
      media.pauseSound()
	  
      musica.inicio("compra", muteSound)
	  
	  transition.to(menuPrincipal,{onComplete = tienda.inicio(muteSound)})
	  
   end
end

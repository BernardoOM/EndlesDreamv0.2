module(..., package.seeall)
require 'game'
require 'creditos'
require 'musica'
require 'tienda'

local _W = display.contentWidth
local _H = display.contentHeight 
local muteSound = true   
local contmute = true   
local contRecord = 0
local record = ""

------------------------------------------------------------------------
local mutear = sprite.newSpriteSheet( "image/mute.png", 19, 20 )
local spriteMute = sprite.newSpriteMultiSet( 
{
        { sheet = mutear, frames = { 1 } },
		{ sheet = mutear, frames = { 2 } },
})
sprite.add(spriteMute,"prendido",1,1,300,0)
sprite.add(spriteMute,"apagado",2,1,300,0)
------------------------------------------------------------------------
function principal(isMute)

   if (isMute == false) then
      muteSound = false
   else
      muteSound = true
   end
   
   menuPrincipal = display.newGroup()
   
   bg = display.newImage("image/bg.png")
   
   play_btn = display.newImage("image/play_btn.png")
   play_btn.x = _W/2; play_btn.y = 230
   play_btn.name = "play_btn"
   
   credit_btn = display.newImage("image/credit_btn.png")
   credit_btn.x = _W/2 + play_btn.width + 10; credit_btn.y = play_btn.y 
   credit_btn.name = "credit_btn"
   
   tienda_btn = display.newImage("image/tienda_btn.png")
   tienda_btn.x = _W/2 - play_btn.width - 10; tienda_btn.y = play_btn.y 
   tienda_btn.name = "credit_btn"
   
   menuPrincipal:insert(bg)
   menuPrincipal:insert(play_btn)
   menuPrincipal:insert(credit_btn)
   menuPrincipal:insert(tienda_btn)
   play_btn:addEventListener("tap", loadGame)
   credit_btn:addEventListener("tap", loadCredits)
   tienda_btn:addEventListener("tap", loadTienda)

   local path = system.pathForFile("archivos/highscore.txt")
   local file = io.open(path, "r")
   if file then
      contRecord = file:read( "*a" )
      io.close( file )
   end
   
   record = display.newText("", 0, 0, native.systemFont, 23)
   record:setTextColor(34, 177, 76)
   record.x = _W/2
   record.y = 280
   record.text = ("Best Score: " .. contRecord)
   
------------------------------------------------------------------------
--Mute
mutear = sprite.newSprite( spriteMute )
mutear:prepare("prendido")
mutear.x = 460
mutear.y = 20
mutear:scale(1.5,1.5)

if (isMute == false) then
   muteSound = false
   mutear:prepare("apagado")
else
   muteSound = true
   mutear:prepare("prendido")
end
musica.inicio("musicaMenu", muteSound)
function mute()
   if contmute == true then
      mutear:prepare("apagado")
      contmute = false
      muteSound = false
      media.pauseSound()
   else
      mutear:prepare("prendido")
      contmute = true
      muteSound = true
      musica.inicio("musicaMenu", muteSound)
   end
end
mutear:addEventListener("tap", mute)
------------------------------------------------------------------------
end
------------------------------------------------------------------------
function Remove()
   play_btn:removeEventListener("tap", loadGame)
   credit_btn:removeEventListener("tap", loadCredits)
   mutear:removeEventListener("tap", mute)
   mutear:removeSelf()
   play_btn:removeSelf()
   credit_btn:removeSelf()
   tienda_btn:removeSelf()
   bg:removeSelf()
   record:removeSelf()
   media.pauseSound()
end

function loadGame(event)
   if event.target.name == "play_btn" then
      Remove()
      transition.to(menuPrincipal,{onComplete = game.inicio(muteSound)})
   end 
end

function loadCredits(event)
   if event.target.name == "credit_btn" then
      Remove()
      transition.to(menuPrincipal,{onComplete = creditos.inicio(muteSound)})
   end 
end

function loadTienda(event)
   if event.target.name == "credit_btn" then
      Remove()
      transition.to(menuPrincipal,{onComplete = tienda.inicio(muteSound)})
   end 
end

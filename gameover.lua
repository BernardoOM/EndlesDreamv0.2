module(..., package.seeall)

local _W = display.contentWidth
local _H = display.contentHeight
local contScore = 0
local muteSound = true
local actualScore = ""
local highestScore = ""

function inicio(isMute, Score, HS)
   
   if (isMute == false) then
      muteSound = false
   else
      muteSound = true
   end
   
   musica.inicio("die", muteSound)
   
   finJuego = display.newGroup()

   gameover = display.newImage( "image/gameover.png" )
   
   retry_btn = display.newImage("image/retry_btn.png")
   retry_btn.x = _W/2; retry_btn.y = _H/2
   retry_btn.name = "retry_btn"
   
   quit_btn = display.newImage("image/quit_btn.png")
   quit_btn.x = _W/2; quit_btn.y = _H/2 + retry_btn.height + 10
   quit_btn.name = "quit_btn"
   
   finJuego:insert(gameover)
   finJuego:insert(retry_btn)
   finJuego:insert(quit_btn)
   retry_btn:addEventListener("tap", loadGame)
   quit_btn:addEventListener("tap", loadMenu)

   actualScore = display.newText("", 0, 0, native.systemFont, 20)
   actualScore:setTextColor(216, 216, 216)
   actualScore.x = 100
   actualScore.y = 255
   actualScore.text = "Actual Score: " .. Score
   
   highestScore = display.newText("", 0, 0, native.systemFont, 20)
   highestScore:setTextColor(216, 216, 216)
   highestScore.x = 350
   highestScore.y = 255
   highestScore.text = "Highest Score: " .. HS
   
end

function loadGame(event)
   if event.target.name == "retry_btn" then
      retry_btn:removeEventListener("tap", loadGame)
      quit_btn:removeEventListener("tap", loadMenu)
      gameover:removeSelf()
      retry_btn:removeSelf()
      quit_btn:removeSelf()
      actualScore:removeSelf()
      highestScore:removeSelf()
      media.pauseSound()
      transition.to(finJuego,{onComplete = game.inicio(muteSound)})
   end 
end

function loadMenu(event)
   if event.target.name == "quit_btn" then
      retry_btn:removeEventListener("tap", loadGame)
      quit_btn:removeEventListener("tap", loadMenu)
      gameover:removeSelf()
      retry_btn:removeSelf()
      quit_btn:removeSelf()
      media.pauseSound()
      transition.to(finJuego,{onComplete = menu.principal(muteSound)})
   end 
end

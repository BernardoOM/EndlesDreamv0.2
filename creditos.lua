module(..., package.seeall)

local _W = display.contentWidth
local _H = display.contentHeight
local muteSound = true

function inicio(isMute)

   if (isMute == false) then
      muteSound = false
   else
      muteSound = true
   end
   
   CreditGroup = display.newGroup()

   fondoCreditos = display.newImage( "image/credits.png" )
   
   volver_btn = display.newImage("image/volver_btn.png")
   volver_btn.x = _W/2; volver_btn.y = 280
   volver_btn.name = "volver_btn"
   
   CreditGroup:insert(fondoCreditos)
   CreditGroup:insert(volver_btn)
   volver_btn:addEventListener("tap", loadMenu)
end
------------------------------------------------------------------------
function loadMenu(event)
   if event.target.name == "volver_btn" then
      volver_btn:removeEventListener("tap", loadMenu)
      fondoCreditos:removeSelf()
      volver_btn:removeSelf()
      media.pauseSound()
      transition.to(finJuego,{onComplete = menu.principal(muteSound)})
   end 
end

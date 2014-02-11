module(..., package.seeall)

system.activate("multitouch")
require "sprite"
require 'musica'
require 'gameover'

function inicio(isMute)
------------------------------------------------------------------------
local _W = display.contentWidth
local _H = display.contentHeight
local cambioEscenario = 0
local cont = 0
local cont2 = 0
local contDistancia = 0
local contVidas = 5 --Cantidad de vidas
local inGame = true
local invulnerabilidad = true
local LimDer = true
local LimIzq = true
local movimientox = 10
local multMovX = 1
local multMovY = 1
local pausado = true
local pospiso = 480
--local pso2 = false
local velocidadmov = 5
local vmovimientox = 0
local vmovimientoy = 0
local gameTimer = false 
------------------------------------------------------------------------
--variables para habilitar y deshabilitar los enemigos.
--true = salen, false = no salen.
local BossAct = true
local camillaAct = true
local enemigoAct = true
local carameloAct = true
local chupetaInvAct = true
local enemigoBombaAct = true 
------------------------------------------------------------------------
--Fondo.
local fondoHospital = display.newImage( "image/escenarios/fondoH.png" )
local fondoHospital2 = display.newImage( "image/escenarios/fondoH.png" )
local hospital = display.newImage( "image/escenarios/hospital.png" )
local hospital2 = display.newImage( "image/escenarios/hospital2.png" )
local street = display.newImage( "image/escenarios/Street.png" )
local street2 = display.newImage( "image/escenarios/Street.png" )
local cambioHC = display.newImage("image/escenarios/cambioHC.png")
local bosque = display.newImage( "image/escenarios/bosque.png" )
local bosque2 = display.newImage( "image/escenarios/bosque.png" )
local cambioCB = display.newImage("image/escenarios/cambioCB.png")
hospital2.x = display.contentWidth + 240
fondoHospital2.x = display.contentWidth + 240
street.x = 800
street2.x = 800
cambioHC.x = 800
bosque.x = 800
bosque2.x = 800
cambioCB.x = 800
------------------------------------------------------------------------
--Piso, sprites e instanciación.
local piso = display.newImage("image/escenarios/piso.png")
piso.x = display.contentWidth - 240 ; piso.y = display.contentHeight-27

local piso2 = display.newImage("image/escenarios/piso.png") 
piso2.x = display.contentWidth + 240; piso2.y = display.contentHeight-27 

local piso3 = display.newImage("image/escenarios/pisoStreet.png") 
piso3.x = 800; piso3.y = display.contentHeight-27

local piso4 = display.newImage("image/escenarios/pisoStreet.png") 
piso4.x = 800; piso4.y = display.contentHeight-27

local pisoB1 = display.newImage("image/escenarios/pisoBosque.png") 
pisoB1.x = 800; pisoB1.y = display.contentHeight-27

local pisoB2 = display.newImage("image/escenarios/pisoBosque.png") 
pisoB2.x = 800; pisoB2.y = display.contentHeight-27
------------------------------------------------------------------------
--Sprite mute.
local mutear = sprite.newSpriteSheet( "image/mute.png", 19, 20 )
local spriteMute = sprite.newSpriteMultiSet( 
{
        { sheet = mutear, frames = { 1 } },
		{ sheet = mutear, frames = { 2 } },
})
sprite.add(spriteMute,"prendido",1,1,300,0)
sprite.add(spriteMute,"apagado",2,1,300,0)
------------------------------------------------------------------------
--Sprite enemigo
local enemigo = sprite.newSpriteSheet("image/enemigos/Monster1.png",20,24)
local spriteEnemigo = sprite.newSpriteMultiSet( 
{
   {sheet = enemigo, frames = {1,2,3}},
})
sprite.add(spriteEnemigo,"enemigo",1,3,500,0)
------------------------------------------------------------------------
--Sprite enemigo bomba 
local enemigoBomba = sprite.newSpriteSheet("image/enemigos/enemigoBomba.png",106,28)
local spriteEnemigoBomba = sprite.newSpriteMultiSet( 
{
   {sheet = enemigoBomba, frames = {1,2}},
})
sprite.add(spriteEnemigoBomba,"enemigoBomba",1,2,300,0)
------------------------------------------------------------------------
--Sprite bomba amarilla  
local bombaAmarilla = sprite.newSpriteSheet("image/enemigos/bombaAmarilla.png",16,14)
local spriteBombaAmarilla = sprite.newSpriteMultiSet( 
{
   {sheet = bombaAmarilla, frames = {1,2}},
})
sprite.add(spriteBombaAmarilla,"bombaAmarilla",1,2,300,0)
------------------------------------------------------------------------
--Sprite bomba verde
local bombaVerde = sprite.newSpriteSheet("image/enemigos/bombaVerde.png",16,14)
local spriteBombaVerde = sprite.newSpriteMultiSet( 
{
   {sheet = bombaVerde, frames = {1,2}},
})
sprite.add(spriteBombaVerde,"bombaVerde",1,2,300,0)
------------------------------------------------------------------------
--Sprite bomba azul 
local bombaAzul = sprite.newSpriteSheet("image/enemigos/bombaAzul.png",16,14)
local spriteBombaAzul = sprite.newSpriteMultiSet( 
{
   {sheet = bombaAzul, frames = {1,2}},
})
sprite.add(spriteBombaAzul,"bombaAzul",1,2,300,0)
------------------------------------------------------------------------
--Sprite bomba Naranja 
local bombaNaranja = sprite.newSpriteSheet("image/enemigos/bombaNaranja.png",16,14)
local spriteBombaNaranja = sprite.newSpriteMultiSet( 
{
   {sheet = bombaNaranja, frames = {1,2}},
})
sprite.add(spriteBombaNaranja,"bombaNaranja",1,2,300,0)
------------------------------------------------------------------------
--Sprite manchas bombas 
local manchas = sprite.newSpriteSheet("image/enemigos/manchas.png",9,9)
local spriteBombaManchas = sprite.newSpriteMultiSet( 
{
   {sheet = manchas, frames = {1,2,3,4}},
})
sprite.add(spriteBombaManchas,"verde",1,1,300,0)
sprite.add(spriteBombaManchas,"naranja",2,1,300,0)
sprite.add(spriteBombaManchas,"azul",3,1,300,0)
sprite.add(spriteBombaManchas,"amarillo",4,1,300,0)
------------------------------------------------------------------------
--sprite caramelo
--[[local caramelo = sprite.newSpriteSheet( "image/Candy1.png", 16, 20)
local spriteCaramelo = sprite.newSpriteMultiSet( 
{
        { sheet = caramelo, frames = { 1,2,3,4 } },
})
sprite.add(spriteCaramelo,"caramelo",1,4,3000,0)]]
------------------------------------------------------------------------
--Sprite chico.
local derecha = sprite.newSpriteSheet( "image/chico/run1.png", 34, 56 )
local izquierda = sprite.newSpriteSheet( "image/chico/run2.png", 34, 56 )
local invulnerableDerecha = sprite.newSpriteSheet( "image/chico/invulnerable2.1.png", 34, 56 )
local invulnerableIzquierda = sprite.newSpriteSheet( "image/chico/invulnerable2.2.png", 34, 56 )
local spriteSet = sprite.newSpriteMultiSet( 
{
        { sheet = derecha, frames = { 1,2,3,4,5 } },
		{ sheet = izquierda, frames = { 5,4,3,2,1 } },
		{ sheet = invulnerableDerecha, frames = { 1,2,3,4,5 } },
		{ sheet = invulnerableIzquierda, frames = { 5,4,3,2,1 } },
})
sprite.add(spriteSet,"derecha",1,5,300,0)
sprite.add(spriteSet,"izquierda",6,5,300,0)
sprite.add(spriteSet,"invulnerableDerecha",11,5,300,0)
sprite.add(spriteSet,"invulnerableIzquierda",16,5,300,0)
------------------------------------------------------------------------
--Instanciación chico.
local chico = sprite.newSprite( spriteSet )
chico.myName = "chico"
chico.x = 50
chico.y = 238
chico:scale(0.75,0.75) 
------------------------------------------------------------------------
--invulnerabilidad
function invulnerable()
   if (invulnerabilidad == false) then
      chico:prepare("invulnerableDerecha")
      chico:play()
   else
      chico:prepare("derecha")
      chico:play()
   end
end
invulnerable()
------------------------------------------------------------------------
--vida
function vida(cantidad)
   arreglovidas = {}
   for i = 1, cantidad do
      arreglovidas[i] = display.newImage("image/objetos/vida.png")
      arreglovidas[i]:scale(1.25,1.25) 
      arreglovidas[i].x = 20
      arreglovidas[i].y = 20
      local diametro = arreglovidas[i].width + 5
      if i > 1 then
         arreglovidas[i].x = arreglovidas[i-1].x + diametro
         arreglovidas[i].y = arreglovidas[i-1].y
      end
   end
end
vida(contVidas)
------------------------------------------------------------------------
--Función aparecer corazones.
function corazones()
   if (inGame == true and contVidas < 5) then
      local extraLife = display.newImage("image/objetos/vida.png")
      extraLife.x = 480;  extraLife.y = math.random(75, 238)
      extraLife:scale(1.5,1.5)
      function translateLife()
         extraLife:translate(-movimientox, 0)
         if (extraLife.x < -24) then
            extraLife:removeSelf()
         end
      end
      timertranslateLife = timer.performWithDelay(1,translateLife,0)
      function colisionVida()
         if (chico.x + 25.5 > extraLife.x) and (chico.x < extraLife.x + 24) then
            if (chico.y + 42 > extraLife.y) and (chico.y < extraLife.y + 21) then
               extraLife:removeSelf()
               for i = 1, contVidas do
                  arreglovidas[i]:removeSelf()
               end
               contVidas = contVidas + 1
               vida(contVidas)
            end
         end
      end
      timercolisionVida = timer.performWithDelay(1,colisionVida,0)
   end
end
timerCorazones = timer.performWithDelay(60000,corazones,0) 
--Se sigue repitiendo aun así esté pausado, lo que puede generar que los corazones
--aparezcan mas rápido si se para.
------------------------------------------------------------------------
function cambioDeEscenarios(Escenario)
   if (Escenario == 1) then
	  while (cambioEscenario == 0) do
	     if (hospital.x > 240 and hospital2.x < 240) then
            cambioHC.x = hospital.x + 480
            street.x = cambioHC.x + 480
            street2.x = street.x + 480
            piso3.x = piso.x + 480
            piso4.x = piso3.x + 480
			cambioEscenario = 1
	     elseif (hospital2.x > 240 and hospital.x < 240) then
            cambioHC.x = hospital2.x + 480
            street.x = cambioHC.x + 480
            street2.x = street.x + 480
            piso3.x = piso2.x + 480
            piso4.x = piso3.x + 480
			cambioEscenario = 1
		 end
	  end
   end
   if (Escenario == 2) then
      while (cambioEscenario == 1) do
	     if (street.x > 240 and street2.x < 240) then
            cambioCB.x = street.x + 480
            bosque.x = cambioCB.x + 480
            bosque2.x = bosque.x + 480
            pisoB1.x = piso4.x + 480
            pisoB2.x = pisoB1.x + 480
			cambioEscenario = 2
	     elseif (street2.x > 240 and street.x < 240) then
            cambioCB.x = street2.x + 480
            bosque.x = cambioCB.x + 480
            bosque2.x = bosque.x + 480
            pisoB1.x = piso3.x + 480
            pisoB2.x = pisoB1.x + 480
			cambioEscenario = 2
		 end
	  end
   end
end
------------------------------------------------------------------------
--Función cargar pisos y fondo.
function cargarPisos()
   if (cambioEscenario == 0) then
	  if (fondoHospital.x + 480 < 240) then
	     fondoHospital.x = fondoHospital2.x + 480
	  end
	  if (fondoHospital2.x + 480 < 240) then
	     fondoHospital2.x = fondoHospital.x + 480
	  end
      if(hospital.x + 480 < 240)then
         hospital.x = hospital2.x + 480
      end
      if(piso.x + 480 < 240)then
	     piso.x = piso2.x + 480
      end
      if(hospital2.x + 480 < 240) then 
         hospital2.x = hospital.x + 480
      end
      if(piso2.x + 480 < 240)then
	     piso2.x = piso.x + 480
      end
   elseif (cambioEscenario == 1) then
	  if (fondoHospital.x + 480 < 240) then
	     fondoHospital.x = fondoHospital2.x + 480
	  end
	  if (fondoHospital2.x + 480 < 240) then
	     fondoHospital2.x = fondoHospital.x + 480
	  end
      if(street.x + 480 < 240)then
         street.x = street2.x + 480
      end
      if(piso3.x + 480 < 240)then
	     piso3.x = piso4.x + 480
      end
      if(street2.x + 480 < 240) then 
         street2.x = street.x + 480
      end
      if(piso4.x + 480 < 240)then
	     piso4.x = piso3.x + 480
      end
   elseif (cambioEscenario == 2) then
      if(bosque.x + 480 < 240)then
         bosque.x = bosque2.x + 480
      end
      if(pisoB1.x + 480 < 240)then
	     pisoB1.x = pisoB2.x + 480
      end
      if(bosque2.x + 480 < 240) then 
         bosque2.x = bosque.x + 480
      end
      if(pisoB2.x + 480 < 240)then
	     pisoB2.x = pisoB1.x + 480
      end
   end 
end
------------------------------------------------------------------------
--Función movimiento constante
function MovimientoConstante ()
   if (cambioEscenario == 0) then
      MovCambio1()
      fondoHospital:translate(-movimientox * 3, 0)
      fondoHospital2:translate(-movimientox * 3, 0)
   end
   if (cambioEscenario == 1) then
      MovCambio1()
	  MovCambio2()
      fondoHospital:translate(-movimientox * 3, 0)
      fondoHospital2:translate(-movimientox * 3, 0)
   end
   if (cambioEscenario == 2) then
      MovCambio1()
	  MovCambio2()
      fondoHospital:translate(-movimientox, 0)
      fondoHospital2:translate(-movimientox, 0)
	  MovCambio3()
   end
   cargarPisos()
end
timerMovimientoConstante = timer.performWithDelay(1,MovimientoConstante,0)
------------------------------------------------------------------------
--funciones de translate.
function MovCambio1()
   piso:translate(-movimientox, 0)
   piso2:translate(-movimientox, 0)
   hospital:translate(-movimientox, 0)
   hospital2:translate(-movimientox, 0)
end
function MovCambio2()
   cambioHC:translate(-movimientox,0)
   street:translate(-movimientox, 0)
   street2:translate(-movimientox, 0)
   piso3:translate(-movimientox, 0)
   piso4:translate(-movimientox, 0)
end
function MovCambio3()
   pisoB1:translate(-movimientox, 0)
   pisoB2:translate(-movimientox, 0)
   bosque:translate(-movimientox, 0)
   bosque2:translate(-movimientox, 0)
   cambioCB:translate(-movimientox,0)
end
------------------------------------------------------------------------
--Mute  
local muteSound = true   
local contmute = true

mutear = sprite.newSprite( spriteMute )
mutear:prepare("prendido")
mutear:scale(1.5,1.5)
mutear.x = 460
mutear.y = 20

if (isMute == false) then
   muteSound = false
   mutear:prepare("apagado")
else
   muteSound = true
   mutear:prepare("prendido")
end
musica.inicio("musicaJuego", muteSound)
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
      musica.inicio("musicaJuego", muteSound)
   end
end
mutear:addEventListener("tap", mute)
------------------------------------------------------------------------
local chupetaInvInGame = false
local tiempoInvulnerabilidad = 0
--Función chupetas
function Chupetas() --(Invulnerabilidad) 
   if chupetaInvAct == true and chupetaInvInGame == false and inGame == true then
      chupetaInvulnerabilidad = display.newImage("image/objetos/LolRed.png")
	  chupetaInvulnerabilidad.x = 480; chupetaInvulnerabilidad.y = math.random(90, 238)
	  chupetaInvInGame = true
	  function moverChupInv()
	     if chupetaInvInGame == true then
		    chupetaInvulnerabilidad:translate(-movimientox, 0)
		 end
		 if chupetaInvulnerabilidad.x < -28 then
            chupetaInvulnerabilidad:removeSelf()
			chupetaInvInGame = false
         end
	  end
	  timermoverChupInv = timer.performWithDelay(1, moverChupInv, 0)
      function ColisionChupetaInv()
	     if chupetaInvInGame == true then
	        if (chico.x + 25.5 > chupetaInvulnerabilidad.x) and (chico.x < chupetaInvulnerabilidad.x + 30) then
               if (chico.y + 42 > chupetaInvulnerabilidad.y) and (chico.y < chupetaInvulnerabilidad.y + 30) then
		          chupetaInvulnerabilidad:removeSelf()
			      chupetaInvInGame = false
				  invulnerabilidad = false
                  invulnerable()
				  local contInv = 0
                  local rutaInv = system.pathForFile("archivos/tiempoInvulnerabilidad.txt")
                  local fileInv = io.open(rutaInv, "r")
                  if fileInv then
                  contInv = fileInv:read( "*a" )
                     io.close( fileInv )
                  end
				  tiempoInvulnerabilidad = contInv
			   end
	        end
		 end
      end
	  timerColisionChupetaInv = timer.performWithDelay(1, ColisionChupetaInv, 0)
   end
end
timerChupetas = timer.performWithDelay(100000,Chupetas, 0)
--function randomChupetas()
   --Chupetas(true)
--end
local contadorInvulnerabilidad = display.newText("", 0, 0, native.systemFont, 12)
contadorInvulnerabilidad:setTextColor(514, 514, 514)
function quitarInvulnerabilidad()
   if inGame == true and invulnerabilidad == false then
      tiempoInvulnerabilidad = tiempoInvulnerabilidad - 1
	  if tiempoInvulnerabilidad < 0 then
         invulnerabilidad = true
         invulnerable()
		 tiempoInvulnerabilidad = 0
	     contadorInvulnerabilidad.x = 500
		 contadorInvulnerabilidad.y = 500
	  end
   end
end
timerquitarInvulnerabilidad = timer.performWithDelay(1000, quitarInvulnerabilidad, 0)
function contarInv()
   if inGame == true and invulnerabilidad == false then
      contadorInvulnerabilidad.x = chico.x + 3
      contadorInvulnerabilidad.y = chico.y - 27
      contadorInvulnerabilidad.text = tiempoInvulnerabilidad
   end
end
timercontarInv = timer.performWithDelay(1, contarInv, 0)
------------------------------------------------------------------------
--Arreglo de caramelos.
local contCaramelos = 0
local caramelInGame = false
local contador = 0
local cantidad = 3
function arregloCandy(cantidad,posx,posy)
   local isCandyOut = false
   if inGame == true and caramelInGame == false then
      arregloCaramelos = {}
	  caramelInGame = true
	  contador = 0
      for x = 1, cantidad do 
         --arregloCaramelos[x] = sprite.newSprite( spriteCaramelo )
		 local colorAleatorio = math.random(1,2)
		 if (colorAleatorio == 1) then
		    arregloCaramelos[x] = display.newImage("image/objetos/candyPurple.png")
		 elseif (colorAleatorio == 2) then
		    arregloCaramelos[x] = display.newImage("image/objetos/candyRed.png")
		 end
         arregloCaramelos[x].x = posx + (x * 26); arregloCaramelos[x].y = posy
		 
	 function ColisionCaramelo()
	       if(isCandyOut == false) then 
	           if (chico.x + 25.5 > arregloCaramelos[x].x) and (chico.x < arregloCaramelos[x].x + 16) and (chico.y + 42 > arregloCaramelos[x].y) and (chico.y < arregloCaramelos[x].y + 16) then 
			       if (contCaramelos < 1000) then
                      contCaramelos = contCaramelos + 1
				   end
	                  arregloCaramelos[x]:removeSelf()
				      contador = contador + 1
				   if (contador == cantidad) then
			           caramelInGame = false
					   contador = 0
					   isCandyOut = true 
				   end
                  --audio.play( coinSound )
               end
			end 
      end
      timerColisionCaramelo = timer.performWithDelay(1,ColisionCaramelo,0)
	  local function moverCaramelos ()
	       if(isCandyOut == false) then 
		       if (caramelInGame == true) then
                   arregloCaramelos[x]:translate(-movimientox, 0)
			   end
               if (arregloCaramelos[x].x < -16) then
                       arregloCaramelos[x]:removeSelf()
			           contador = contador + 1
			       if (contador == cantidad) then
			           caramelInGame = false
			           contador = 0
					   isCandyOut = true 
			       end
               end
		   end 
       end
        timermoverCaramelos = timer.performWithDelay(10,moverCaramelos,0)
      end
   end
end
function randomCandy()
   if inGame == true then
      arregloCandy(cantidad,480,math.random (75, 238))
   end
end
timerrandomCandy = timer.performWithDelay(2200,randomCandy,0)
local Caramel = display.newImage("image/objetos/candyRed.png")
Caramel.x = 235
Caramel.y = 20
local CaramelosText = display.newText("", 0, 0, native.systemFont, 20)
CaramelosText:setTextColor(514, 514, 514)
CaramelosText.x = Caramel.x - 25
CaramelosText.y = Caramel.y
function mostrarCaramelos(contCaramelos)
   CaramelosText.text = contCaramelos
end
------------------------------------------------------------------------
--Función para desactivar o activar la aparición de enemigos.
function DesactivarEnemigos(Desactivar)
   if (Desactivar == true) then
      if (enemigoAct == true) then
         enemigoAct = false
      end
      if (camillaAct == true) then
         camillaAct = false
      end
	  if (enemigoBombaAct == true) then 
         enemigoBombaAct = false 
      end 	  
   else
      if (enemigoAct == false) then
         enemigoAct = true
      end
      if (camillaAct == false) then
         camillaAct = true
      end
	  if (enemigoBombaAct == false) then 
	      enemigoBombaAct = true
	  end   
   end
end
function DesactivarCaramelos(Desactivar)
   if (Desactivar == true) then
      carameloAct = false
   else
      carameloAct = true
   end
end
------------------------------------------------------------------------
--Enemigo1
local dir = true
local enemigoY = 0
local enemigoX = -10
local reanudarX = 0
local reanudarY = 0
local enemigoInGame = false
local randomizer = 0
function crearenemigo()
   local isEnemy1Dead = false  -- false: vivo, true: muerto 
   if inGame == true and enemigoAct == true and enemigoInGame == false then
      local enemigo = sprite.newSprite( spriteEnemigo ) --Si lo vuelvo local, como la camilla para eliminarlo, se descontrola...
      enemigo.x = 480; enemigo.y = math.random (75, 238)
      enemigo:prepare("enemigo")
	  enemigoInGame = true 
	  randomizer = math.random (1, 2)
	  if randomizer == 1 then
	     enemigoY = -5
         reanudarY = enemigoY
		 dir = true
      else
         enemigoY = 5
         reanudarY = enemigoY
         dir = false
      end
      function enemyPlayPause(Bool)
         if Bool == true then
            enemigo:play()
         else
            enemigo:pause()
         end
      end
      enemyPlayPause(inGame)
      function translateenemigo ()
	    if(isEnemy1Dead == false) then 
         if enemigo.y <= 50 and dir == true then
            enemigoY = 5
            enemigoX = -math.random (1, 5)
            reanudarY = enemigoY
            reanudarX = enemigoX
            dir = false
         elseif enemigo.y >= 238 and dir == false then
            enemigoY = -5
            enemigoX = -math.random (1, movimientox)
            reanudarY = enemigoY
            reanudarX = enemigoX
            dir = true
         end  
            enemigo:translate (enemigoX, enemigoY) 
         if enemigo.x < -30 then
		    isEnemy1Dead = true 
            enemigo:removeSelf()
			enemigoInGame = false
         end
	   end
      end
      timertranslateenemigo = timer.performWithDelay(1,translateenemigo,0)
  function colisionenemigo ()
	    if(isEnemy1Dead == false) then 
           if (chico.x + 25.5 > enemigo.x) and (chico.x < enemigo.x + 30) and (chico.y + 42 > enemigo.y) and (chico.y < enemigo.y + 30) then
                 enemigo:removeSelf()
			     isEnemy1Dead = true 
			     enemigoInGame = false
                 musica.inicio("hit", muteSound)
               if (invulnerabilidad == true) then
                   for i = 1, contVidas do
                      arreglovidas[i]:removeSelf()
                   end
                     contVidas = contVidas - 1
                     vida(contVidas)
                   if (contVidas <= 0) then
                       if (contAttBoss == true) then
                           BossAttAtc = false  
                       end
                        die()
                   end
               end
           end
	   end 	  
   end
     timercolisionenemigo = timer.performWithDelay(1,colisionenemigo,0)
   end
end
timercrearenemigo = timer.performWithDelay(1,crearenemigo,0)
------------------------------------------------------------------------
--Enemigo 2 (Camilla de hospital (Saltar))
local camillaInGame = false
function crearCamilla()
   local isEnemy2Dead = false -- false: vivo, true: muerto 
   if (camillaInGame == false) and (inGame == true) and (camillaAct == true) then
      camilla = display.newImage( "image/enemigos/camilla.png" )
      camilla.x = 480; camilla.y = math.random(210, 238)
	  camillaInGame = true
      function translateCamilla()
	     if(isEnemy2Dead == false) then 
	          if (camillaInGame == true) then
                  camilla:translate (-movimientox, 0) 
              end		 
              if (camilla.x < -60) and (camillaInGame == true) then 
                  isEnemy2Dead = true 
                  camilla:removeSelf()
			      camillaInGame = false
              end 
           end 		   
       end
      timertranslateCamilla = timer.performWithDelay(1,translateCamilla,0)
    function colisionCamilla()
	  if(isEnemy2Dead == false) then 
           if (chico.x + 25.5 > camilla.x) and (chico.x < camilla.x + 60) and (camillaInGame == true) and (chico.y + 42 > camilla.y) and (chico.y < camilla.y + 30) then
			   isEnemy2Dead = true 
               camilla:removeSelf()
			   camillaInGame = false
               musica.inicio("hit", muteSound)
               if (invulnerabilidad == true) then
                  for i = 1, contVidas do
                     arreglovidas[i]:removeSelf()
                  end
                  contVidas = contVidas - 1
                  vida(contVidas)
                   if (contVidas <= 0) then
                      if (contAttBoss == true) then
                         --Explicación arriba del porque de esta condición.
                         BossAttAtc = false
                      end
                        die()
                   end
               end
           end
	   end 
    end
      timercolisionCamilla = timer.performWithDelay(1,colisionCamilla,0)
   end
end
timercrearCamilla = timer.performWithDelay(5000,crearCamilla,0)
------------------------------------------------------------------------
--Funcion para enemigo bomba 
function validarBombas(colorBomba,enemyX,enemyY)
    if (colorBomba == 1) then
           bombVerde = sprite.newSprite(spriteBombaVerde)  
	       bombVerde.x = enemyX + 56 - 13.25;  bombVerde.y = enemyY + 22		   
           bombVerde:prepare("bombaVerde")   
		   manchaVerde = sprite.newSprite(spriteBombaManchas)   
           manchaVerde:prepare("verde")     
    end		   
    if (colorBomba == 2) then
		   bombNaranja = sprite.newSprite(spriteBombaNaranja)  
	       bombNaranja.x = enemyX + 56 - 39.75 ; bombNaranja.y = enemyY + 22
           bombNaranja:prepare("bombaNaranja")  
		   manchaNaranja = sprite.newSprite(spriteBombaManchas)   
           manchaNaranja:prepare("naranja")    		   
    end	 	
    if (colorBomba == 3) then
		   bombAzul = sprite.newSprite(spriteBombaAzul)  
	       bombAzul.x = enemyX + 55 - 66.25 ; bombAzul.y = enemyY + 22
           bombAzul:prepare("bombaAzul") 
           manchaAzul = sprite.newSprite(spriteBombaManchas)   
           manchaAzul:prepare("azul")	   
    end	 	
    if (colorBomba == 4) then
		   bombAmarilla = sprite.newSprite(spriteBombaAmarilla)  
	       bombAmarilla.x = enemyX + 54 - 92.75 ; bombAmarilla.y = enemyY + 22
           bombAmarilla:prepare("bombaAmarilla")
		   manchaAmarilla = sprite.newSprite(spriteBombaManchas)   
           manchaAmarilla:prepare("amarillo")   
    end	
end 
------------------------------------------------------------------------
--Enemigo Bomba 
isEnemyBombInGame = false -- usado para el reset Game. 
isBombGreenInGame = false ;  isBombOrangeInGame = false ;  isBombBlueInGame = false ;  isBombYellowInGame = false -- usados para el reset Game. 
isManchaGreenInGame = false ; isManchaOrangeInGame = false ; isManchaBlueInGame = false ; isManchaYellowInGame = false --usados para el reset Game.
movEnemigoBomba = 2 ; movBombas = 2 
function crearEnemigoBomba() 
   local bombGreen = 1; bombOrange = 2; bombBlue = 3; bombYellow = 4 -- valores para el tipo de bomba. 
   local isbombGreen = false; isbombOrange = false; isbombBlue = false; isbombYellow = false -- booleanos para las bombas. 
   local isManchaGreen = false; isManchaOrange = false; isManchaBlue = false; isManchaYellow = false -- booleanos para las manchas. 
   local isEnemyDead = false 
   if (inGame == true) and (enemigoBombaAct == true ) and (isEnemyBombInGame == false) then 
      enemigoBomba = sprite.newSprite( spriteEnemigoBomba )                   
      enemigoBomba.x = 0; enemigoBomba.y = math.random (75, 100)
      enemigoBomba:prepare("enemigoBomba")
	  enemigoBomba:play()
	  isEnemyBombInGame = true 
	  local Tipobomba = math.random (1,4)
	  local Tipobomba2 = math.random (1,4)   
	  while(Tipobomba == Tipobomba2) do 
	        Tipobomba2 = math.random (1,4)     
	  end 
	  if(bombGreen == Tipobomba) then
	       validarBombas(bombGreen,enemigoBomba.x,enemigoBomba.y) 
		   isbombGreen = true  
		   isManchaGreen = true  
		   isBombGreenInGame = true 
		   isManchaGreenInGame = true 
	       if(Tipobomba2 == bombOrange) then
	          validarBombas(bombOrange,enemigoBomba.x,enemigoBomba.y) 
              isbombOrange = true 
			  isManchaOrange = true
			  isBombOrangeInGame = true 
			  isManchaOrangeInGame = true 
		   elseif(Tipobomba2 == bombBlue) then
	          validarBombas(bombBlue,enemigoBomba.x,enemigoBomba.y) 
              isbombBlue = true
			  isManchaBlue = true
              isBombBlueInGame = true 	
			  isManchaBlueInGame = true 
		   elseif(Tipobomba2 == bombYellow) then 
	          validarBombas(bombYellow,enemigoBomba.x,enemigoBomba.y) 
              isbombYellow = true 
			  isManchaYellow = true 
			  isBombYellowInGame = true 
			  isManchaYellowInGame = true 
		   end 
	  elseif(bombOrange == Tipobomba) then
	       validarBombas(bombOrange,enemigoBomba.x,enemigoBomba.y) 
    	   isbombOrange = true  
		   isManchaOrange = true
		   isBombOrangeInGame = true 
		   isManchaOrangeInGame = true 
	       if(Tipobomba2 == bombGreen) then 
	          validarBombas(bombGreen,enemigoBomba.x,enemigoBomba.y) 
              isbombGreen = true 
			  isManchaGreen = true  
			  isBombGreenInGame = true 
			  isManchaGreenInGame = true 
		   elseif(Tipobomba2 == bombBlue) then
	          validarBombas(bombBlue,enemigoBomba.x,enemigoBomba.y) 
     	      isbombBlue = true 
			  isManchaBlue = true
			  isBombBlueInGame = true 	
			  isManchaBlueInGame = true 
		   elseif(Tipobomba2 == bombYellow) then
	          validarBombas(bombYellow,enemigoBomba.x,enemigoBomba.y) 
              isbombYellow = true 
			  isManchaYellow = true 
			  isBombYellowInGame = true 
			  isManchaYellowInGame = true 
		   end 
	  elseif(bombBlue == Tipobomba) then 
	       validarBombas(bombBlue,enemigoBomba.x,enemigoBomba.y) 
           isbombBlue = true
		   isManchaBlue = true
           isBombBlueInGame = true 
		   isManchaBlueInGame = true 
	       if(Tipobomba2 == bombOrange) then 
	          validarBombas(bombOrange,enemigoBomba.x,enemigoBomba.y) 
              isbombOrange = true 
			  isManchaOrange = true
			  isBombOrangeInGame = true 
			  isManchaOrangeInGame = true
		   elseif(Tipobomba2 == bombGreen) then
	          validarBombas(bombGreen,enemigoBomba.x,enemigoBomba.y) 
              isbombGreen = true
			  isManchaGreen = true
			  isBombGreenInGame = true
 			  isManchaGreenInGame = true  
		   elseif(Tipobomba2 == bombYellow) then 
	          validarBombas(bombYellow,enemigoBomba.x,enemigoBomba.y) 
              isbombYellow = true
			  isManchaYellow = true 
			  isBombYellowInGame = true 
			  isManchaYellowInGame = true
		   end 
	  elseif(bombYellow == Tipobomba) then 
	       validarBombas(bombYellow,enemigoBomba.x,enemigoBomba.y) 
           isbombYellow = true
		   isManchaYellow = true 
		   isBombYellowInGame = true 
		   isManchaYellowInGame = true
	       if(Tipobomba2 == bombOrange) then 
	          validarBombas(bombOrange,enemigoBomba.x,enemigoBomba.y) 
              isbombOrange = true 
			  isManchaOrange = true
			  isBombOrangeInGame = true  
			  isManchaOrangeInGame = true
		   elseif(Tipobomba2 == bombBlue) then 
	          validarBombas(bombBlue,enemigoBomba.x,enemigoBomba.y) 
              isbombBlue = true
			  isManchaBlue = true
	          isBombBlueInGame = true 
			  isManchaBlueInGame = true 
		   elseif(Tipobomba2 == bombGreen) then 
	          validarBombas(bombGreen,enemigoBomba.x,enemigoBomba.y) 
              isbombGreen = true
			  isManchaGreen = true
			  isBombGreenInGame = true
			  isManchaGreenInGame = true  
		   end
	  end 
	  function translateEnemigoBomba()
	     if(isEnemyDead == false) then 
		    enemigoBomba:translate (movEnemigoBomba, 0)      
			 if (isbombGreen == true) then
                 bombVerde:translate(movBombas,0)   
             end	
             if (isbombOrange == true ) then 
	             bombNaranja:translate(movBombas,0)
             end		
             if (isbombBlue == true) then 
		         bombAzul:translate(movBombas,0) 
             end			
             if (isbombYellow == true) then 
	             bombAmarilla:translate(movBombas,0)	
             end
			 if enemigoBomba.x - 54 > 480 then 
		        isEnemyDead = true			
			    if (isbombGreen == true) then
				    isbombGreen = false 
				    isBombGreenInGame = false 
		     	    bombVerde:removeSelf()
			    end 
		        if (isbombOrange == true) then
				    isbombOrange = false 
				    isBombOrangeInGame = false
			        bombNaranja:removeSelf()  
			    end 
			    if (isbombBlue == true) then
				    isbombBlue = false 
				    isBombBlueInGame = false
			        bombAzul:removeSelf()
			    end 
			    if (isbombYellow == true) then
				    isbombYellow = false
				    isBombYellowInGame = false
			        bombAmarilla:removeSelf()
			    end 
				isEnemyBombInGame = false	
			    enemigoBomba:removeSelf()
             end 	 
		 end 			 
      end
	 timerEnemyBomb = timer.performWithDelay(1,translateEnemigoBomba,0)
	  function translateBomba()
            if (isbombGreen == true and  isEnemyDead == false) then
			   if(enemigoBomba.x - 54 >= 0 and enemigoBomba.x - 54 <= 480) then 	 
			      bombVerde:play()
				  bombVerde:translate(0,movBombas)
			   end
            end	
            if (isbombOrange == true and  isEnemyDead == false) then 
			   if(enemigoBomba.x - 54 >= 0 and enemigoBomba.x - 54 <= 480) then
				  bombNaranja:play()
				  bombNaranja:translate(0,movBombas)
			   end
            end		
            if (isbombBlue == true and  isEnemyDead == false) then 
			   if(enemigoBomba.x - 54 >= 0 and enemigoBomba.x - 54 <= 480) then
				  bombAzul:play()
				  bombAzul:translate(0,movBombas)
			   end
            end			
            if (isbombYellow == true and  isEnemyDead == false) then
			   if(enemigoBomba.x - 54 >= 0 and enemigoBomba.x - 54 <= 480) then
				bombAmarilla:play()
                bombAmarilla:translate(0,movBombas)		           
			   end
            end		 			
	   end  
	  timerBombas = timer.performWithDelay(1,translateBomba,0)      
	   function VerificarColisionBomba() 
	        if (isEnemyDead == false) then 
	           if (isbombGreen == true and bombVerde.y >= 255) then
			       if(isManchaGreen == true) then 
				      manchaVerde.x = bombVerde.x;    manchaVerde.y = 255
				   end 
				   bombVerde.x = enemigoBomba.x + 56 - 13.25;  bombVerde.y = enemigoBomba.y + 22
               end	
               if (isbombOrange == true and bombNaranja.y >= 255) then 
			       if(isManchaOrange == true) then
			          manchaNaranja.x = bombNaranja.x ;    manchaNaranja.y = 255
				   end 
			       bombNaranja.x = enemigoBomba.x + 56 - 39.75 ; bombNaranja.y = enemigoBomba.y + 22
               end		
               if (isbombBlue == true  and bombAzul.y >= 255) then 
			       if(isManchaBlue == true) then
				      manchaAzul.x =  bombAzul.x ;    manchaAzul.y = 255
				   end 
				   bombAzul.x = enemigoBomba.x + 55 - 66.25 ; bombAzul.y = enemigoBomba.y + 22
               end			
               if (isbombYellow == true and bombAmarilla.y >= 255) then
			       if(isManchaYellow == true) then
				      manchaAmarilla.x = bombAmarilla.x ;    manchaAmarilla.y = 255
				   end 
				   bombAmarilla.x = enemigoBomba.x + 54 - 92.75 ; bombAmarilla.y = enemigoBomba.y + 22
               end	   
		    else
			   if(isManchaGreen == true) then 
				    isManchaGreen = false 
				    isManchaGreenInGame = false
				    manchaVerde:removeSelf()
			   end 
			   if(isManchaOrange == true) then 
				    isManchaOrange = false 
				    isManchaOrangeInGame = false
				    manchaNaranja:removeSelf()
			   end 
			   if(isManchaBlue == true) then 
				    isManchaBlue = false 
				    isManchaBlueInGame = false 
				    manchaAzul:removeSelf()
			   end
			   if(isManchaYellow == true) then 
				    isManchaYellow = false 
				    isManchaYellowInGame = false
				    manchaAmarilla:removeSelf()
			   end 
		  end
       end 	  
	  timerColisionBombaY = timer.performWithDelay(1,VerificarColisionBomba,0)   
	  function translateManchas()
            if (isManchaGreen == true and isEnemyDead == false) then
			     manchaVerde:translate(-movimientox, 0)
            end	
            if (isManchaOrange == true and isEnemyDead == false) then 
			    manchaNaranja:translate(-movimientox, 0)
            end		
            if (isManchaBlue == true and isEnemyDead == false) then 
			   manchaAzul:translate(-movimientox, 0)
            end			
            if (isManchaYellow == true and isEnemyDead == false) then
			   manchaAmarilla:translate(-movimientox, 0)
            end	 
	   end 
	   timerManchas = timer.performWithDelay(1,translateManchas,0) 
	    function colisionEnemigosBomba() 
		  if(isEnemyDead == false) then 
	        if (chico.x + 25.5 > enemigoBomba.x - 54) and (chico.x < enemigoBomba.x + 54 ) and  (chico.y + 42 > enemigoBomba.y) and (chico.y < enemigoBomba.y + 28) then 
              if (isbombGreen == true) then
			      isbombGreen = false 
			      isBombGreenInGame = false 
		     	  bombVerde:removeSelf()
			  end 
		      if (isbombOrange == true) then
			      isbombOrange = false 
			      isBombOrangeInGame = false 
			      bombNaranja:removeSelf()  
			  end 
			  if (isbombBlue == true) then
			      isbombBlue = false 
			      isBombBlueInGame = false 
			      bombAzul:removeSelf()
			  end 
			  if (isbombYellow == true) then
			      isbombYellow = false 
			      isBombYellowInGame = false
			      bombAmarilla:removeSelf()
			  end 
			   isEnemyBombInGame = false
			   enemigoBomba:removeSelf()
               musica.inicio("hit", muteSound)
			 if (invulnerabilidad == true) then
               for i = 1, contVidas do
                  arreglovidas[i]:removeSelf()
               end
               contVidas = contVidas - 1
               vida(contVidas)
               if (contVidas <= 0) then
                  die()
               end
			  end
             end
		   end 
         end  
		timerColisionEnemigoBomba = timer.performWithDelay(1,colisionEnemigosBomba,0) 
	  function colisionConBombas() 
         if(isEnemyDead == false) then 
		   if (isbombGreen == true) and (chico.x + 25.5 > bombVerde.x ) and (chico.x < bombVerde.x + 16) and  (chico.y + 42 > bombVerde.y) and (chico.y < bombVerde.y + 14) then 
		          isBombGreenInGame = false
		     	  bombVerde:removeSelf()
				  isbombGreen = false 
		          musica.inicio("hit", muteSound)
			   if (invulnerabilidad == true) then 
                  for i = 1, contVidas do
                    arreglovidas[i]:removeSelf()
                  end
                  contVidas = contVidas - 1
                  vida(contVidas)
                  if (contVidas <= 0) then
                      die()
                  end
			   end 
			elseif((isbombOrange == true) and(chico.x + 25.5 > bombNaranja.x ) and (chico.x < bombNaranja.x + 16) and  (chico.y + 42 > bombNaranja.y) and (chico.y < bombNaranja.y + 14)) then 
			        isBombOrangeInGame = false
                    bombNaranja:removeSelf()  
					isbombOrange = false
				    musica.inicio("hit", muteSound)
			   if (invulnerabilidad == true) then
                    for i = 1, contVidas do
                      arreglovidas[i]:removeSelf()
                    end
                    contVidas = contVidas - 1
                    vida(contVidas)
                    if (contVidas <= 0) then
                       die()
                    end
			   end 
            elseif((isbombBlue == true) and(chico.x + 25.5 > bombAzul.x ) and (chico.x < bombAzul.x + 16) and  (chico.y + 42 > bombAzul.y) and (chico.y < bombAzul.y + 14)) then 
			         isBombBlueInGame = false 
                     bombAzul:removeSelf()
                     isbombBlue = false				 
					 musica.inicio("hit", muteSound)
			   if (invulnerabilidad == true) then
                     for i = 1, contVidas do
                      arreglovidas[i]:removeSelf()
                     end
                     contVidas = contVidas - 1
                     vida(contVidas)
                     if (contVidas <= 0) then
                        die()
                     end
			   end 
            elseif((isbombYellow == true) and(chico.x + 25.5 > bombAmarilla.x ) and (chico.x < bombAmarilla.x + 16) and  (chico.y + 42 > bombAmarilla.y) and (chico.y < bombAmarilla.y + 14)) then 
			         isBombYellowInGame = false
			         bombAmarilla:removeSelf()
			         bombAmarilla = nil
					 isbombYellow = false
                     musica.inicio("hit", muteSound)
			   if (invulnerabilidad == true) then
                     for i = 1, contVidas do
                       arreglovidas[i]:removeSelf()
                     end
                     contVidas = contVidas - 1
                     vida(contVidas)
                     if (contVidas <= 0) then
                        die()
                     end
               end 					 
		    end
         end			 
      end 	
      timerColisionBombas = timer.performWithDelay(1,colisionConBombas,0)	
   end 
end 
timerCrearEnemigoBomba = timer.performWithDelay(math.random(10000, 11000),crearEnemigoBomba,0)
------------------------------------------------------------------------
--Boss
local bossAtt = sprite.newSpriteSheet("image/enemigos/bossAtt2.png",29,21)
local spritebossAtt = sprite.newSpriteMultiSet( 
{
   {sheet = bossAtt, frames = {1,2}},
})
sprite.add(spritebossAtt,"bossAtt",1,2,300,0)
------------------------------------------------------------------------
local boss1 = sprite.newSpriteSheet("image/enemigos/boss1.png",300,300)
local spriteboss1 = sprite.newSpriteMultiSet( 
{
   {sheet = boss1, frames = {1,2}},
})
sprite.add(spriteboss1,"boss1",1,2,300,0)
------------------------------------------------------------------------
local BossAttAtc = true
local contBoss = false
local inhBala = true
local reanudarPosBoss = 0
local tiempoBoss = 500
local tiempoVidaBoss = 0
function Boss()
   if (contDistancia > 800 and BossAct == true and inGame == true) then
      BossAct = false
      contBoss = true
      DesactivarEnemigos(true)
	  DesactivarCaramelos(true)
      Jefe = sprite.newSprite( spriteboss1 )
      Jefe:prepare("boss1")
      Jefe.x = 600; Jefe.y = 150
	  Jefe:scale(0.75, 0.75)
      function enemyPlayPause(Bool)
         if Bool == true then
            Jefe:play()
         else
            Jefe:pause()
         end
      end
      enemyPlayPause(inGame)
      local function aparicionBoss()
         if (inGame == true) then
            tiempoVidaBoss = tiempoVidaBoss + 1
         end
         if ((Jefe.x > 390) and (tiempoVidaBoss < tiempoBoss) and reanudarPosBoss == 0) then
            Jefe.x = Jefe.x - 2
         elseif ((tiempoVidaBoss >= tiempoBoss) and reanudarPosBoss == 0) then
            Jefe.x = Jefe.x + 2
         end
         if ((tiempoVidaBoss >= tiempoBoss + 100) and reanudarPosBoss == 0) then
            Jefe:removeSelf()
            BossAttAtc = false
            contBoss = false
            DesactivarEnemigos(false)
			DesactivarCaramelos(false)
         end
      end
      timeraparicionBoss = timer.performWithDelay(1,aparicionBoss,0)
      function Atacar()
         if (BossAttAtc == true and inGame == true and inhBala == true) then
            inhBala = false
            contAttBoss = true
            AtaqueBoss(Jefe.x - 30, math.random(190,210))
         end
      end
      timerAtacar = timer.performWithDelay(2000,Atacar,0)
      function colisionBoss()
         if (chico.x + 25.5 > Jefe.x - 70) and (chico.x < Jefe.x + 300) then
            if (chico.y + 42 > Jefe.y - 70) and (chico.y < Jefe.y + 300) then
               Jefe:removeSelf()
               BossAttAtc = false
               contBoss = false
               musica.inicio("hit", muteSound)
               die()
            end
         end
      end
      timercolisionBoss = timer.performWithDelay(1,colisionBoss,0)
   end
end     
timerBoss = timer.performWithDelay(1,Boss,0)
------------------------------------------------------------------------
--[[local bossAttRandom = 0
local dirAB = true
local BossAttX = -10
local BossAttY = 0
local reanudarBAX = 0
local reanudarBAY = 0
local randomY = 0]]
function AtaqueBoss(posx, posy)
      bossAttack = sprite.newSprite( spritebossAtt )
      bossAttack.x = posx; bossAttack.y = posy
      bossAttack:prepare("bossAtt")
	  bossAttack:scale(2,2)
	  --bossAttRandom = math.random(1,2)
	  --[[if bossAttRandom == 1 then
	     BossAttY = -5
         reanudarBAY = BossAttY
		 dirAB = true
      else
         BossAttY = 5
         reanudarBAY = BossAttY
         dirAB = false
      end]]
      function enemyPlayPause(Bool)
         if Bool == true then
            bossAttack:play()
         else
            bossAttack:pause()
         end
      end
      enemyPlayPause(inGame)
      function moverAtaque()
	     --[[randomY = math.random(50, 210)
	     if bossAttack.y <= randomY  and dirAB == true then
            BossAttY = 5
            BossAttX = -math.random (1, movimientox)
            reanudarBAY = BossAttY
            reanudarBAX = BossAttX
            dirAB = false
         elseif bossAttack.y >= 238 and dirAB == false then
            BossAttY = -5
            BossAttX = -math.random (1, movimientox)
            reanudarBAY = BossAttY
            reanudarBAX = BossAttX
            dirAB = true
         end  ]]
	     --[[if (bossAttRandom == 1) then
            bossAttack:translate (-movimientox, 0)
	     elseif (bossAttRandom == 2) then
            bossAttack:translate (BossAttX, BossAttY)
		 end]]
         bossAttack:translate (-movimientox, 0)
         if (bossAttack.x < -30) then 
            bossAttack:removeSelf()
			bossAttack = nil 
            inhBala = true
            contAttBoss = false
         end
      end
      timermoverAtaque = timer.performWithDelay(1,moverAtaque,0)
      function colisionBossAttack()
         if (chico.x + 25.5 > bossAttack.x) and (chico.x < bossAttack.x + 30) then
            if (chico.y + 42 > bossAttack.y) and (chico.y < bossAttack.y + 40) then
               bossAttack:removeSelf()
               inhBala = true
               contAttBoss = false
               musica.inicio("hit", muteSound)
               if (invulnerabilidad == true) then
                  for i = 1, contVidas do
                     arreglovidas[i]:removeSelf()
                  end
                  contVidas = contVidas - 1
                  vida(contVidas)
                  if (contVidas <= 0) then
                     BossAttAtc = false
                     die()
                  end
               end
            end
         end
      end
      timercolisionBossAttack = timer.performWithDelay(1,colisionBossAttack,0)
end
------------------------------------------------------------------------
--Función salto
function Salto()
   chico.y = chico.y + vmovimientoy
end
timerSalto = timer.performWithDelay(1,Salto,0)

function Saltar(event)
   if (event.phase == "began") and cont == 0 then
      musica.inicio("salto", muteSound)
   end
   if cont == 0 then
      cont2 = 1
      vmovimientoy = -6
   end
   if ( event.phase == "ended" ) then
      cont = 1
	  
   end
end

function PisoTecho()
   if chico.y <= 90 and cont2 == 1 then
      cont = 1
   end
   if (chico.y >= 238) then
      chico.y = 238
      vmovimientoy = 0
      cont = 0
      cont2 = 0
	  multMovY = 1 
   end
end
timerPisoTecho = timer.performWithDelay(1,PisoTecho,0)

local function Bajar()
   if vmovimientoy < 6 and cont == 1 and cont2 == 1 and inGame == true then
      vmovimientoy = vmovimientoy + 0.8
   end
end
timerBajar = timer.performWithDelay(30,Bajar,0)
------------------------------------------------------------------------
--Funciones de mover personaje.
function MoverPersonaje ()
   chico.x = chico.x + vmovimientox * multMovX
end
timerMoverPersonaje = timer.performWithDelay(1,MoverPersonaje,0)

function MoverseDerecha (event)
   if LimDer == false then
      chico.x = chico.x + 10
      multMovX = 1
      LimDer = true
   end
      vmovimientox = velocidadmov
	  if (invulnerabilidad == false) then
	     chico:prepare("invulnerableDerecha")
	  else
         chico:prepare("derecha")
	  end
      chico:play()
   if ( event.phase == "ended" ) then
      vmovimientox = 0
   end
end

function MoverseIzquierda (event)
   if LimIzq == false then
      chico.x = chico.x - 10
      multMovX = 1
      LimIzq = true
   end
   vmovimientox = - velocidadmov * 1.5
   if (invulnerabilidad == false) then
	  chico:prepare("invulnerableIzquierda")
   else
      chico:prepare("izquierda")
   end
   chico:play()
   if ( event.phase == "ended" ) then
	  if (invulnerabilidad == false) then
	     chico:prepare("invulnerableDerecha")
	  else
         chico:prepare("derecha")
	  end
      chico:play()
      vmovimientox = 0
   end
end
------------------------------------------------------------------------
--Validación de límites de la pantalla.
function validarLimitesPantalla()
    if chico.x <= 20 then
       multMovX = 0
       LimDer = false
    end 
    if chico.x >= 460 then
       multMovX = 0
       LimIzq = false
    end 
end
timervalidarLimitesPantalla = timer.performWithDelay(1,validarLimitesPantalla,0)
------------------------------------------------------------------------
--Función contador distancia.
function Distancia()
   if inGame == true then
      contDistancia = contDistancia + 1
      mostrarDist(contDistancia)
	  mostrarCaramelos(contCaramelos)
	  if contCaramelos >= 0 and contCaramelos < 10 then
         CaramelosText.text = ("00" .. contCaramelos)
      elseif contCaramelos >= 10 and contCaramelos < 100 then
         CaramelosText.text = ("0" .. contCaramelos)
      elseif contCaramelos >= 100 and contCaramelos < 1000 then
         CaramelosText.text = (contCaramelos)
      end
      if (contDistancia > 1000 and contDistancia < 2000) then
	  --if (contDistancia > 1 and contDistancia < 50) then
         cambioDeEscenarios(1)
      end
      if (contDistancia > 2000 and contDistancia < 3000) then
      --if (contDistancia > 50 and contDistancia < 100) then
         cambioDeEscenarios(2)
      end
   end
end
timerDistancia = timer.performWithDelay(120,Distancia,0)
------------------------------------------------------------------------
local reanudarAceleracion = 10
local contAceleracion = 0
function Acelerador()
   if inGame == true then
      contAceleracion = contAceleracion + 1
      if movimientox < 15 and contAceleracion > 500 then
	     movimientox = movimientox + 1
		 reanudarAceleracion = movimientox
		 contAceleracion = 0
	  end
   end
end
timerAcelerador = timer.performWithDelay(100,Acelerador,0)
------------------------------------------------------------------------
--Mostrar distancia
local metros = display.newText("", 0, 0, native.systemFont, 20)
metros:setTextColor(514, 514, 514)
metros.x = 150
metros.y = 20
function mostrarDist(contDistancia)
   metros.text = contDistancia
end
------------------------------------------------------------------------
--Creación botones.
local botonsaltar = display.newImage("image/Boton_A.png")
local botonderecha = display.newImage("image/botonderecha.png")
local botonizquierda = display.newImage("image/botonizquierda.png")
--local botonataque = display.newImage("image/ataque.png")
botonsaltar:scale(0.80,0.80)

botonderecha.x = display.contentWidth - 376
botonderecha.y = display.contentHeight - 17
botonizquierda.x = display.contentWidth - 445
botonizquierda.y = display.contentHeight - 17
botonsaltar.x = display.contentWidth - 20
botonsaltar.y = display.contentHeight - 18
--botonataque.x = display.contentWidth - 104
--botonataque.y = display.contentHeight - 17

botonderecha:addEventListener("touch", MoverseDerecha)
botonizquierda:addEventListener("touch", MoverseIzquierda)
botonsaltar:addEventListener("touch", Saltar)
--botonataque:addEventListener("tap", Ataque)
------------------------------------------------------------------------
--Pausa
function pausa()
   if (pausado == true) then
      pausado = false
      pausaFondo = display.newImage( "image/pausemenu.png" )
      pausaFondo.x = _W/2; pausaFondo.y = _H/2
      continue_btn = display.newImage("image/continue_btn.png")
      continue_btn.x = _W/2; continue_btn.y = _H/2 - 46
      continue_btn.name = "continue_btn"
      restart_btn = display.newImage("image/restart_btn.png")
      restart_btn.x = _W/2; restart_btn.y = _H/2
      restart_btn.name = "restart_btn"
      quitmenu_btn = display.newImage("image/quitmenu_btn.png")
      quitmenu_btn.x = _W/2; quitmenu_btn.y = _H/2 + 46
      quitmenu_btn.name = "quitmenu_btn"
      continue_btn:addEventListener("tap", desPausar)
      restart_btn:addEventListener("tap", restart)
      quitmenu_btn:addEventListener("tap", volverMenu)
      movimientox = 0 --Lo pongo en 2 para un efecto cool
      vmovimientoy = 0
      enemigoY = 0
      enemigoX = 0
      reanudarPosBoss = 1
      if (contAttBoss == true) then
         BossAttAtc = false
		 bossAttack:pause()
      end
      if (contBoss == true) then
         Jefe:pause()
      end
	  if(isEnemyBombInGame == true) then 
	      movEnemigoBomba = 0 ; movBombas = 0
	     if (isBombGreenInGame == true) then 
		     if(isManchaGreenInGame == true) then 
			    manchaVerde:pause()
			 end 
		       bombVerde:pause() 
		 end 
		  if (isBombOrangeInGame == true) then 
		     if(isManchaOrangeInGame == true) then 
			     manchaNaranja:pause()
			 end 
		      bombNaranja:pause()
		  end
		  if (isBombBlueInGame == true) then 
		     if(isManchaBlueInGame == true) then 
			     manchaAzul:pause()
			 end 
		     bombAzul:pause()	 
		  end
		  if (isBombYellowInGame == true) then 
		     if(isManchaYellowInGame == true) then 
			     manchaAmarilla:pause()
			 end 
		     bombAmarilla:pause()	
		  end
		  enemigoBomba:pause()
		  timer.pause( timerCrearEnemigoBomba ) 
          timer.pause(timerCorazones)
          timer.pause(timerMovimientoConstante)
          timer.pause(timerChupetas)
          timer.pause(timerquitarInvulnerabilidad)
          timer.pause(timercontarInv)
          timer.pause(timerrandomCandy)
          timer.pause(timercrearenemigo)
          timer.pause(timercrearCamilla)
          timer.pause(timerBoss)
          timer.pause(timerSalto)
          timer.pause(timerPisoTecho)
          timer.pause(timerBajar)
          timer.pause(timerMoverPersonaje)
          timer.pause(timervalidarLimitesPantalla)
          timer.pause(timerDistancia)
          timer.pause(timerAcelerador)   
		  timer.pause(timerEnemyBomb)
	      timer.pause(timerBombas)
	      timer.pause(timerColisionBombaY)
	      timer.pause(timerManchas)
	      timer.pause(timerColisionEnemigoBomba)
	      timer.pause(timerColisionBombas)  	
	  end 
      chico:pause()
      inGame = false
      removerHabilitar(true, false, false, false, false)
      if (muteSound == true) then
         media.pauseSound()
         musica.inicio("pausa", muteSound)
      end
      enemyPlayPause(inGame)
   end
end
------------------------------------------------------------------------
--Función quitar pausa
function desPausar()
   pausado = true
   --movimientox = reanudarAceleracion
   movimientox = reanudarAceleracion
   vmovimientoy = 6
   enemigoY = reanudarY
   enemigoX = reanudarX
   reanudarPosBoss = 0
   if (contBoss == true) then
      BossAttAtc = true
   end
   if (contAttBoss == true) then
      bossAttack:play()
   end
   if (contBoss == true) then
      Jefe:play()
   end
   if(isEnemyBombInGame == true) then 
         movEnemigoBomba = 2 ; movBombas = 2
	      if (isBombGreenInGame == true) then 
		     if(isManchaGreenInGame == true) then 
			    manchaVerde:play()
			 end 
		      bombVerde:play() 
		  end 
		  if (isBombOrangeInGame == true) then 
		     if(isManchaOrangeInGame == true) then 
			     manchaNaranja:play()
			 end 
		      bombNaranja:play()
		  end
		  if (isBombBlueInGame == true) then 
		     if(isManchaBlueInGame == true) then 
			     manchaAzul:play()
			 end		 
		     bombAzul:play()
		  end
		  if (isBombYellowInGame == true) then 
		     if(isManchaYellowInGame == true) then 
			     manchaAmarilla:play()
			 end 
		      bombAmarilla:play()
		  end
		  enemigoBomba:play()
		  timer.resume( timerCrearEnemigoBomba ) 
		  timer.resume(timerCorazones)
          timer.resume(timerMovimientoConstante)
          timer.resume(timerChupetas)
          timer.resume(timerquitarInvulnerabilidad)
          timer.resume(timercontarInv)
          timer.resume(timerrandomCandy)
          timer.resume(timercrearenemigo)
          timer.resume(timercrearCamilla)
          timer.resume(timerBoss)
          timer.resume(timerSalto)
          timer.resume(timerPisoTecho)
          timer.resume(timerBajar)
          timer.resume(timerMoverPersonaje)
          timer.resume(timervalidarLimitesPantalla)
          timer.resume(timerDistancia)
          timer.resume(timerAcelerador) 	  
		  timer.resume(timerEnemyBomb)
	      timer.resume(timerBombas)
	      timer.resume(timerColisionBombaY)
	      timer.resume(timerManchas)
	      timer.resume(timerColisionEnemigoBomba)
	      timer.resume(timerColisionBombas)  	
   end 
   chico:play()
   inGame = true
   removerHabilitar(false, true, true, false, false)
   if (muteSound == true) then
      media.pauseSound()
      musica.inicio("musicaJuego", muteSound)
   end     
   enemyPlayPause(inGame)
end
------------------------------------------------------------------------
--Función reiniciar partida
function restart()
   removerHabilitar(true, false, true, true, true)
   media.pauseSound()
   game.inicio(muteSound)
end
------------------------------------------------------------------------
--Función quitar juego
function volverMenu()
   movimientox = 0
   chico:pause()
   inGame = false
   removerHabilitar(true, false, true, true, true)
   media.pauseSound()
   menu.principal(muteSound)
end
------------------------------------------------------------------------
--Función para habilitar, deshabilitar y remover
function removerHabilitar(IBot, HBot, RPause, RGame, RBot)
   if (IBot == true) then
      botonderecha:removeEventListener("touch", MoverseDerecha)
      botonizquierda:removeEventListener("touch", MoverseIzquierda)
      botonsaltar:removeEventListener("touch", Saltar)
      mutear:removeEventListener("tap", mute)
      pausa_btn:removeEventListener("tap", pausa)
   elseif HBot == true then
      botonderecha:addEventListener("touch", MoverseDerecha)
      botonizquierda:addEventListener("touch", MoverseIzquierda)
      botonsaltar:addEventListener("touch", Saltar)
      mutear:addEventListener("tap", mute)
      pausa_btn:addEventListener("tap", pausa)  
   end
   if (RPause == true) then
      pausaFondo:removeSelf()
      continue_btn:removeSelf()
      restart_btn:removeSelf()
      quitmenu_btn:removeSelf()
   end
   if (RGame == true) then
      if (cambioEscenario == 0) then
         removeCambio1()
      end
      if (cambioEscenario == 1) then
         removeCambio1()
	     removeCambio2()
      end
	  if (cambioEscenario == 2) then
         removeCambio1()
	     removeCambio2()
	     removeCambio3()
      end
      if (contBoss == true) then
         Jefe:removeSelf()
         contBoss = false
      end
      if (contAttBoss == true) then
         bossAttack:removeSelf()
         contAttBoss = false
      end
      if (camillaInGame == true) then
         camilla:removeSelf()
      end
	  if (isEnemyBombInGame == true) then
	      print("paso") 
          if (isBombGreenInGame == true) then 
		     if(isManchaGreenInGame == true) then 
			    manchaVerde:removeSelf() 
			 end 
		      bombVerde:removeSelf()
		  end 
		  if (isBombOrangeInGame == true) then 
		     if(isManchaOrangeInGame == true) then 
			     manchaNaranja:removeSelf() 
			 end 
		      bombNaranja:removeSelf()  
		  end
		  if (isBombBlueInGame == true) then 
		     if(isManchaBlueInGame == true) then 
			     manchaAzul:removeSelf() 
			 end 
		     bombAzul:removeSelf()
		  end
		  if (isBombYellowInGame == true) then 
		     if(isManchaYellowInGame == true) then 
			     manchaAmarilla:removeSelf()
			 end 
		      bombAmarilla:removeSelf() 
		  end
		  enemigoBomba:removeSelf()		
	  end 
      --[[if (enemigoInGame == true) then
         enemigo:removeSelf()
      end]]
	  --No lo puedo remover así (enemigo) porque para eso necesito que la variable enemigo esté global y si la pongo global se descontrola (no se por qué) 
      if (caramelInGame == true) then
         for x = 1, cantidad do
	        arregloCaramelos[x]:removeSelf()
	     end
      end
      mutear:removeSelf()
      chico:removeSelf()
      pausa_btn:removeSelf()
      CaramelosText:removeSelf() 
      metros:removeSelf()
      for i = 1, contVidas do
         arreglovidas[i]:removeSelf()
      end
	  timer.cancel(timerCrearEnemigoBomba) 
	  timer.cancel(timerCorazones)
      timer.cancel(timerMovimientoConstante)
      timer.cancel(timerChupetas)
      timer.cancel(timerquitarInvulnerabilidad)
      timer.cancel(timercontarInv)
      timer.cancel(timerrandomCandy)
	  timer.cancel(timercrearenemigo)
	  timer.cancel(timercrearCamilla)
	  timer.cancel(timerBoss)
	  timer.cancel(timerSalto)
	  timer.cancel(timerPisoTecho)
	  timer.cancel(timerBajar)
	  timer.cancel(timerMoverPersonaje)
	  timer.cancel(timervalidarLimitesPantalla)
	  timer.cancel(timerDistancia)
	  timer.cancel(timerAcelerador) 
	  ------------------------------------------
	  --[[timer.cancel( timerEnemyBomb )
	  timer.cancel( timerBombas )
	  timer.cancel( timerColisionBombaY )
	  timer.cancel( timerManchas )
	  timer.cancel( timerColisionEnemigoBomba )
	 timer.cancel( timerColisionBombas )  	
	 timer.cancel( timertranslateLife  )  
	   timer.cancel( timercolisionVida  )  
	   timer.cancel( timermoverChupInv  )  
	  timer.cancel( timerColisionChupetaInv  )  
	  timer.cancel( timerColisionCaramelo )  
	   timer.cancel( timermoverCaramelos  )  
	   timer.cancel( timertranslateenemigo  )  
        timer.cancel( timercolisionenemigo  )  
	   timer.cancel( timertranslateCamilla  )  
	    timer.cancel( timeraparicionBoss  )  
	   timer.cancel( timerAtacar  )  
	   timer.cancel( timercolisionBoss  )  
	    timer.cancel( timermoverAtaque  )  
	  timer.cancel( timercolisionBossAttack ) ]] 
	 --------------------------------------------
   end
   if (RBot == true) then
      botonderecha:removeSelf()
      botonizquierda:removeSelf()
      botonsaltar:removeSelf()
   end
end
------------------------------------------------------------------------
--Botón pausa sprite.
pausa_btn = display.newImage( "image/pausa_btn.png" )
pausa_btn.x = 420; pausa_btn.y = 20
pausa_btn:addEventListener("tap", pausa)
------------------------------------------------------------------------
--Función morir
function die()
   chico:pause()
   inGame = false
   if (cambioEscenario == 0) then
      removeCambio1()
   end
   if (cambioEscenario == 1) then
      removeCambio1()
	  removeCambio2()
   end
   if (cambioEscenario == 2) then
      removeCambio1()
	  removeCambio2()
	  removeCambio3()
   end
   if (contBoss == true) then
      Jefe:removeSelf()
      contBoss = false
   end
   if (contAttBoss == true) then
      bossAttack:removeSelf()
      contAttBoss = false
   end
   if (camillaInGame == true) then
      camilla:removeSelf()
   end
   if (isEnemyBombInGame == true) then
          if (isBombGreenInGame == true) then 
		     if(isManchaGreenInGame == true) then 
			    manchaVerde:removeSelf() 
			 end 
		      bombVerde:removeSelf()
		  end 
		  if (isBombOrangeInGame == true) then 
		     if(isManchaOrangeInGame == true) then 
			     manchaNaranja:removeSelf() 
			 end 
		      bombNaranja:removeSelf()  
		  end
		  if (isBombBlueInGame == true) then 
		     if(isManchaBlueInGame == true) then 
			     manchaAzul:removeSelf() 
			 end 
		     bombAzul:removeSelf()
		  end
		  if (isBombYellowInGame == true) then 
		     if(isManchaYellowInGame == true) then 
			     manchaAmarilla:removeSelf()
			 end 
		      bombAmarilla:removeSelf() 
		  end
		  enemigoBomba:removeSelf()
   end 
   --[[if (enemigoInGame == true) then
      enemigo:removeSelf()
   end]]
   --Al remover los caramelos aquí da un error, siempre y cuando lo mismos se estén removiendo a la izquierda y justo me maten.
   if (caramelInGame == true) then
      for x = contador + 1, cantidad do
	     arregloCaramelos[x]:removeSelf()
	  end
   end
   mutear:removeSelf()
   chico:removeSelf()
   pausa_btn:removeSelf()
   for i = 1, contVidas do
      arreglovidas[i]:removeSelf()
   end
   botonderecha:removeEventListener("touch", MoverseDerecha)
   botonizquierda:removeEventListener("touch", MoverseIzquierda)
   botonsaltar:removeEventListener("touch", Saltar)
   botonderecha:removeSelf()
   botonizquierda:removeSelf()
   botonsaltar:removeSelf()
   mutear:removeEventListener("tap", mute)
   media.pauseSound()
   musica.inicio("gameover", muteSound)
   
   local cont = 0
   local path = system.pathForFile("archivos/highscore.txt")
   local file = io.open(path, "r")
   if file then
      cont = file:read( "*a" )
      io.close( file )
   end
   cont = tonumber(cont) 
   if (contDistancia > cont) then
      file = io.open(path, "w")
      file:write(contDistancia)
      cont = contDistancia
   end
   
   local contCan
   local path2 = system.pathForFile("archivos/caramelos.txt")
   local file2 = io.open(path2, "r")
   if file2 then
      contCan = file2:read( "*a" )
      io.close( file2 )
   end
   contCan = tonumber(contCan) 
   contCan = contCan + contCaramelos
   file2 = io.open(path2, "w")
   file2:write(contCan)
   
   CaramelosText:removeSelf()
   metros:removeSelf()
   timer.cancel(timerCrearEnemigoBomba) 
   timer.cancel(timerCorazones)
   timer.cancel(timerMovimientoConstante)
   timer.cancel(timerChupetas)
   timer.cancel(timerquitarInvulnerabilidad)
   timer.cancel(timercontarInv)
   timer.cancel(timerrandomCandy)
   timer.cancel(timercrearenemigo)
   timer.cancel(timercrearCamilla)
   timer.cancel(timerBoss)
   timer.cancel(timerSalto)
   timer.cancel(timerPisoTecho)
   timer.cancel(timerBajar)
   timer.cancel(timerMoverPersonaje)
   timer.cancel(timervalidarLimitesPantalla)
   timer.cancel(timerDistancia)
   timer.cancel(timerAcelerador) 
   gameover.inicio(muteSound, contDistancia, cont)
end
------------------------------------------------------------------------
--funciones de remover objetos.
function removeCambio1()
   piso:removeSelf()
   piso2:removeSelf()
   hospital:removeSelf()
   hospital2:removeSelf()
   fondoHospital:removeSelf()
   fondoHospital2:removeSelf()
end
function removeCambio2()
   street:removeSelf()
   street2:removeSelf()
   cambioHC:removeSelf()
end
function removeCambio3()
   pisoB1:removeSelf()
   pisoB2:removeSelf()
   bosque:removeSelf()
   bosque2:removeSelf()
   cambioCB:removeSelf()
end
------------------------------------------------------------------------
end

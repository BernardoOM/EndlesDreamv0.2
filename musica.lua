module(..., package.seeall)
SaltoSound = audio.loadSound("music/salto.wav")
GameoverSound = audio.loadSound("music/gameover.wav")
HitSound = audio.loadSound("music/golpe.wav")
compra = audio.loadSound("music/compra.wav")
function inicio(Sonido, mute)
   if Sonido == "salto" and mute == true then
      audio.play( SaltoSound )
   end
   if Sonido == "gameover" and mute == true then
      audio.play( GameoverSound )
   end
   if Sonido == "hit" and mute == true then
      audio.play( HitSound )
   end
   if Sonido == "compra" and mute == true then
      audio.play( compra )
   end
   if Sonido == "musicaMenu" and mute == true then
      --media.playSound( "music/menumusic.wav" )
   end
   if Sonido == "musicaJuego" and mute == true then
      --media.playSound( "music/gamemusic.wav" )
   end
   if Sonido == "musicaTienda" and mute == true then
     -- media.playSound( "music/shopmusic.wav" )
   end
   if Sonido == "die" and mute == true then
      --media.playSound( "music/die.wav" )
   end
   if Sonido == "pausa" and mute == true then
      --media.playSound( "music/pausa.wav" )
   end
end

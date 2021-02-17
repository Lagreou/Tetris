// Contient les fonctions gérant les actions que
// l'utilisateur fait dans menu (et notamment
// l'enregistrement des actions dans le fichier)

// Fonction qui détecte le clic sur une des barres
// de son.
// Renvoi l'image sur lequel l'utilisateur a cliquer
function detectClicOnSoundImage()
	
	spriteClickedOnId as integer
	
	if(isClickedOnSprite(optionInterface.spriteMusicJauge))
		spriteClickedOnId = optionInterface.spriteMusicJauge
	endif
	
	if(isClickedOnSprite(optionInterface.spriteSoundJauge))
		spriteClickedOnId = optionInterface.spriteSoundJauge
	endif

endfunction spriteClickedOnId

// Retourne les coordonnées dont on a besoin
// (souris, images de son et musique...)
function returnMouseCoord()
	coord as float[1]
	
	coord[0] = getRawMouseX()
	coord[1] = getRawMouseY()
endfunction coord

// Permet d'avoir les coordonnées min et max
// d'un sprite que l'on veux
function returnMinMaxSprite(sprite as integer)	
	tabMinMax as float[3]
	
	tabMinMax[0] = GetSpriteX(sprite)
	tabMinMax[1] = getSpriteX(sprite) + GetSpriteWidth(sprite)
	
	tabMinMax[2] = GetSpriteY(sprite)
	tabMinMax[3] = getSpriteY(sprite) + GetSpriteHeight(sprite)
endfunction tabMinMax

// Regarde si l'utilisateur a bien cliquer sur l'image
// fourni en paramètre (retourne 0 si non, 1 si oui)
function isClickedOnSprite(sprite as integer)
	isOnSprite as integer = 0
	isOnSpriteX as integer = 0
	isOnSpriteY as integer = 0
	mousePress as integer
	// 0 et 1 : x et y souris
	tabMouseCoor as float[1]
	
	tabMinMaxSprite as float[3]

	tabMinMaxSprite = returnMinMaxSprite(sprite)
	
	// On regarde si correspond aux coordonnées du sprite
	// de la barre de musique
	mousePress = GetRawMouseLeftPressed()
	
	if(mousePress)
		// Obtention des coordonnées de la sourics
		tabMouseCoor = returnMouseCoord()
		
		if (tabMouseCoor[0] >= tabMinMaxSprite[0] and tabMouseCoor[0] <= tabMinMaxSprite[1])
			isOnSpriteX = 1
		endif
		
		if (tabMouseCoor[1] >= tabMinMaxSprite[2] and tabMouseCoor[1] <= tabMinMaxSprite[3])
			isOnSpriteY = 1
		endif
	endif
	
	if (isOnSpriteX and isOnSpriteY)
		isOnSprite = 1
	else
		isOnSprite = 0
	endif
	
endfunction isOnSprite

// Permet de bouger la jauge passée en paramètre
// quand l'utilisateur bouge la souris
// Le scaleInit permet de donner la taille initiale
// retourne le nouveau scale de jauge
function moveJauge(sprite as integer, defaultScale as float)
	// Coordonnées de la souris au moment
	// du clic
	tabMouseX as float
	scaleJauge as float
	
	scaleJauge = defaultScale
	if(GetRawMouseLeftPressed())
		tabMouseX = getRawMouseX()
			
		while(GetRawMouseLeftState())
			// On actualise les coordonnées quand la souris bouge
			if(getRawMouseX() < tabMouseX and scaleJauge > 0)
				scaleJauge = scaleJauge - ((tabMouseX - getRawMouseX()) / 1000)
				SetSpriteScale(sprite, scaleJauge, 1)
			endif
			if(getRawMouseX() > tabMouseX and scaleJauge < 1)
				scaleJauge = scaleJauge + ((tabMouseX + getRawMouseX()) / 10000)
				SetSpriteScale(sprite, scaleJauge, 1)
			endif
			sync()
		endwhile
	endif
endfunction scaleJauge

// On regarde si on clique sur le bouton exit
function isPressedOnExitOption()
	clicOk as integer = 0
	
	if GetVirtualButtonPressed(optionInterface.exitButton)
		clicOk = 1
	endif
endfunction clicOk

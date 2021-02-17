// Contient tout ce qui touche au graphisme du menu
// d'option

// ===============================================
// ================= TYPES =======================
//================================================

type GraphicsOption
	// Image de la déco de barre de volume pour la musique
	imageMusicBar as integer
	
	// Image de la déco de barre de volume pour les bruitages
	imageSoundBar as integer
	
	// Image de la véritable jauge que le joueur fera bouger afin
	// de régler le son
	imageMusicAndSoundJauge as integer
	
	// Sprite de la déco de barre de volume pour la musique
	spriteMusicBar as integer
	
	// Sprite de la déco de barre de volume pour les bruitages
	spriteSoundBar as integer
	
	// Sprite de la véritable jauge que le joueur fera bouger afin
	// de régler le son
	spriteMusicJauge as integer
	
	spriteSoundJauge as integer
	
	// Image du bouton virtuel exit
	imageExitButton as integer
	
	// VirtualButton : bouton permettant de sortir
	exitButton as integer
endType


// ===============================================
// ================= VARIABLES GLOBALES ==========
//================================================

// Représente l'interface du menu option
global optionInterface as GraphicsOption


// ================================================
// ================== FONCTIONS ===================
// ================================================

function loadInterfaceGraphicsOptions()
	
	// On charge les images
	loadImageOptions()
	
	// On créer les sprites
	initialiserSprites()
	
	// On place les sprites
	placedSpritesOption()
endfunction

// Charge les images de l'interface en mémoire
function loadImageOptions()
	// On charge l'image de la barre de musique
	optionInterface.imageMusicBar = LoadImage("musicVolumeImage.png")
	
	// On charge l'image de la barre de son
	optionInterface.imageSoundBar = LoadImage("soundVolumeImage.png")
	
	// On charge la jauge
	optionInterface.imageMusicAndSoundJauge = LoadImage("jauge.png")
	
	
endfunction

// Permet de charger les boutons et de les placés
function loadVirtualButtonOptions()
	optionInterface.exitButton = 1
	optionInterface.imageExitButton = LoadImage("ExitButton.png")
	
	AddVirtualButton(optionInterface.exitButton,52,80,5)
	SetVirtualButtonSize(optionInterface.exitButton, pixelToPercentWidth(GetImageWidth(optionInterface.imageExitButton)),-1)
	SetVirtualButtonImageUp(optionInterface.exitButton, optionInterface.imageExitButton)
	SetVirtualButtonImageDown(optionInterface.exitButton, optionInterface.imageExitButton)
endfunction

// Initialiser les sprites (création)
function initialiserSprites()
	// On charge l'image de la barre de musique
	optionInterface.spriteMusicBar = CreateSprite(optionInterface.imageMusicBar)
	
	// On charge l'image de la barre de son
	optionInterface.spriteSoundBar = CreateSprite(optionInterface.imageSoundBar)
	
	// On charge les jauge
	optionInterface.spriteMusicJauge = CreateSprite(optionInterface.imageMusicAndSoundJauge)
	optionInterface.spriteSoundJauge = CreateSprite(optionInterface.imageMusicAndSoundJauge)
endfunction

// Placement des sprites (taille + position)
function placedSpritesOption()
	
	placedSpriteBars()
	placedJauge()
	loadVirtualButtonOptions()
endfunction

// Placement des sprites de description
// (musique, son...)
function placedSpriteBars()
	// hauteur du sprite
	heightSprite as float
	
	heightSprite = pixelToPercentHeight(GetImageHeight(optionInterface.imageMusicBar))
	SetSpriteSize(optionInterface.spriteMusicBar, -1, heightSprite)
	SetSpritePosition(optionInterface.spriteMusicBar, 40, 30)
	
	heightSprite = pixelToPercentHeight(GetImageHeight(optionInterface.imageSoundBar))
	SetSpriteSize(optionInterface.spriteSoundBar, -1, heightSprite)
	SetSpritePosition(optionInterface.spriteSoundBar, 40, 50)
endfunction

// Placement des sprites des jauges
function placedJauge()
	// hauteur du sprite
	heightSprite as float
	
	coorXSprite as float
	
	coorYSprite as float
	
	scale as float
	
	// Sprite de la jauge de musique
	heightSprite = pixelToPercentHeight(GetImageHeight(optionInterface.imageMusicAndSoundJauge))
	
	coorXSprite = GetSpriteX(optionInterface.spriteMusicBar) + 3.4
	coorYSprite = GetSpriteY(optionInterface.spriteMusicBar) + 6.7
	
	SetSpriteSize(optionInterface.spriteMusicJauge, -1, heightSprite)
	SetSpritePosition(optionInterface.spriteMusicJauge, coorXSprite, coorYSprite)
	// On règle le scale avec le volume présent dans le fichier
	scale = volumeMusic / 100
	SetSpriteScale(optionInterface.spriteMusicJauge, scale, 1)
	
	// Sprite de la jauge de son
	coorXSprite = GetSpriteX(optionInterface.spriteSoundBar) + 3.4
	coorYSprite = GetSpriteY(optionInterface.spriteSoundBar) + 6.7
	
	SetSpriteSize(optionInterface.spriteSoundJauge, -1, heightSprite)
	SetSpritePosition(optionInterface.spriteSoundJauge, coorXSprite, coorYSprite)
	// On règle le scale avec le volume présent dans le fichier
	scale = volumeSound / 100
	SetSpriteScale(optionInterface.spriteSoundJauge, scale, 1)
endfunction

// Déchargement des sprites, images et boutons
function unloadAllImagesOption()
	unloadButtonsOptions()
	
	DeleteSprite(optionInterface.spriteMusicBar)
	DeleteSprite(optionInterface.spriteMusicJauge)
	DeleteSprite(optionInterface.spriteSoundBar)
	DeleteSprite(optionInterface.spriteSoundJauge)
	
	DeleteImage(optionInterface.imageMusicAndSoundJauge)
	DeleteImage(optionInterface.imageMusicBar)
	DeleteImage(optionInterface.imageSoundBar)
endfunction

// Permet de décharger les boutons virtuels
function unloadButtonsOptions()
	DeleteImage(optionInterface.imageExitButton)
	
	DeleteVirtualButton(optionInterface.exitButton)
endfunction

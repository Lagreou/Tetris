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
endType


// ===============================================
// ================= VARIABLES GLOBALES ==========
//================================================

// Représente l'interface du menu option
global optionInterface as GraphicsOption


// ================================================
// ================== FONCTIONS ===================
// ================================================

function chargerInterfaceGraphicsOptions()
	
	// On charge les images
	chargerImageOptions()
	
	// On créer les sprites
	initialiserSprites()
	
	// On place les sprites
	placedSpritesOption()
endfunction

// Charge les images de l'interface en mémoire
function chargerImageOptions()
	// On charge l'image de la barre de musique
	optionInterface.imageMusicBar = LoadImage("musicVolumeImage.png")
	
	// On charge l'image de la barre de son
	optionInterface.imageSoundBar = LoadImage("soundVolumeImage.png")
	
	// On charge la jauge
	optionInterface.imageMusicAndSoundJauge = LoadImage("jauge.png")
endfunction

// Initialiser les sprites (création)
function initialiserSprites()
	// On charge l'image de la barre de musique
	optionInterface.spriteMusicBar = CreateSprite(optionInterface.imageMusicBar)
	
	// On charge l'image de la barre de son
	optionInterface.spriteSoundBar = CreateSprite(optionInterface.imageSoundBar)
	
	// On charge la jauge
	//~ optionInterface.spriteMusicJauge = CreateSprite(optionInterface.imageMusicAndSoundJauge)
	//~ 
	//~ optionInterface.spriteSoundJauge = CreateSprite(optionInterface.imageMusicAndSoundJauge)
endfunction

// Placement des sprites (taille + position)
function placedSpritesOption()
	
	// largeur du sprite
	widthSprite as float
	
	// hauteur du sprite
	heightSprite as float
	
	heightSprite = pixelToPercentHeight(GetImageHeight(optionInterface.imageMusicBar))
	SetSpriteSize(optionInterface.spriteMusicBar, -1, heightSprite)
	SetSpritePosition(optionInterface.spriteMusicBar, 40, 30)
	
	heightSprite = pixelToPercentHeight(GetImageHeight(optionInterface.imageSoundBar))
	SetSpriteSize(optionInterface.spriteSoundBar, -1, heightSprite)
	SetSpritePosition(optionInterface.spriteSoundBar, 40, 50)
	
	//~ heightSprite = pixelToPercentHeight(GetImageHeight(optionInterface.imageMusicAndSoundJauge))
	//~ SetSpriteSize(optionInterface.spriteMusicJauge, )
	//~ SetSpriteSize(optionInterface.spriteSoundBar, -1, heightSprite)
	
endfunction

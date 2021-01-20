// ===============================================
// ================= VARIABLES ===================
//================================================

global downloadLabel as integer
global textChargement as integer
global chargingSprite as integer

// ===============================================
// ================= FONCTIONS ===================
//================================================

// Permet d'afficher l'écran de chargement
function afficherChargement()
	
	// On decharge la musique de l'accueil
	dechargerMusiqueAccueil()
	
	// On decharge l'ecran d'accueil
	dechargerSpritesAccueil()
	
	imageLoading = LoadImage("loading2.gif")
	chargingSprite = CreateSprite(imageLoading)
	SetSpriteDepth(chargingSprite, 40)
	SetSpriteSize(chargingSprite, pixelToPercentWidth(GetImageWidth(imageLoading)), -1)
	SetSpritePosition(chargingSprite, 40, 30)
	
	// Ici, on "force" la synchronisation
	// sinon l'écran bug
	sync()
endfunction

// Permet d'effacer l'écran de chargement
function effacerEcranChargement()
	// On supprime l'image pour le chargement
	DeleteSprite(chargingSprite)
	DeleteImage(imageLoading)
endfunction

// ===============================================
// ================= VARIABLES ===================
//================================================

// représente l'image de chargement
global imageLoading as integer
global downloadLabel as integer

global chargingSprite as integer

// ===============================================
// ================= FONCTIONS ===================
//================================================

// Permet d'afficher l'écran de chargement
function displayDownloading()
	
	// On decharge la musique de l'accueil
	unloadSplashScreenMusic()
	
	// On decharge l'ecran d'accueil
	unloadSplashScreen()
	
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
function deleteDownloadingScreen()
	// On supprime l'image pour le chargement
	DeleteSprite(chargingSprite)
	DeleteImage(imageLoading)
endfunction

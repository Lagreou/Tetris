// ===============================================
// ================= TYPES =======================
//================================================
type GraphicsMenu
	// image arrière accueil
	imageAccueil as integer
	
	// Contient le sprite d'accueil
	spriteAccueil  as integer 
	
	// VirtualButton : bouton de jeu
	playButton as integer
	
	// VirtualButton : bouton d'option
	optionsButton as integer
	
	// VirtualButton : bouton permettant de sortir
	exitButton as integer
	
	// Image du bouton virtuel option
	imageOptionButton as integer
	
	// Image du bouton virtuel play
	imagePlayButton as integer
	
	// Image du bouton virtuel exit
	imageExitButton as integer
endtype

// ===============================================
// ================= VARIABLES GLOBALES ==========
//================================================

global menuInterface as GraphicsMenu

// ===============================================
// ================= FONCTIONS ===================
//================================================

// Affiche l'écran d'accueil et démarre la musique
// d'écran d'accueil
function afficherAccueil()
	// On charge l'écran d'accueil
	chargerSpriteAccueil()
	
	// On charge les boutons de l'accueil
	chargedAndPositionedBoutonsMenu()
endfunction

function chargerSpriteAccueil()
	accueilLargeur as integer
	
	chargerImageAccueil()
	menuInterface.spriteAccueil = CreateSprite(menuInterface.imageAccueil)
	
	// Obtention de la taille du sprite
	accueilLargeur = GetSpriteWidth(menuInterface.spriteAccueil)
	
	// Le -1 sert à garder l'échelle d'origine par rapport à la largeur
	SetSpriteSize(menuInterface.spriteAccueil,100,-1)
endfunction

function chargedAndPositionedBoutonsMenu()
	menuInterface.playButton = 1
	
	menuInterface.optionsButton = 2
	
	menuInterface.exitButton = 3
	
	menuInterface.imageOptionButton = LoadImage("OptionsButton.png")
	menuInterface.imageExitButton = LoadImage("ExitButton.png")
	menuInterface.imagePlayButton = LoadImage("StartPlayingButton.png")
	
	AddVirtualButton(menuInterface.playButton,49,60,5)
	SetVirtualButtonSize(menuInterface.playButton, pixelToPercentWidth(GetImageWidth(menuInterface.imagePlayButton)),-1)
	SetVirtualButtonImageUp(menuInterface.playButton, menuInterface.imagePlayButton)
	SetVirtualButtonImageDown(menuInterface.playButton, menuInterface.imagePlayButton)
	
	AddVirtualButton(menuInterface.optionsButton,49,70,5)
	SetVirtualButtonSize(menuInterface.optionsButton, pixelToPercentWidth(GetImageWidth(menuInterface.imageOptionButton)),-1)
	SetVirtualButtonImageUp(menuInterface.optionsButton, menuInterface.imageOptionButton)
	SetVirtualButtonImageDown(menuInterface.optionsButton, menuInterface.imageOptionButton)
	
	AddVirtualButton(menuInterface.exitButton,49,80,5)
	SetVirtualButtonSize(menuInterface.exitButton, pixelToPercentWidth(GetImageWidth(menuInterface.imageExitButton)),-1)
	SetVirtualButtonImageUp(menuInterface.exitButton, menuInterface.imageExitButton)
	SetVirtualButtonImageDown(menuInterface.exitButton, menuInterface.imageExitButton)
endfunction

function dechargerButtonsMenu()
	DeleteImage(menuInterface.imageOptionButton)
	DeleteImage(menuInterface.imageExitButton)
	DeleteImage(menuInterface.imagePlayButton )
	
	DeleteVirtualButton(menuInterface.playButton)
	DeleteVirtualButton(menuInterface.optionsButton)
	DeleteVirtualButton(menuInterface.exitButton)
endfunction

function dechargerSpritesAccueil()
	DeleteSprite(menuInterface.spriteAccueil)
	DeleteImage(menuInterface.imageAccueil)
	
	DeleteImage(menuInterface.imagePlayButton)
	DeleteImage(menuInterface.imageOptionButton)
	DeleteImage(menuInterface.imageExitButton)
	
	// On supprime les boutons
	dechargerButtonsMenu()
endfunction

// Charge l'image d'accueil
function chargerImageAccueil()
	menuInterface.imageAccueil = LoadImage("splashScreen2.png")
endfunction

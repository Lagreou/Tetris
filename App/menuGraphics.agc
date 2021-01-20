// ===============================================
// ================= FONCTIONS ===================
//================================================

// Contient le sprite d'accueil
global spriteAccueil  as integer 

global playButton as integer = 1

global optionsButton as integer = 2

global exitButton as integer = 3

// Affiche l'écran d'accueil et démarre la musique
// d'écran d'accueil
function afficherAccueil()
	
	// On decharge la musique de jeu (car on peux passer
	// directement du jeu au menu
	dechargerMusiqueJeu()
	
	// On decharge l'ecran de jeu
	dechargerSpriteEtImageJeu()
	
	// On charge la musique d'accueil
	chargerMusiqueAccueil()
	
	// On charge l'écran d'accueil
	chargerSpriteAccueil()
	
	// On charge les boutons de l'accueil
	positionnerBoutons()
endfunction

function chargerSpriteAccueil()
	accueilLargeur as integer
	
	chargerImageAccueil()
	spriteAccueil = CreateSprite(imageAccueil)
	
	// Obtention de la taille du sprite
	accueilLargeur = GetSpriteWidth(spriteAccueil)
	
	// Le -1 sert à garder l'échelle d'origine par rapport à la largeur
	SetSpriteSize(spriteAccueil,100,-1)
endfunction

function positionnerBoutons()
	imageOptionButton = LoadImage("OptionsButton.png")
	imageExitButton = LoadImage("ExitButton.png")
	imagePlayButton = LoadImage("StartPlayingButton.png")
	
	AddVirtualButton(playButton,49,60,5)
	SetVirtualButtonSize(playButton, pixelToPercentWidth(GetImageWidth(imagePlayButton)),-1)
	SetVirtualButtonImageUp(playButton, imagePlayButton)
	SetVirtualButtonImageDown(playButton, imagePlayButton)
	
	AddVirtualButton(optionsButton,49,70,5)
	SetVirtualButtonSize(optionsButton, pixelToPercentWidth(GetImageWidth(imageOptionButton)),-1)
	SetVirtualButtonImageUp(optionsButton, imageOptionButton)
	SetVirtualButtonImageDown(optionsButton, imageOptionButton)
	
	AddVirtualButton(exitButton,49,80,5)
	SetVirtualButtonSize(exitButton, pixelToPercentWidth(GetImageWidth(imageExitButton)),-1)
	SetVirtualButtonImageUp(exitButton, imageExitButton)
	SetVirtualButtonImageDown(exitButton, imageExitButton)
endfunction

function dechargerButtons()
	DeleteImage(imageOptionButton)
	DeleteImage(imageExitButton)
	DeleteImage(imagePlayButton )
	
	DeleteVirtualButton(playButton)
	DeleteVirtualButton(optionsButton)
	DeleteVirtualButton(exitButton)
endfunction

function dechargerSpritesAccueil()
	DeleteSprite(spriteAccueil)
	DeleteImage(imageAccueil)
	
	DeleteImage(imagePlayButton)
	DeleteImage(imageOptionButton)
	DeleteImage(imageExitButton)
	
	// On supprime les boutons
	dechargerButtons()
endfunction

// Charge l'image d'accueil
function chargerImageAccueil()
	imageAccueil = LoadImage("splashScreen2.png")
endfunction

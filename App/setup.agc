/*
 Fichier regroupant les fonctions / variable globales concernant les médias
 (image de décors, musique...) du jeu
 Permet également de gérer ces derniers
*/
global imageAccueil as integer
global spriteAccueil  as integer // Contient le sprite d'accueil
global imageBackground as integer
global spriteBackground as integer
global mainSound as integer
global gameSound as integer
global deleteLineSound as integer
global downloadLabel as integer
global textChargement as integer

// Taille de l'écran de l'utilisateur (adapté au chargement)
global xScreen as float
global yScreen as float

// Taille des blocks tetris, à adapter selon l'affichage
global tailleBlock as float
global tailleBlocPourcent as float

// FONCTIONS GERANTS LES AFFICHAGES //

function initScreen()
	yScreen = GetMaxDeviceHeight()
	xScreen = GetMaxDeviceWidth()
	
	tailleBlock = yScreen / GRID_Y
	tailleBlocPourcent = tailleBlock * 100/yScreen
endfunction

// Permet d'afficher l'écran de chargement
function afficherChargement()
	
	// On decharge la musique de l'accueil
	dechargerMusiqueAccueil()
	
	// On decharge l'ecran d'accueil
	dechargerSpriteAccueil()
				
	downloadLabel = CreateText("Chargement...")
	SetTextSize(downloadLabel, 2)
	SetTextPosition(downloadLabel, 50, 50)
	
	// Ici, on "force" la synchronisation
	// sinon l'écran bug
	sync()
endfunction

function effacerEcranChargement()
	// On supprime le texte de chargement
	DeleteText(downloadLabel)
endfunction

// Affiche l'écran d'accueil et démarre la musique
// d'écran d'accueil
function afficherAccueil()
	
	// On decharge la musique de jeu (car on peux passer
	// directement du jeu au menu
	dechargerMusiqueJeu()
	
	// On decharge l'ecran de jeu
	dechargerSpriteJeu()
	
	// On charge la musique d'accueil
	chargerMusiqueAccueil()
	
	// On charge l'écran d'accueil
	chargerSpriteAccueil()
endfunction

// Affiche l'écran de jeu et démarre la musique
// de jeu
function afficherArrierePlanJeu()
	// On charge la musique du jeu
	chargerMusiqueJeu()
	
	// On charge l'écran du jeu
	chargerSpriteJeu()
endfunction

// ------------- FONCTIONS SIMPLES PERMETTANTS LE CHARGEMENT / DECHARGEMENT DES DIVERSES RESSOURCES --------------- //

function chargerSpriteAccueil()
	accueilLargeur as integer
	
	imageAccueil = LoadImage("splashScreen.png")
	spriteAccueil = CreateSprite(imageAccueil)
	
	// Obtention de la taille du sprite
	accueilLargeur = GetSpriteWidth(spriteAccueil)
	
	// Le -1 sert à garder l'échelle d'origine par rapport à la largeur
	SetSpriteSize(spriteAccueil,100,-1)
endfunction

function chargerSpriteJeu()
	jeuLargeur as integer
	
	imageBackground = LoadImage("background2.gif")
	spriteBackground = CreateSprite(imageBackground)
	
	// Obtention de la taille du sprite
	jeuLargeur = GetSpriteWidth(spriteBackground)
	
	// Le -1 sert à garder l'échelle d'origine par rapport à la largeur
	SetSpriteSize(spriteBackground,100,-1)
endfunction

function dechargerSpriteAccueil()
	DeleteSprite(spriteAccueil)
	DeleteImage(imageAccueil)
endfunction

function dechargerSpriteJeu()
	DeleteSprite(spriteBackground)
	DeleteImage(imageBackground)
endfunction

function chargerMusiqueAccueil()
	// Chargement de la musique d'accueil
	mainSound = LoadSoundOGG("Jaunter-Reset.ogg")
	playSound(mainSound,50,1)
endfunction

function chargerMusiqueJeu()
	// Chargement de la musique du jeu
	gameSound = LoadSoundOGG("Kubbi-Ember-04Cascade.ogg")
	playSound(gameSound,50,1)
	
	// Chargement des sons pour le jeu
	deleteLineSound = LoadSound("line.wav")
endfunction

function dechargerMusiqueAccueil()
	// dechargement de la musique d'accueil
	DeleteSound(mainSound)
endfunction

function dechargerMusiqueJeu()
	// dechargement de la musique du jeu
	DeleteSound(gameSound)
endfunction

/*
 Fichier regroupant les fonctions / variable globales concernant les médias
 (image de décors, musique...) du jeu
*/

// =============================================================== //
// ================ VARIABLES GLOBALES ========================== //
// ============================================================== //

// ============== FICHIERS GRAPHIQUES (IMAGES) =================//
//============================================================= //
global imageAccueil as integer
global imageBackground as integer

// ============== FICHIERS SONS (MUSIQUES, BRUITAGES...) =================//
//====================================================================== //
global mainSound as integer
global gameSound as integer
global deleteLineSound as integer

// ============== VARIABLES POUR L'ECRAN UTILISATEUR ==================== //
//====================================================================== //
// Taille de l'écran de l'utilisateur (adapté au chargement)
global xScreen as float
global yScreen as float


// =================================================================== //
// ================ FIN VARIABLES GLOBALES ========================== //
// ================================================================ //


// FONCTION D'INITIALISATION D'ECRAN
function initDisplay()
	
// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "Falling Blocks" )

// On récupère les coordonnées de l'écran
yScreen = GetMaxDeviceHeight()
xScreen = GetMaxDeviceWidth()


// On définit la taille de l'écran
SetWindowSize(xScreen, yScreen, 1)

// set display properties
SetDisplayAspect(xScreen/yScreen)
SetOrientationAllowed( 1, 0, 0, 0 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 60, 0 )
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts

endfunction

// Charge l'image d'accueil
function chargerImageAccueil()
	imageAccueil = LoadImage("splashScreen2.png")
endfunction

// Décharge l'image d'accueil
function dechargerImageAccueil()
	DeleteImage(imageAccueil)
endfunction

/* =================================================
					MUSIQUES / SONS
===================================================*/

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

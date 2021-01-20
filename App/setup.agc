/*
 Fichier regroupant les fonctions / variable globales concernant les médias
 (image de décors, musique...) du jeu
*/

// =============================================================== //
// ================ VARIABLES GLOBALES ========================== //
// ============================================================== //

// ============== FICHIERS GRAPHIQUES (IMAGES) =================//
//============================================================= //

// image arrière accueil
global imageAccueil as integer

// Image arrière jeu
global imageBackground as integer

// représente l'image de chargement
global imageLoading as integer

global imageOptionButton as integer

global imagePlayButton as integer

global imageExitButton as integer

// ============== IMAGE DES DIFFERENTES FIGURES DANS LE CADRE NEXT =======//
//=========================================================================

global tabImageNextFigure as integer[7]

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
global xSpace as float

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

initXSpace()

endfunction

// Permet d'initialiser l'espace entre les blocs selon
// le format d'écran
function initXSpace()

	// Définition de l'espace entre les blocks (espace horizontal) suivant
	// le format d'écran
	
	// ============================================================== //
	// =============== FORMAT 16/9 ================================== //
	//============================================================== //           
	if( xScreen/16 = yScreen/9)
		xSpace = 2.55
	endif
	
	
	// ============================================================== //
	// =============== FORMAT 4/3 ================================== //
	//============================================================== //   
	if( xScreen/4 = yScreen/3)
		xSpace = 3.8
	endif
	
	
	// ============================================================== //
	// ==================== INTEGRATION VERSION MOBILE ============== //
	// ============================================================== //
	
	// ============================================================== //
	// =============== FORMAT 9/19.5 ================================== //
	//============================================================== //  
	
	if( xScreen/9  = yScreen/19.5)
		xSpace = 9.8
	endif
endfunction

/* =================================================
					MUSIQUES / SONS
===================================================*/

function chargerMusiqueAccueil()
	// Chargement de la musique d'accueil
	mainSound = LoadSoundOGG("Jaunter-Reset.ogg")
	//~ playSound(mainSound,50,1)
endfunction

function chargerMusiqueJeu()
	// Chargement de la musique du jeu
	gameSound = LoadSoundOGG("Kubbi-Ember-04Cascade.ogg")
	//~ playSound(gameSound,50,1)
	
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

/* =================================================
					FONCTIONS GENERALES
===================================================*/
function percentToPixelWidth(percent as float)
	width as float
	width = GetDeviceWidth() / 100.0 * percent
	
endfunction width

function percentToPixelHeight(percent as float)
	height as float	
	height = GetDeviceHeight() / 100.0 * percent
	
endfunction height


function pixelToPercentWidth(pixel as float)
	width as float
	width = 100.0 / GetDeviceWidth() * pixel
	
endfunction width

function pixelToPercentHeight(pixel as float)
	height as float
	height = 100.0 / GetDeviceHeight() * pixel
	
endfunction height

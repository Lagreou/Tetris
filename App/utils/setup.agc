/*
 Fichier regroupant les fonctions / variable globales concernant les médias
 (image de décors, musique...) du jeu
*/

// =============================================================== //
// ================ VARIABLES GLOBALES ========================== //
// ============================================================== //

// ============== VARIABLES POUR L'ECRAN UTILISATEUR ==================== //
//====================================================================== //
// Taille de l'écran de l'utilisateur (adapté au chargement)
global xScreen as float
global yScreen as float
global deviceRunOn as string
global displayFile as integer

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

	// On regarde sur quel machine on execute
	// et on charge le fichier adéquat pour les résolutions
	chargingDeviceDisplayFile()
		
	// On ferme le fichier
	CloseFile(displayFile)
endfunction

// Permet d'enregistrer le niveau sonore de la musique dans le fichier
function recordMusicAndSoundVolume(musicVolume as integer, soundVolume as integer)
	file as integer
	
	file = OpenToWrite("files/volume.datt",0)
	WriteLine(file,"#MUSIC")
	WriteLine(file,str(musicVolume))
		
	WriteLine(file,"#SOUND")
	WriteLine(file,str(soundVolume))
	
	CloseFile(file)		

endfunction

// On charge les volumes stockées dans le fichier
function chargedMusicAndSoundVolume()
	file as integer
	
	if(GetFileExists("files/volume.datt"))
		
		file = OpenToRead("files/volume.datt")
		
		while(not FileEOF(file))
			if(ReadLine(file) = "#MUSIC")
				volumeMusic = val(ReadLine(file))
			endif
			if(ReadLine(file) = "#SOUND")
				volumeSound = val(ReadLine(file))
			endif
		endwhile
		CloseFile(file)
	else
		// Chargement par défaut
		volumeMusic = 100
		volumeSound = 100
	endif
endfunction

/* =================================================
					FONCTIONS GENERALES
===================================================*/

// Permet de passer d'un système de % vers px pour
// la largeur de l'écran
function percentToPixelWidth(percent as float)
	width as float
	width = GetDeviceWidth() / 100.0 * percent
	
endfunction width

// Permet de passer d'un système de % vers px pour
// la hauteur de l'écran
function percentToPixelHeight(percent as float)
	height as float	
	height = GetDeviceHeight() / 100.0 * percent
	
endfunction height

// Permet de passer d'un système de px vers % pour
// la largeur de l'écran
function pixelToPercentWidth(pixel as float)
	width as float
	width = 100.0 / GetDeviceWidth() * pixel
	
endfunction width

// Permet de passer d'un système de px vers % pour
// la hauteur de l'écran
function pixelToPercentHeight(pixel as float)
	height as float
	height = 100.0 / GetDeviceHeight() * pixel
	
endfunction height

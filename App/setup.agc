/*
 Fichier regroupant les fonctions / variable globales concernant les médias
 (image de décors, musique...) du jeu
*/

// =============================================================== //
// ================ VARIABLES GLOBALES ========================== //
// ============================================================== //

// ============== FICHIERS SONS (MUSIQUES, BRUITAGES...) =================//
//====================================================================== //
global mainMusic as integer
global gameMusic as integer
global deleteLineSound as integer

// Volume de la musique
global volumeMusic as float

// Volume du son
global volumeSound as float
// ============== VARIABLES POUR L'ECRAN UTILISATEUR ==================== //
//====================================================================== //
// Taille de l'écran de l'utilisateur (adapté au chargement)
global xScreen as float
global yScreen as float
global xSpace as float
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
initXSpace()

endfunction


/* =================================================
					MUSIQUES / SONS
===================================================*/

function chargerMusiqueAccueil()
	// Chargement de la musique d'accueil
	mainMusic = LoadMusicOGG("Jaunter-Reset.ogg")
	PlayMusicOGG(mainMusic,1)
	SetMusicVolumeOGG(mainMusic, volumeMusic)
endfunction

function chargerMusiqueJeu()
	// Chargement de la musique du jeu
	gameMusic = LoadMusicOGG("Kubbi-Ember-04Cascade.ogg")
	PlayMusicOGG(gameMusic,1)
	SetMusicVolumeOGG(gameMusic, volumeMusic)
	// Chargement des sons pour le jeu
	deleteLineSound = LoadSound("line.wav")
endfunction

function dechargerMusiqueAccueil()
	// dechargement de la musique d'accueil
	DeleteMusicOGG(mainMusic)
endfunction

function dechargerMusiqueJeu()
	// dechargement de la musique du jeu
	DeleteMusicOGG(gameMusic)
endfunction

/* =================================================
					FONCTIONS FICHIERS
===================================================*/

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

function chargingDeviceDisplayFile()
	deviceName as string
	
	deviceName = GetDeviceName()
	
	select deviceName
		
		case "android"
			displayFile = OpenToRead("readingFiles/androidDisplay.datagames")
		endcase
		
		case "windows"
			displayFile = OpenToRead("readingFiles/windowsDisplay.datagames")
		endcase
	
	endselect
	
	// fonction de chargement des différentes valeurs
	initXSpace()
endfunction

// Permet d'initialiser l'espace entre les blocs selon
// le format d'écran
function initXSpace()
	
	// Représente la ligne courante
	currentLine as string
 
	while(FileEOF(displayFile))
		currentLine = ReadLine(displayFile)
		
		if(currentLine = "X_SPACE")
			// On parcours les diverses résolutions jusqu'à la fin de la catégorie
			xSpace = getValueWithCategorieParcour("X_SPACE")
		endif
	// Définition de l'espace entre les blocks (espace horizontal) suivant
	// le format d'écran
	endwhile
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

// Parcours des résolution d'affichage jusqu'à la fin
// de la catégorie entrée en paramètre.
// La valeur de la variable est retournée lorsque trouvée
function getValueWithCategorieParcour(categorie as string)
	currentLine as string
	obtaindValue as float
	
	repeat
		currentLine = ReadLine(displayFile)
		
		// On regarde si la valeur correspond à une resolution
		if(Left(currentLine, 2) = "~~")
			// si ok => on récupère et on regarde si correspond avec actuelle
			// si correspond avec actuelle => on récupère la valeur
		endif
	until(not isCategorieEnding(currentLine))
endfunction obtaindValue

// Permet de regarder si on arrive à la fin d'une
// catégorie dans le fichier
function isCategorieEnding(line as string)
	result as integer = 0
	
	if(Left(line,1) = "#")
		result = 1
	endif
	
endfunction result

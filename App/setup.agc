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
// et on charge le fichier adéquat pour les résolutions
chargingDeviceDisplayFile()

// Chargement de la variable xSpace
initTargetValue("#X_SPACE")
	
// On ferme le fichier
CloseFile(displayFile)
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

// Charger le bon fichier contenant les résolutions selon
// l'appareil sur lequel le jeu est chargé
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
endfunction

// Permet d'initialiser la variable recherchée
function initTargetValue(targetValue as string)
	
	// Représente la ligne courante
	currentLine as string
 
	while(not FileEOF(displayFile))
		currentLine = ReadLine(displayFile)
		
		if(currentLine = targetValue)
			// On parcours les diverses résolutions jusqu'à la fin de la catégorie
			xSpace = getValueWithCategorieParcour()
		endif
	endwhile
endfunction

// Parcours des résolution d'affichage jusqu'à la fin
// de la catégorie en cours de parcours
// La valeur de la variable est retournée lorsque trouvée
function getValueWithCategorieParcour()
	currentLine as string
	obtaindValue as float
	isGoodResolution as integer
		
	repeat
		currentLine = ReadLine(displayFile)
		
		// On regarde si la valeur correspond à une resolution
		if(Left(currentLine, 2) = "~~")
			// si ok => on récupère et on regarde si correspond avec actuelle
			isGoodResolution = comparerResolutionActuelleAvecFichier(currentLine)
			// si correspond avec actuelle => on récupère la valeur
			if(isGoodResolution)
				obtaindValue = ValFloat(ReadLine(displayFile))
			endif
		endif
	until(isCategorieEnding(currentLine) or FileEOF(displayFile))
endfunction obtaindValue

// Permet de regarder si on arrive à la fin d'une
// catégorie dans le fichier
function isCategorieEnding(line as string)
	result as integer = 0
	
	if(Left(line,1) = "#")
		result = 1
	endif
	
endfunction result

// Permet de comparer la résolution sur laquelle on est
// dans le fichier (ligne passée en paramètre)
// retourne vrai si c'est la bonne résolution
function comparerResolutionActuelleAvecFichier(resolution as string)
	isOk as integer = 0
	currentLine as string
	displayValues as float[2]
	i as integer 
	
	currentLine = resolution
	
	// On regarde qu'on à bien un / (si = 0, il n'y a obligatoirement
	// pas de caractère "/", alors que oui si > 0)
	// On récupère les valeurs si ok
	if(CountStringTokens2(currentLine, "/") > 0)
		// On élimine le symbole ~~ afin qu'il ne gêne pas pour
		// la récupération de la première valeur
		// => On récupère tous les caractère de droite - les 2 premiers
		currentLine = Right(currentLine, len(currentLine) - 2)
		for i = 1 to 2 step 1
			displayValues[i] = ValFloat(GetStringToken(currentLine,"/",i))
		next i 
	endif
	
	// On compare les valeurs extraites
	// avec notre résolution
	// dans le fichier, c'est forcément l'ordre longueur / largeur
	// (le plus grand on premier), c'est pour cela qu'on regarde si
	// la largeur de l'écran est plus grande que la hauteur)
	if(xScreen > yScreen)
		if(xScreen/displayValues[1] = yScreen/displayValues[2])
			isOk = 1
		endif
	else
		if(yScreen/displayValues[1] = xScreen/displayValues[2])
			isOk = 1
		endif
	endif
	 
endfunction isOk

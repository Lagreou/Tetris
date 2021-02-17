// ============== FICHIERS SONS (MUSIQUES, BRUITAGES...) =================//
//====================================================================== //
global mainMusic as integer
global gameMusic as integer
global deleteLineSound as integer

// Volume de la musique
global volumeMusic as float

// Volume du son
global volumeSound as float

// ============== FONCTIONS =================//
//========================================= //

function loadSplashScreenMusic()
	// Chargement de la musique d'accueil
	mainMusic = LoadMusicOGG("Jaunter-Reset.ogg")
	PlayMusicOGG(mainMusic,1)
	SetMusicVolumeOGG(mainMusic, volumeMusic)
endfunction

function loadGameMusic()
	// Chargement de la musique du jeu
	gameMusic = LoadMusicOGG("Kubbi-Ember-04Cascade.ogg")
	PlayMusicOGG(gameMusic,1)
	SetMusicVolumeOGG(gameMusic, volumeMusic)
	// Chargement des sons pour le jeu
	deleteLineSound = LoadSound("line.wav")
endfunction

function unloadSplashScreenMusic()
	// dechargement de la musique d'accueil
	DeleteMusicOGG(mainMusic)
endfunction

function unloadGameMusic()
	// dechargement de la musique du jeu
	DeleteMusicOGG(gameMusic)
endfunction

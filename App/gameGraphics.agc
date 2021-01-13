// ===============================================
//================= CONSTANTES ====================
//===================================================

// Nombre de blocks dans le jeu 
#constant IMAGES_COLOR = 7

// Position du score
#constant SCORE_POSITION_X = 760
#constant SCORE_POSITION_Y = 26

// Position de la description du score
#constant SCORE_LABEL_X = 760
#constant SCORE_LABEL_Y = 1

// Position du niveau
#constant LEVEL_POSITION_X = 760
#constant LEVEL_POSITION_Y = 75

// Position de la description du niveau
#constant LEVEL_LABEL_X = 760
#constant LEVEL_LABEL_Y = 50


// ============= VERSION MOBILE ================

// Position du bouton gauche
#constant LEFT_BUTTON_X = 400
#constant LEFT_BUTTON_Y = 800

// Position du bouton droite
#constant RIGHT_BUTTON_X = 300
#constant RIGHT_BUTTON_Y = 800


// ===============================================
// ================= VARIABLES ===================
//================================================

// Taille des blocks tetris, à adapter selon l'affichage
global tailleBlock as float
global tailleBlocPourcent as float
global spriteBackground as integer

// ================================================
// ================== FONCTIONS ===================
// ================================================

// Affiche l'écran de jeu et démarre la musique
// de jeu
function afficherArrierePlanJeu()
	// On charge la musique du jeu
	chargerMusiqueJeu()
	
	// On charge l'écran du jeu
	chargerSpriteJeu()
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

function dechargerSpriteJeu()
	DeleteSprite(spriteBackground)
	DeleteImage(imageBackground)
endfunction

// ===============================================
// ================= FONCTIONS ===================
//================================================

// Contient le sprite d'accueil
global spriteAccueil  as integer 

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

function dechargerSpriteAccueil()
	DeleteSprite(spriteAccueil)
	dechargerImageAccueil()
endfunction

// Charge l'image d'accueil
function chargerImageAccueil()
	imageAccueil = LoadImage("splashScreen2.png")
endfunction

// Décharge l'image d'accueil
function dechargerImageAccueil()
	DeleteImage(imageAccueil)
endfunction

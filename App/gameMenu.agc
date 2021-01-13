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
	dechargerSpriteJeu()
	
	// On charge la musique d'accueil
	chargerMusiqueAccueil()
	
	// On charge l'écran d'accueil
	chargerSpriteAccueil()
endfunction

function chargerSpriteAccueil()
	accueilLargeur as integer
	
	imageAccueil = LoadImage("splashScreen.png")
	spriteAccueil = CreateSprite(imageAccueil)
	
	// Obtention de la taille du sprite
	accueilLargeur = GetSpriteWidth(spriteAccueil)
	
	// Le -1 sert à garder l'échelle d'origine par rapport à la largeur
	SetSpriteSize(spriteAccueil,100,-1)
endfunction

function dechargerSpriteAccueil()
	DeleteSprite(spriteAccueil)
	DeleteImage(imageAccueil)
endfunction

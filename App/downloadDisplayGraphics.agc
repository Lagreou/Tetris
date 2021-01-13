// ===============================================
// ================= VARIABLES ===================
//================================================

global downloadLabel as integer
global textChargement as integer


// ===============================================
// ================= FONCTIONS ===================
//================================================

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

// Permet d'effacer l'écran de chargement
function effacerEcranChargement()
	// On supprime le texte de chargement
	DeleteText(downloadLabel)
endfunction

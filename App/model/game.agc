/*
 Objet servant à gérer l'espace de jeu ainsi que ces divers objets
 (grille, figure, score, niveau...) 
*/

// ===============================================
// ================= TYPES =======================
//================================================
type tetrisGame
	
	// Vitesse de boucle de la partie
	speedMove as integer
	
	// Seuil des scores pour les niveaux
	scoreLimit as integer[5]
	
	// Indique si c'est l'écran d'accueil ou le jeu
	mode as integer
	
	// Figure en cours
	currentShape as TetrisShape 
	
	// Figure après celle en cours
	nextShape as TetrisShape
	
	// Grille de jeu
	dataGrid as dataGridGame
	
	// Permet de savoir si il y'a eu un mouvement
	// (Après un mouvement ou lors d'un changement de figure)
	isShapeMoved as integer   
	
	// Permet de savoir si on change de figure
	changeShape as integer 
	
	// Tableau contenant les figures possibles
	shapes as TetrisShape[7]
	
	// variable représentant le score
	score as integer
	
	// variable représentant le niveau
	level as integer
	
	// variable représentant le dernier mouvement fait
	// par le joueur
	lastMove as integer
endtype

// ================== GLOBALE ======================== //
global game as TetrisGame
// =================================================== //

function initGameDefault()
	game.scoreLimit = [0,500, 1000, 2000, 4000, 8000]
	game.level = 1
	game.speedMove = 25
	game.mode = 1
	game.isShapeMoved = 0
	game.changeShape = 0
endfunction

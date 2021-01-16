/*
 Objet servant à gérer l'espace de jeu ainsi que ces divers objets
 (grille, figure, score, niveau...) 
*/

// =============== OBJET JEU ================== //
// =============================================//
type tetrisGame
	
	// Vitesse de boucle de la partie
	speedMove as integer
	
	// Seuil des scores pour les niveaux
	scoreLimit as integer[5]
	
	mode as integer // Indique si c'est l'écran d'accueil ou le jeu

	currentShape as TetrisShape // Figure en cours
	nextShape as TetrisShape // Figure après celle en cours

	dataGrid as dataGridGame // Grille de jeu

	blocksPicture as blocksGraphics // Tableau contenant les blocs du jeu

	shapeClear as integer // Permet de savoir si il faut effacer la figure dans la grille
						  // (Après un mouvement ou lors d'un changement de figure)

	changeShape as integer // Permet de savoir si on change de figure
	
	shapes as TetrisShape[7] // Tableau contenant les figures possibles
	
	// variable représentant le score
	score as integer
	
	// variable représentant le niveau
	level as integer
endtype

function initGameDefault(game ref as TetrisGame)
	game.scoreLimit = [0,500, 1000, 2000, 4000, 8000]
	game.level = 1
	game.speedMove = 25
	game.mode = 1
	game.shapeClear = 0
	game.changeShape = 0
endfunction

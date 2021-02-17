Type States
	// Variable permettant de dire si le menu est chargé
	isAccueilCharged as integer

	// Variable permettant de dire si une partie est en cours
	// (ecran de jeu chargé)
	isGameCharged as integer

	isOptionCharged as integer

	// Permet de voir si le programme vient juste d'être lancer
	// pour le premier affichage du menu 
	isFirstGameLaunch as integer
	
	isGameOver as integer
endType

global gameStates as States

// Initialise les du jeu
function initStates()
	gameStates.isAccueilCharged = 0
	gameStates.isGameCharged = 0
	gameStates.isOptionCharged = 0
	gameStates.isGameOver = 0
	gameStates.isFirstGameLaunch = 1
endFunction

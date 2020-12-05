
// Project: TetrisLike 
// Created: 2020-07-26

// =============== INCLUSIONS =================== //

#include "tetrisShape.agc"
#include "gridGame.agc"
#include "graphicGrid.agc"
#include "checkingShape.agc"
#include "linesManagement.agc"
#include "setup.agc"
#include "input.agc"
#include "game.agc"

// Obligation de définir les types de variable
#option_explicit

// ============== INSTRUCTIONS PRINCIPALES =============== //

// ============ INITIALISATION DE L'ECRAN DE JEU (TAILLE) ============= //

// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "TetrisLike" )

// On récupère les coordonnées de l'écran
initScreen()

// On définit la taille de l'écran
SetWindowSize(xScreen, yScreen, 1)

// set display properties
SetDisplayAspect(xScreen/yScreen)
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts

// ============ DECLARATION DE LA VARIABLE DE JEU + INITIALISATION ============
game as TetrisGame

// Variable permettant de dire si le menu est chargé
isAccueilCharged as integer = 0

// Variable permettant de dire si une partie est en cours
// (ecran de jeu chargé)
isGameCharged as integer = 0

secondsInGame as integer

moveOk as integer = 0

// =============== INSTRUCTIONS POUR LE JEU ============== //

// Initialisation par défaut des paramètres de jeu :
// vitesse de jeu : tous les 25 tours
// mode : 1 (affichage de l'accueil)
// shapeClear : 0 (pas d'effacement de la figure)
// changeShape : 0 (pas de changement de figure au départ)
initGameDefault(game)


// Boucle principale du jeu
do
	// Ici, on regarde si on est dans l'écran titre ou
	// dans le jeu (mode 1 = écran titre, 2 = jeu )
	select game.mode
		case 1 :
			if isAccueilCharged
				lancerJeu(game)
			else
				afficherAccueil()
				isAccueilCharged = 1
				isGameCharged = 0
			endif
			
			// On synchronise à ce niveau car si l'utilisateur clic il faut
			// que ce soit pris dessuite en compte
			sync()
		endcase
		
		case 2 :
					
			// ============ INSTRUCTIONS EN RAPPORT AVEC LA PARTIE ========== //
			if isGameCharged
				if game.changeShape = 1
					// On regarde si le joueur a dépasser la limite :
					// GameOver dans ce cas
					if(game.dataGrid.moveShapeY = 1)
						displayGameOver(game)
					// On regarde si des lignes sont à effacées car
					// la figure a atteint le bas
					else
									
						/* ====== ANCIEN CODE POUR AVOIR UNE "ATTENTE" ======== */
							// On laisse le temps au joueur de se déplacer une dernière fois
							// secondsInGame = GetSeconds()
							//~ repeat
								//~ moveOk = keychecks(game.dataGrid, game.currentShape, game.changeShape)
								//~ 
								//~ if(moveOk = 1)
									//~ // On efface la figure si il y'a eu mouvement
									//~ game.shapeClear = moveMoveShape(game.currentShape, game.dataGrid, game.shapeClear)
									//~ // On actualise les "dessins" sur la grille
									//~ updateGrid(game.blocksPicture, game, game.xOffset, game.yOffset)
								//~ endIf
								//~ sync()							
							//~ until(GetSeconds() > secondsInGame + 0.05 or moveOk)				
						/* ========== FIN ===============*/
											
						// On regarde si des lignes sont à effacer
						effacerLignes(GRID_Y, GRID_X, game)
						
						// On regarde si la limite du score du niveau est atteinte.
						// Si oui : on augmente la difficultée
						if(game.score >= game.scoreLimit[game.level] and game.level <> 6)
							inc game.level
						endif
						
						// On réinitialise les données comme si c'était la première
						// figure
						reinitGame(game)
					endif
				else				
					// On regarde si la figure peux aller en bas (si non, on change de figure)
					game.changeShape = checkBelowShape(game.dataGrid, game.currentShape)
					
					// Le joueur presse un bouton ? on récupere la rotation qui en résulte si rotation
					// il y'a (directement dans dataGrid)
					// On récupere également le type de mouvement (1,2,3,4) selon la direction sur laquelle
					// le joueur a appuyer
					moveOk = keychecks(game.dataGrid, game.currentShape, game.changeShape)
					
					// On efface la figure si il y'a eu mouvement
					game.shapeClear = moveMoveShape(game.currentShape, game.dataGrid, game.shapeClear)
					
					// vitesse du jeu : speedMove décroit
					// chaque fois qu'un tour de boucle est fait
					// En revanche si le joueur a appuyer sur la fleche
					// du bas, on n'avance pas la pièce		
					if game.speedMove = 0 and GetRawKeyPressed(40) = 0
						inc game.dataGrid.moveShapeY
						game.speedMove = 25 - ((game.level - 1) * 5)
					endif
					
					dec game.speedMove
					
					// On actualise les "dessins" sur la grille
					updateGrid(game.blocksPicture, game, game.xOffset, game.yOffset)		
				endif	
			else				
				// Initialisation de l'écran de jeu
				initialiserJeu(game)
				
				// Ici, la partie est en cours de chargement
				// donc booléen à vrai
				isGameCharged = 1
				
				// En revanche, l'écran d'accueil n'est plus chargé
				isAccueilCharged = 0
			endif
			sync()					
		endcase
	endselect
loop

// ============== FONCTIONS ================ //

// Affichage du game over
function displayGameOver(game ref as TetrisGame)
	
	SetPhysicsWallBottom(0)
	SetPhysicsWallLeft(0)
	SetPhysicsWallRight(0)
	SetPhysicsWallTop(0)
	SetPhysicsScale(1)
	SetPhysicsGravity(0 , .2)
	count as integer = 1
	y as integer
	x as integer

	for y=1 to GRID_Y
		for x=1 to GRID_X
			setspritesize(count,tailleBlock,tailleBlock)
			SetSpritePhysicsOn(count,2)
			SetSpritePhysicsVelocity(count,random(-500,1000),random(-500,1000))
			SetSpriteShape(count,2)
			SetSpriteColorAlpha(count,50)
			inc count
		next x
		sync()
	next y

	game.mode = 1
	clearBlockSprites(game.blocksPicture, GRID_X, GRID_Y)
	
	deleteScoreDisplay(game.dataGrid)
	deleteLevelDisplay(game.dataGrid)
endfunction

// Affichage du menu de jeu
function lancerJeu(game ref as TetrisGame)
	if GetPointerPressed() = 1
		game.mode = 2
	endif
endfunction

// Initialisation du jeu
function initialiserJeu(game ref as TetrisGame)
	// Ecran de chargement pour le jeu
	// Effacement de l'écran d'accueil
	afficherChargement()
	
	game.level = 1
	
	game.changeShape = 0
	
	// Initialisation des figures
	game.shapes = setupShapes()
	
	// Choisir une figure au hasard
	game.currentShape = game.shapes[Random(1,7)]

	// On choisit la prochaine figure
	game.nextShape = game.shapes[Random(1,7)]

	game.blocksPicture = initImages()

	game.dataGrid = dataGridGameSetup(game)

	game.xOffset = ((xScreen - GRID_X * tailleBlock) / 2)*100/xScreen

	game.yOffset = (yScreen - GRID_Y * tailleBlock)*100/yScreen
	
	afficherArrierePlanJeu()
	
	// On créer les colonnes gauche / droite et la ligne du fond
	createBlockSprites(game.blocksPicture)
	
	// On efface l'écran de chargement
	effacerEcranChargement()
	
	// On nettoie la grille
	clearGrid(game.dataGrid)	
endfunction

// Réinitialisation des paramètres du jeu
function reinitGame(game ref as TetrisGame)
	game.dataGrid.moveShapeX = 4
	game.dataGrid.moveShapeY = 1
	game.currentShape.moveShapeRotation = 1
							
	// On à plus à effacer la figure
	game.shapeClear = 0
	game.changeShape = 0
							
	// La prochaine figure devient l'actuelle et on
	// choisi la prochaine à l'avance
	game.currentShape = game.nextShape
	game.nextShape = game.shapes[Random(1,7)]
							
	// Réinitialisation de la boucle de controle
	// de vitesse (on réentame un cycle de 25 boucle
	// sinon la vitesse de la figure sera plus rapide à son apparition)
	game.speedMove = 25 - ((game.level - 1) * 5)
endfunction

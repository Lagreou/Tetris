
// Project: TetrisLike 
// Created: 2020-07-26

// =============== INCLUSIONS =================== //

#include "tetrisShape.agc"
#include "gridGame.agc"
#include "checkingShape.agc"
#include "linesManagement.agc"
#include "setup.agc"
#include "input.agc"
#include "game.agc"
#include "gameGraphics.agc"
#include "downloadDisplayGraphics.agc"
#include "menuGraphics.agc"
#include "gameMenu.agc"
#include "optionsGraphics.agc"
#include "optionInputs.agc"

// Obligation de définir les types de variable
#option_explicit

// ============== INSTRUCTIONS PRINCIPALES =============== //

// ============ INITIALISATION DE L'ECRAN (contenu dans le setup) ============= //
initDisplay()

// Variable permettant de dire si le menu est chargé
isAccueilCharged as integer = 0

// Variable permettant de dire si une partie est en cours
// (ecran de jeu chargé)
isGameCharged as integer = 0

isOptionCharged as integer = 0

// Permet de voir si le programme vient juste d'être lancer
// pour le premier affichage du menu 
isGameLauch as integer = 1

// Nombre de secondes dans le jeu
secondsInGame as integer

spriteOptionClic as integer

// =============== INSTRUCTIONS POUR LE JEU ============== //

// Initialisation par défaut des paramètres de jeu :
// vitesse de jeu : tous les 25 tours
// mode : 1 (affichage de l'accueil)
// shapeClear : 0 (pas d'effacement de la figure)
// changeShape : 0 (pas de changement de figure au départ)
initGameDefault()

// Chargement du fichier permettant de régler le son
chargedMusicAndSoundVolume()

// Boucle principale du jeu
do
	// Ici, on regarde si on est dans l'écran titre ou
	// dans le jeu (mode 1 = écran titre, 2 = jeu )
	select game.mode
		case 1 :
			if isAccueilCharged
				interceptClickedButton()
			else
				if(isGameCharged)
					goToAccueilFromGame()
					isAccueilCharged = 1
					isGameCharged = 0
				elseif(isOptionCharged)
					goToMenuFromOption()
					isAccueilCharged = 1
					isOptionCharged = 0
				elseif(isGameLauch)
					afficherAccueil()
					// On charge la musique d'accueil
					chargerMusiqueAccueil()
					isAccueilCharged = 1
					isGameLauch = 0
				endif
			endif
			
			// On synchronise à ce niveau car si l'utilisateur clic il faut
			// que ce soit pris dessuite en compte
			sync()
		endcase
		
		case 2 :					
			// ============ INSTRUCTIONS EN RAPPORT AVEC LA PARTIE ========== //
			if isGameCharged
				playingGame()
			else				
				// Initialisation de l'écran de jeu
				initialiserJeu()
				
				// Ici, la partie est en cours de chargement
				// donc booléen à vrai
				isGameCharged = 1
				
				// En revanche, l'écran d'accueil n'est plus chargé
				isAccueilCharged = 0
				
				isOptionCharged = 0
			endif
			sync()					
		endcase
		
		case 3 :
			if isOptionCharged		
				
				scaleJauge as float
				
				// Ici, on regarde si on règle le son
				spriteOptionClic = detecterClicSurImageSon()
								
				if(GetSpriteExists(spriteOptionClic))
					// Ici on défini le scale selon si c'est la jauge de musique
					// ou de son
					if (spriteOptionClic = optionInterface.spriteMusicJauge)
						scaleJauge = volumeMusic / 100
						volumeMusic = bougerJauge(spriteOptionClic, scaleJauge) * 100
						SetMusicSystemVolumeOGG(volumeMusic)
					elseif(spriteOptionClic = optionInterface.spriteSoundJauge)
						scaleJauge = volumeSound/ 100
						volumeSound = bougerJauge(spriteOptionClic, scaleJauge) * 100
						SetSoundInstanceVolume(deleteLineSound, volumeSound)
					endif		
									
					// On enregistre dans le fichier
					recordMusicAndSoundVolume(volumeMusic, volumeSound)
					
				// Sinon on regarde si on clique sur exit et
				// on retourne à l'accueil dans ce cas	
				elseif(isPressedOnExitOption())
					game.mode = 1
				endif
			else
				goToOptionsFromMenu()
				isAccueilCharged = 0
				isOptionCharged = 1
			endif
			sync()
		endcase
		
	endselect
loop

// ============== FONCTIONS ================ //

// Initialisation du jeu
function initialiserJeu()
	// Ecran de chargement pour le jeu
	// Effacement de l'écran d'accueil
	afficherChargement()
	
	game.level = 1
	
	game.score = 0
	
	game.changeShape = 0
	
	// Initialisation des figures
	game.shapes = setupShapes()
	
	// Choisir une figure au hasard
	game.currentShape = game.shapes[Random(1,7)]
	
	// On choisit la prochaine figure
	game.nextShape = game.shapes[Random(1,7)]
	
	// Initialisation des images qu'on utilise
	// pour les blocs
	blocksPicture = initImages()
	
	// On initialise la taille des blocs
	initBlocSize()
	
	// On initialise le point d'ancrage des 
	// éléments de l'interface (blocs, barres...)
	initOffset()
	
	game.dataGrid = dataGridGameSetup()
	
	// On affiche l'interface du jeu
	displayGameInterface()
	
	// On efface l'écran de chargement
	effacerEcranChargement()
	
	// On nettoie la grille
	clearGrid(game.dataGrid)	
endfunction

// Réinitialisation des paramètres du jeu
function reinitGame()
	game.dataGrid.moveShapeX = 4
	game.dataGrid.moveShapeY = 1
	game.currentShape.moveShapeRotation = 1
							
	// On à plus à effacer la figure
	game.isShapeMoved = 0
	game.changeShape = 0
							
	// La prochaine figure devient l'actuelle et on
	// choisi la prochaine à l'avance
	game.currentShape = game.nextShape
	
	game.nextShape = game.shapes[Random(1,7)]
	
	// On met à jour coté graphique
	unchargingNextFigureSprite()
	chargingAndPlaceNextFigureSprite()
							
	// Réinitialisation de la boucle de controle
	// de vitesse (on réentame un cycle de 25 boucle
	// sinon la vitesse de la figure sera plus rapide à son apparition)
	game.speedMove = 25 - ((game.level - 1) * 5)
endfunction

// Fonction permettant au jeu d'avoir court. Prend en paramètre
// un objet tetrisGame (contenant les figure, le score, la grille...)
function playingGame()
	
	// Variable permettant de dire si on peux bouger
	// la figure
	moveOk as integer = 0
	
	// On regarde si la figure peux aller en bas (si non, on change de figure)
	game.changeShape = checkBelowShape(game.dataGrid, game.currentShape)
	
	if game.changeShape = 1
		updateStatus()
	else	
						
		// Le joueur presse un bouton ? on récupere la rotation qui en résulte si rotation
		// il y'a (directement dans dataGrid)
		// On récupere également le type de mouvement (1,2,3,4) selon la direction sur laquelle
		// le joueur a appuyer
		moveOk = executeMovementGiveByUser(game.dataGrid, game.currentShape)
		
		// On enregistre le dernier mouvement fait par le joueur
		game.lastMove = moveOk
		
		// vitesse du jeu : speedMove décroit
		// chaque fois qu'un tour de boucle est fait
		// En revanche si le joueur a appuyer sur la fleche
		// du bas, on n'avance pas la pièce		
		if game.speedMove = 0 and game.lastMove <> 4
			inc game.dataGrid.moveShapeY
			game.speedMove = 25 - ((game.level - 1) * 5)
		endif
		
		// On efface la figure si il y'a eu mouvement
		game.isShapeMoved = movingShape(game.currentShape, game.dataGrid, game.isShapeMoved)
		
		dec game.speedMove
		
		// On actualise les "dessins" sur la grille
		updateGridBlocks()		
	endif
endfunction

// Permet de mettre à jour le jeu lorsque le changement de figure
// est détecté (soit on continue soit game over)
function updateStatus()
	
	// Permet de savoir si la figure peut aller en bas
	canShapeMoveBottom as integer = 0
	
	// Permet de savoir si le joueur a bouger la figure
	moveOk as integer
	
	// Permet de savoir le nombre de miliseconde passées dans le jeu
	milisecondsInGame as integer
	
	// On regarde si le joueur a dépasser la limite :
	// GameOver dans ce cas
	if(game.dataGrid.moveShapeY = 1)
		displayGameOver()
	// On regarde si des lignes sont à effacées car
	// la figure a atteint le bas
	else
		// On regarde que le dernier mouvement connu est différent de 4
		// (mouvement vers le bas)
		if(game.lastMove <> 4)
			// On laisse le temps au joueur de se déplacer une dernière fois
			milisecondsInGame = GetMilliseconds()
			
			repeat
				moveOk = executeMovementGiveByUser(game.dataGrid, game.currentShape)
				
				if(moveOk <> 0)
					
					// On efface la figure si il y'a eu mouvement
					game.isShapeMoved = movingShape(game.currentShape, game.dataGrid, game.isShapeMoved)
					
					// On actualise les "dessins" sur la grille
					updateGridBlocks()
					
					// On réinitialise le timer
					milisecondsInGame = GetMilliseconds()
					
					// Tant que la figure peux descendre, ça continue
					while(checkBelowShape(game.dataGrid, game.currentShape) = 0)
						inc game.dataGrid.moveShapeY	
						sync()
					endwhile
				endIf
				// On synchronise pour que le gif continue de défiler malgrès l'attente
				sync()					
			until(GetMilliseconds() > milisecondsInGame + 500 or moveOk)
		endif		
							
		// On regarde si des lignes sont à effacer
		effacerLignes()
		
		// On regarde si la limite du score du niveau est atteinte.
		// Si oui : on augmente la difficultée
		if(game.score >= game.scoreLimit[game.level] and game.level <> 6)
			inc game.level
			// Mise à jour du label
			levelLabelUpdate(game.level)
		endif
		
		// On réinitialise les données comme si c'était la première
		// figure
		reinitGame()
	endif
endfunction

function goToAccueilFromGame()
	// On decharge la musique de jeu (car on peux passer
	// directement du jeu au menu
	dechargerMusiqueJeu()
	
	// On decharge l'ecran de jeu
	dechargerSpriteEtImageJeu()
	
	// On charge la musique d'accueil
	chargerMusiqueAccueil()
	
	afficherAccueil()
endfunction

function goToOptionsFromMenu()
	
	// Déplacer le chargement car si dans le mauvais ordre
	// peut provoquer des bugs
	dechargerSpritesAccueil()	
	
	chargerInterfaceGraphicsOptions()
endfunction

function goToMenuFromOption()
	// On décharge l'interface d'option
	dechargedAllImagesOption()
	
	afficherAccueil()
endFunction

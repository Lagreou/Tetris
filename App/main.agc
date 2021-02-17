
// Project: FallingBloc 
// Created: 2020-07-26
// Author : Marc Lagreou

// Obligation de définir les types de variable
#option_explicit

// =============== INCLUSIONS =================== //

#include "model/tetrisShape.agc"
#include "model/gridGame.agc"
#include "model/optionInputs.agc"
#include "model/gameMenu.agc"
#include "model/game.agc"
#include "model/gameStates.agc"
#include "vue/gameGraphics.agc"
#include "vue/downloadDisplayGraphics.agc"
#include "vue/menuGraphics.agc"
#include "vue/optionsGraphics.agc"
#include "utils/checkingShape.agc"
#include "utils/linesManagement.agc"
#include "utils/setup.agc"
#include "utils/input.agc"
#include "utils/music.agc"
#include "utils/utilsFileScreenDisplay.agc"

// ============== INSTRUCTIONS PRINCIPALES =============== //

// ============ INITIALISATION DE L'ECRAN (contenu dans le setup) ============= //

// Sprite représentant la jauge sur laquelle
// le joueur a cliquer dans les options
spriteOptionClic as integer

// =============== INSTRUCTIONS POUR LE JEU ============== //
initStates()
initDisplay()

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
	// dans le jeu (mode 1 = écran titre, 2 = jeu, 3 = options)
	select game.mode
		case 1 :
			if gameStates.isAccueilCharged
				interceptClickedButton()
			else
				gameStates.isAccueilCharged = 1
				
				chooseGoodLoadSplashScreenFunction()			
			endif
			
			// On synchronise à ce niveau car si l'utilisateur clic il faut
			// que ce soit pris dessuite en compte
			sync()
		endcase
		
		case 2 :					
			// ============ INSTRUCTIONS EN RAPPORT AVEC LA PARTIE ========== //
			if gameStates.isGameCharged
				playingGame()
			else				
				// Initialisation de l'écran de jeu
				initGame()
				
				// Ici, la partie est en cours de chargement
				// donc booléen à vrai
				gameStates.isGameCharged = 1
				
				// En revanche, l'écran d'accueil n'est plus chargé
				gameStates.isAccueilCharged = 0
				
				gameStates.isOptionCharged = 0
			endif
			sync()					
		endcase
		
		case 3 :
			if gameStates.isOptionCharged		
				
				scaleJauge as float
				
				// Ici, on regarde si on règle le son
				spriteOptionClic = detectClicOnSoundImage()
								
				if(GetSpriteExists(spriteOptionClic))
					// Ici on défini le scale selon si c'est la jauge de musique
					// ou de son
					if (spriteOptionClic = optionInterface.spriteMusicJauge)
						scaleJauge = volumeMusic / 100
						volumeMusic = moveJauge(spriteOptionClic, scaleJauge) * 100
						SetMusicSystemVolumeOGG(volumeMusic)
					elseif(spriteOptionClic = optionInterface.spriteSoundJauge)
						scaleJauge = volumeSound/ 100
						volumeSound = moveJauge(spriteOptionClic, scaleJauge) * 100
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
				goToOptionsFromSplashScreen()
				gameStates.isAccueilCharged = 0
				gameStates.isOptionCharged = 1
			endif
			sync()
		endcase
		
		
		
	endselect
loop

// ============== FONCTIONS ================ //

// Initialisation du jeu
function initGame()
	// Ecran de chargement pour le jeu
	// Effacement de l'écran d'accueil
	displayDownloading()
	
	game.level = 1
	
	game.score = 0
	
	game.changeShape = 0
	
	gameStates.isGameOver = 0
	
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
	deleteDownloadingScreen()
	
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
	unloadNextFigureSprite()
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
	
	while(game.changeShape = 1)
		// On regarde si le joueur a dépasser la limite :
		// GameOver dans ce cas
		// Sinon on donne une chance au joueur de bouger
		// sa figure
		if(game.dataGrid.moveShapeY = 1)
			displayGameOver()
			game.changeShape = 0
			gameStates.isGameOver = 1
			game.mode = 1
		else
			if(game.lastMove <> 4)	
				giveLastChanceToMove()
			else
				updateStatus()
			endif
		endif
	endWhile	
	
	if(game.changeShape = 0 and gameStates.isGameOver = 0)
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

function giveLastChanceToMove()
	// Permet de savoir si le joueur a bouger la figure
	moveOk as integer
	
	// Permet de savoir le nombre de miliseconde passées dans le jeu
	milisecondsInGame as integer
	
	milisecondsInGame = GetMilliseconds()
	
	// On regarde si le joueur bouge et peux atteindre un endroit vide
	// pour réinitialiser changeShape
	repeat
		moveOk = executeMovementGiveByUser(game.dataGrid, game.currentShape)
		
		if(moveOk <> 0)			
			// On efface la figure si il y'a eu mouvement
			game.isShapeMoved = movingShape(game.currentShape, game.dataGrid, game.isShapeMoved)
			updateGridBlocks()
			// On réinitialise le timer
			milisecondsInGame = GetMilliseconds()
		endIf
		// On synchronise pour que le gif d'arriere plan continue de défiler malgrès l'attente
		sync()					
	until(GetMilliseconds() > milisecondsInGame + 300 and moveOk = 0)
	
	if(checkBelowShape(game.dataGrid, game.currentShape) = 0)
		game.changeShape = 0
	else
		updateStatus()
	endif
endFunction

function updateStatus()
	// On regarde si des lignes sont à effacer
	deleteLines()
	
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
endFunction

function goToSplashScreenFromGame()
	// On decharge la musique de jeu (car on peux passer
	// directement du jeu au menu
	unloadGameMusic()
	
	// On decharge l'ecran de jeu
	unloadGameSpriteAndImageGame()
	
	// On charge la musique d'accueil
	loadSplashScreenMusic()
	
	displaySplashScreen()
endfunction

function goToOptionsFromSplashScreen()
	
	// Déplacer le chargement car si dans le mauvais ordre
	// peut provoquer des bugs
	unloadSplashScreen()	
	
	loadInterfaceGraphicsOptions()
endfunction

function goToSplashScreenFromOption()
	// On décharge l'interface d'option
	unloadAllImagesOption()
	
	displaySplashScreen()
endFunction

// Permet de charger le splashScreen en fonction
// de la où le joueur vient
function chooseGoodLoadSplashScreenFunction()
	if(gameStates.isGameCharged)
		goToSplashScreenFromGame()
		gameStates.isGameCharged = 0
	elseif(gameStates.isOptionCharged)
		goToSplashScreenFromOption()
		gameStates.isOptionCharged = 0
	elseif(gameStates.isFirstGameLaunch)
		displaySplashScreen()
		// On charge la musique d'accueil
		loadSplashScreenMusic()
		gameStates.isFirstGameLaunch = 0
	endif
endfunction

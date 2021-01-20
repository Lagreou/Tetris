// ===============================================
//================= CONSTANTES ====================
//===================================================

// Nombre de blocks dans le jeu 
#constant IMAGES_COLOR = 7

// ============= VERSION MOBILE ================

// Position du bouton gauche
#constant LEFT_BUTTON_X = 400
#constant LEFT_BUTTON_Y = 800

// Position du bouton droite
#constant RIGHT_BUTTON_X = 300
#constant RIGHT_BUTTON_Y = 800


// ===============================================
// ================= TYPES =======================
//================================================
Type blocksGraphics
	imageArray as integer[IMAGES_COLOR]
endtype


// ===============================================
// ================= VARIABLES GLOBALES ==========
// ===== (mais simplement utilisées dans =========
// ===== les fonctions de ce fichier) ============
//================================================

// image des barres limites gauches et droite de
// l'aire de jeu
global imageleftAndRightBar as integer

// image des barres limites haut et bas de
// l'aire de jeu
global imagetopAndBottomBar as integer

// image du cadre des scores
global imageScore as integer

// image du cadre des niveaux
global imageCurrentLevel as integer

// image du cadre de la prochaineFigure
global imageNextFigure as integer


// Définit là où la grille apparait à l'écran
global xOffset as integer
global yOffset as integer

// Taille des blocks tetris, à adapter selon l'affichage
global tailleBlock as float // => en px
global tailleBlocPourcent as float // => en %

// sprite du background du jeu
global spriteBackground as integer

// sprite barre gauche
global spriteLeftBar as integer

// sprite barre droite
global spriteRightBar as integer

// sprite barre haut
global spriteTopBar as integer

// sprite barre bas
global spriteBottomBar as integer

// sprite du cadre des scores
global SpriteFrameScore as integer

// sprite du cadre des niveaux
global SpriteFrameCurrentLevel as integer

// sprite du cadre de la prochaineFigure
global SpriteFrameNextFigure as integer

// Label représentant le Score
global scoreLabel as integer

// Label représentant le niveau du jeu
global levelLabel as integer

global nextFigureSprite as integer

// ================================================
// ================== FONCTIONS ===================
// ================================================

// Affiche l'écran de jeu et démarre la musique
// de jeu
function displayGameBackGroundAndMusic()
	// On charge la musique du jeu
	chargerMusiqueJeu()
	
	// On charge l'écran du jeu
	displayGameBackGround()
endfunction


// =======================================
// ======== GESTION SPRITES INTERFACE ====
// ==================================== //
function displayGameBackGround()
	imageBackground = LoadImage("background2.gif")
	spriteBackground = CreateSprite(imageBackground)
		
	// Le -1 sert à garder l'échelle d'origine par rapport à la largeur
	SetSpriteSize(spriteBackground,-1,100)
	
	SetSpritePosition(spriteBackground, 15, 0)
endfunction

function displayGameInterface()
	
	chargingGameInterface()
	placedBars()
	placedFrames()
	placedLabels(game)
	ChargingAndPlaceNextFigureSprite(game.nextShape)
endfunction

function chargingGameInterface()
	imageleftAndRightBar = LoadImage("leftAndRight.png")
	spriteLeftBar = CreateSprite(imageleftAndRightBar)
	spriteRightBar = CreateSprite(imageleftAndRightBar)
	
	imagetopAndBottomBar = LoadImage("topAndBottom.png")
	spriteTopBar = CreateSprite(imagetopAndBottomBar)
	spriteBottomBar = CreateSprite(imagetopAndBottomBar)
	
	imageNextFigure = LoadImage("next.png")
	SpriteFrameNextFigure = CreateSprite(imageNextFigure)
	
	imageScore = LoadImage("score.png")
	SpriteFrameScore = CreateSprite(imageScore)
	
	imageCurrentLevel = LoadImage("level.png")
	SpriteFrameCurrentLevel = CreateSprite(imageCurrentLevel)
	
	chargingAllImageNextFigureInMemory()
	
endfunction

function chargingAllImageNextFigureInMemory()
	tabImageNextFigure[0] = LoadImage("IImage.png")
	tabImageNextFigure[1] = LoadImage("OImage.png")
	tabImageNextFigure[2] = LoadImage("LImage.png")
	tabImageNextFigure[3] = LoadImage("JImage.png")
	tabImageNextFigure[4] = LoadImage("TImage.png")
	tabImageNextFigure[5] = LoadImage("ZImage.png")
	tabImageNextFigure[6] = LoadImage("SImage.png")
endfunction

function dechargerAllImageNextFigureOutMemory()
	c as integer
	
	for c = 0 to tabImageNextFigure.length
		DeleteImage(tabImageNextFigure[c])
	next c
endFunction

function dechargerSpriteEtImageJeu()
	DeleteSprite(spriteBackground)
	
	DeleteSprite(spriteLeftBar)
	DeleteSprite(spriteRightBar)
	DeleteSprite(spriteTopBar)
	DeleteSprite(spriteBottomBar)
	DeleteSprite(SpriteFrameNextFigure)
	DeleteSprite(SpriteFrameCurrentLevel)
	DeleteSprite(SpriteFrameScore)
	
	
	DeleteImage(imageBackground)
	DeleteImage(imageleftAndRightBar)
	DeleteImage(imagetopAndBottomBar)
	
	DeleteImage(imageNextFigure)
	DeleteImage(imageScore)
	DeleteImage(imageCurrentLevel)
	
	dechargerAllImageNextFigureOutMemory()
	UnchargingNextFigureSprite()
endfunction

function ChargingAndPlaceNextFigureSprite(shape as tetrisShape)
	width as integer
	height as integer
	
	nextFigureSprite = CreateSprite(tabImageNextFigure[shape.shapeNumb - 1])
	
	SetSpriteSize(nextFigureSprite, -1, GetSpriteHeight(SpriteFrameNextFigure)/2)
	SetSpritePosition(nextFigureSprite, getSpriteX(SpriteFrameNextFigure) + 3, GetSpriteY(SpriteFrameNextFigure) + 8)
endFunction

function UnchargingNextFigureSprite()
	DeleteSprite(nextFigureSprite)		
endFunction

// Permet de placer les barres ainsi que d'ajuster
// la taille selon l'écran
function placedBars()
	
	SetSpriteSize(spriteLeftBar, -1, 100)
	SetSpriteSize(spriteRightBar, -1, 100)
	SetSpriteSize(spriteTopBar, 25.5, -1)
	SetSpriteSize(spriteBottomBar, 25.5, -1)
	
	SetSpritePosition(spriteLeftBar, xOffset, 0)
	SetSpritePosition(spriteRightBar, 62.5, 0)
	SetSpritePosition(spriteTopBar, xOffset, yOffset)
	SetSpritePosition(spriteBottomBar, xOffset, 99.5)
endfunction

// Permet de placer les divers cadres (figure, niveau, score...)
// ainsi que d'ajuster la taille
function placedFrames()
	imageWidth as integer
	imageHeight as integer
	
	// Calcule pour nextFigure
	imageWidth = pixelToPercentWidth(GetImageWidth(imageNextFigure))
	imageHeight = pixelToPercentHeight(GetImageHeight(imageNextFigure))
	
	SetSpriteSize(SpriteFrameNextFigure, imageWidth, imageHeight)
	
	// Calcule pour level
	imageWidth = pixelToPercentWidth(GetImageWidth(imageCurrentLevel))
	imageHeight = pixelToPercentHeight(GetImageHeight(imageCurrentLevel))
	
	SetSpriteSize(SpriteFrameCurrentLevel, imageWidth, imageHeight)
	
	// Calcule pour score
	imageWidth = pixelToPercentWidth(GetImageWidth(imageScore))
	imageHeight = pixelToPercentHeight(GetImageHeight(imageScore))
	
	SetSpriteSize(SpriteFrameScore, imageWidth, imageHeight)
	
	// Placement du nextFigure
	SetSpritePosition(SpriteFrameNextFigure, getSpriteX(spriteRightBar) + 0.3, getSpriteY(spriteRightBar))
	
	// Placement du score
	SetSpritePosition(SpriteFrameScore, getSpriteX(spriteRightBar) + 0.3, getSpriteY(spriteRightBar) + GetSpriteHeight(SpriteFrameNextFigure)*2.5)
	
	// Placement du level
	SetSpritePosition(SpriteFrameCurrentLevel, getSpriteX(spriteLeftBar) - GetSpriteWidth(SpriteFrameCurrentLevel), getSpriteY(spriteLeftBar))
endfunction

// Permet de placer les labels pour le score,
// le niveau...
function placedLabels(game as tetrisGame)
	
	levelLabel = CreateText(Str(game.level))
	
	scoreLabel = CreateText(Str(game.score))

	// Pour le score
	SetTextSize(scoreLabel, 12)
	SetTextPosition(scoreLabel, GetSpriteX(SpriteFrameScore) + (GetSpriteWidth(SpriteFrameScore)/ 3), GetSpriteY(SpriteFrameScore) + (GetSpriteHeight(SpriteFrameScore)/3))
	SetTextColor(scoreLabel, 255,255,255,255)
	
	// Pour le niveau
	SetTextSize(levelLabel, 12)
	SetTextPosition(levelLabel, GetSpriteX(SpriteFrameCurrentLevel) + (GetSpriteWidth(SpriteFrameCurrentLevel)/ 3), GetSpriteY(SpriteFrameCurrentLevel) + (GetSpriteHeight(SpriteFrameCurrentLevel)/3))
	SetTextColor(levelLabel, 255,255,255,255)

endfunction

function placedImageForNextFigure(nextFigure as tetrisShape)
	
endfunction

function scoreLabelUpdate(score as integer)
	SetTextString(scoreLabel, Str(score))
endfunction

function levelLabelUpdate(level as integer)
	SetTextString(levelLabel, Str(level))
endfunction

function deleteScoreDisplay()
	DeleteText(scoreLabel)
endfunction

function deleteLevelDisplay()
	DeleteText(levelLabel)
endfunction

// =======================================
// =========== GESTION DES BLOCS =========
// ==================================== //

// Charge l'image appropriée dans chaque block
function initImages()
	tabImage as blocksGraphics
	
	tabImage.imageArray[0] = loadImage("red.png")
	tabImage.imageArray[1] = loadImage("orange.png")
	tabImage.imageArray[2] = loadImage("pink.png")
	tabImage.imageArray[3] = loadImage("black.png")
	tabImage.imageArray[4] = loadImage("blue.png")
	tabImage.imageArray[5] = loadImage("green.png")
	tabImage.imageArray[6] = loadImage("purple.png")
endfunction tabImage

// Initialise la taille des blocs du tetris
// selon l'affichage
function initBlocSize()
	tailleBlock = yScreen / GRID_Y
	tailleBlocPourcent = tailleBlock * 100/yScreen
endfunction

// Genere les sprites pour chaque colonne et rang de block
function createBlockSprites(tabImage ref as blocksGraphics)
	count as integer = 1
	tailleBlocPourcent as float
	y as integer
	x as integer
	
	for y = 1 to GRID_Y
		for x = 1 to GRID_X
			CreateSprite(count, tabImage.imageArray[0])
			SetSpriteSize(count, -1, tailleBlocPourcent)
			inc count
		next x
	next y
endfunction

// Efface de la mémoire tous les sprites des blocs
function clearBlockSprites(tabImage ref as blocksGraphics)
	count as integer = 1
	y as integer
	x as integer
	
	for y = 1 to GRID_Y
		for x = 1 to GRID_X
			DeleteSprite(count)
			DeleteImage(count)
			inc count
		next x
	next y
endfunction

// Parcours la grille de nombre et affiche les blocks associés
function updateGridBlocks(imageGrid as blocksGraphics)
	count as integer = 1
	image as integer
	y as integer
	x as integer
	
	for y = 0 to GRID_Y - 1
		for x = 0 to GRID_X - 1
			SetSpriteVisible(count, 1)
			
			select game.dataGrid.grid[x+1, y+1]
				case 0
					SetSpriteVisible(count,0)
				endcase
				case 1
					image = imageGrid.imageArray[0]
				endcase
				case 2
					image = imageGrid.imageArray[1]
				endcase
				case 3
					image = imageGrid.imageArray[2]
				endcase
				case 4
					image = imageGrid.imageArray[3]
				endcase
				case 5
					image = imageGrid.imageArray[4]
				endcase
				case 6
					image = imageGrid.imageArray[5]
				endcase
				case 7
					image = imageGrid.imageArray[6]
				endcase
			endselect
			
			SetSpriteImage(count,image)
			SetSpriteSize(count, -1, tailleBlocPourcent)
			SetSpritePosition(count, x*xSpace + xOffset, y*tailleBlocPourcent+yOffset)
			inc count
		next x
	next y
	
endfunction

// Permet d'initialiser les coordonnées d'affichage des blocs,
// barres...
function initOffset()
	xOffset = ((xScreen - GRID_X * tailleBlock) / 2)*100/xScreen
	yOffset = (yScreen - GRID_Y * tailleBlock)*100/yScreen
endfunction

// Affichage du game over
function displayGameOver()
	
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
	clearBlockSprites(game.blocksPicture)
	
	deleteScoreDisplay()
	deleteLevelDisplay()
endfunction

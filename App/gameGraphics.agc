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
Type BlocksGraphics
	imageArray as integer[IMAGES_COLOR]
endtype

type GraphicsElementGameInterface
	
	// image des differentes figures dans le cadre next
	tabImageNextFigure as integer[7]
	
	// Image arrière jeu
	imageBackground as integer
	
	// image des barres limites gauches et droite de
	// l'aire de jeu
	imageleftAndRightBar as integer

	// image des barres limites haut et bas de
	// l'aire de jeu
	imagetopAndBottomBar as integer

	// image du cadre des scores
	frameScoreImage as integer

	// image du cadre des niveaux
	frameCurrentLevelImage as integer

	// image du cadre de la prochaineFigure
	frameNextFigureImage as integer

	// Définit là où la grille apparait à l'écran
	xOffset as integer
	yOffset as integer

	// Taille des blocks tetris, à adapter selon l'affichage
	tailleBlock as float // => en px
	tailleBlocLargeurPourcent as float // => en %
	tailleBlocHauteurPourcent as float
	
	// Largeur de l'arène calculée par rapport à l'écran
	largeurArene as float
	
	// sprite du background du jeu
	spriteBackground as integer

	// sprite barre gauche
	spriteLeftBar as integer

	// sprite barre droite
	spriteRightBar as integer

	// sprite barre haut
	spriteTopBar as integer

	// sprite barre bas
	spriteBottomBar as integer

	// sprite du cadre des scores
	spriteFrameScore as integer

	// sprite du cadre des niveaux
	spriteFrameCurrentLevel as integer

	// sprite du cadre de la prochaineFigure
	spriteFrameNextFigure as integer

	// Label représentant le Score
	scoreLabel as integer

	// Label représentant le niveau du jeu
	levelLabel as integer

	nextFigureSprite as integer
endtype

// ===============================================
// ================= VARIABLES GLOBALES ==========
//================================================

// Tableau contenant les blocs du jeu	
global blocksPicture as blocksGraphics

// Contient les éléments d'interface en cours d'une partie
global graphicsGameElements as GraphicsElementGameInterface

// ================================================
// ================== FONCTIONS ===================
// ================================================

// =======================================
// ======== GESTION SPRITES INTERFACE ====
// ==================================== //

// Affiche toute l'interface du jeu
function displayGameInterface()
	displayGameBackGroundAndMusic()
	
	// On créer les colonnes gauche / droite et la ligne du bas
	createBlockSprites()
	
	// On charge tout ce qui a attrait à l'interface
	chargingGameInterface()
	
endfunction

// Affiche l'arrière plan et démarre la musique
// de jeu
function displayGameBackGroundAndMusic()
	// On charge la musique du jeu
	chargerMusiqueJeu()
	
	// On charge l'écran du jeu
	displayGameBackGround()
endfunction

// Affiche l'arrière plan du jeu
function displayGameBackGround()
	graphicsGameElements.imageBackground = LoadImage("background2.gif")
	graphicsGameElements.spriteBackground = CreateSprite(graphicsGameElements.imageBackground)
		
	// Le -1 sert à garder l'échelle d'origine par rapport à la largeur
	SetSpriteSize(graphicsGameElements.spriteBackground,-1,100)
	
	SetSpritePosition(graphicsGameElements.spriteBackground, 15, 0)
endfunction

// Charge tous les éléments d'interface
function chargingGameInterface()
	graphicsGameElements.imageleftAndRightBar = LoadImage("leftAndRight.png")
	graphicsGameElements.spriteLeftBar = CreateSprite(graphicsGameElements.imageleftAndRightBar)
	graphicsGameElements.spriteRightBar = CreateSprite(graphicsGameElements.imageleftAndRightBar)
	
	graphicsGameElements.imagetopAndBottomBar = LoadImage("topAndBottom.png")
	graphicsGameElements.spriteTopBar = CreateSprite(graphicsGameElements.imagetopAndBottomBar)
	graphicsGameElements.spriteBottomBar = CreateSprite(graphicsGameElements.imagetopAndBottomBar)
	
	graphicsGameElements.frameNextFigureImage = LoadImage("next.png")
	graphicsGameElements.SpriteFrameNextFigure = CreateSprite(graphicsGameElements.frameNextFigureImage)
	
	graphicsGameElements.frameScoreImage = LoadImage("score.png")
	graphicsGameElements.SpriteFrameScore = CreateSprite(graphicsGameElements.frameScoreImage)
	
	graphicsGameElements.frameCurrentLevelImage = LoadImage("level.png")
	graphicsGameElements.SpriteFrameCurrentLevel = CreateSprite(graphicsGameElements.frameCurrentLevelImage)
	
	chargingAllImageNextFigureInMemory()
	
	createAndPlacedBars()
	createAndPlacedFrames()
	createAndPlacedLabels()
	chargingAndPlaceNextFigureSprite()
endfunction

// Permet de charger toutes les images des figures à
// placer dans la case next en mémoire
function chargingAllImageNextFigureInMemory()
	graphicsGameElements.tabImageNextFigure[0] = LoadImage("IImage.png")
	graphicsGameElements.tabImageNextFigure[1] = LoadImage("OImage.png")
	graphicsGameElements.tabImageNextFigure[2] = LoadImage("LImage.png")
	graphicsGameElements.tabImageNextFigure[3] = LoadImage("JImage.png")
	graphicsGameElements.tabImageNextFigure[4] = LoadImage("TImage.png")
	graphicsGameElements.tabImageNextFigure[5] = LoadImage("ZImage.png")
	graphicsGameElements.tabImageNextFigure[6] = LoadImage("SImage.png")
endfunction

// Permet de décharger toutes les images des figures à
// placer dans la case next de la mémoire
function dechargerAllImageNextFigureOutMemory()
	c as integer
	
	for c = 0 to graphicsGameElements.tabImageNextFigure.length
		DeleteImage(graphicsGameElements.tabImageNextFigure[c])
	next c
endFunction

// Permet de décharger tous les sprites et image
// de l'interface de la partie en cours
function dechargerSpriteEtImageJeu()
	DeleteSprite(graphicsGameElements.spriteBackground)
	
	DeleteSprite(graphicsGameElements.spriteLeftBar)
	DeleteSprite(graphicsGameElements.spriteRightBar)
	DeleteSprite(graphicsGameElements.spriteTopBar)
	DeleteSprite(graphicsGameElements.spriteBottomBar)
	DeleteSprite(graphicsGameElements.SpriteFrameNextFigure)
	DeleteSprite(graphicsGameElements.SpriteFrameCurrentLevel)
	DeleteSprite(graphicsGameElements.SpriteFrameScore)
	
	
	DeleteImage(graphicsGameElements.imageBackground)
	DeleteImage(graphicsGameElements.imageleftAndRightBar)
	DeleteImage(graphicsGameElements.imagetopAndBottomBar)
	
	DeleteImage(graphicsGameElements.frameNextFigureImage )
	DeleteImage(graphicsGameElements.frameScoreImage)
	DeleteImage(graphicsGameElements.frameCurrentLevelImage)
	
	dechargerAllImageNextFigureOutMemory()
	unchargingNextFigureSprite()
endfunction

// Permet de charger l'image de la prochaine
// figure qui va tombée après celle en cours
function chargingAndPlaceNextFigureSprite()
	
	// hauteur de l'image à placer dans le cadre
	heightFigureSprite as float
	
	// coordonnée x de l'image à placer dans le cadre
	coorXFigureSprite as float
	
	// coordonnée y de l'image à placer dans le cadre
	coorYFigureSprite as float
	
	// On fait -1 car dans le tableau, la figure correspond au numéro - 1
	// exemple : la figure I est en position 1 dans nextShape, mais dans tabImageNextFigure elle est en 0
	graphicsGameElements.nextFigureSprite = CreateSprite(graphicsGameElements.tabImageNextFigure[game.nextShape.shapeNumb - 1])
	
	// On calcule la hauteur de l'image à placer dans next
	heightFigureSprite = GetSpriteHeight(graphicsGameElements.SpriteFrameNextFigure)/1.5
	
	// On calcule les coordonnées
	coorXFigureSprite = getSpriteX(graphicsGameElements.SpriteFrameNextFigure) + 2
	coorYFigureSprite = GetSpriteY(graphicsGameElements.SpriteFrameNextFigure) + 5
	
	// On met à jour la taille et on place l'image
	SetSpriteSize(graphicsGameElements.nextFigureSprite, -1, heightFigureSprite)
	SetSpritePosition(graphicsGameElements.nextFigureSprite, coorXFigureSprite , coorYFigureSprite)
endfunction

// Efface le sprite de la prochaine figure dans le cadre next
function unchargingNextFigureSprite()
	DeleteSprite(graphicsGameElements.nextFigureSprite)		
endfunction

// Permet de placer les barres ainsi que d'ajuster
// la taille selon l'écran
function createAndPlacedBars()
	
	SetSpriteSize(graphicsGameElements.spriteLeftBar, -1, 100)
	SetSpriteSize(graphicsGameElements.spriteRightBar, -1, 100)
	SetSpriteSize(graphicsGameElements.spriteTopBar, 25.5, -1)
	SetSpriteSize(graphicsGameElements.spriteBottomBar, 25.5, -1)
	
	SetSpritePosition(graphicsGameElements.spriteLeftBar, graphicsGameElements.xOffset, 0)
	SetSpritePosition(graphicsGameElements.spriteRightBar, 62.5, 0)
	SetSpritePosition(graphicsGameElements.spriteTopBar, graphicsGameElements.xOffset, graphicsGameElements.yOffset)
	SetSpritePosition(graphicsGameElements.spriteBottomBar, graphicsGameElements.xOffset, 99.5)
endfunction

// Permet de placer les divers cadres (figure, niveau, score...)
// ainsi que d'ajuster la taille
function createAndPlacedFrames()
	// Tableau contenant longueur et largeur des sprites
	lengths as integer[1]
	
	// Calcule de la taille du cadre next et attribution (conversion px => %)
	lengths = calculateHeightAndWidthForImage(graphicsGameElements.frameNextFigureImage)
	SetSpriteSize(graphicsGameElements.spriteFrameNextFigure, lengths[0], lengths[1])
	
	// Calcule de la taille du cadre level et attribution (conversion px => %)
	lengths = calculateHeightAndWidthForImage(graphicsGameElements.frameCurrentLevelImage)
	SetSpriteSize(graphicsGameElements.spriteFrameCurrentLevel, lengths[0], lengths[1])
	
	// Calcule de la taille du cadre score et attribution (conversion px => %)
	lengths = calculateHeightAndWidthForImage(graphicsGameElements.frameScoreImage)
	SetSpriteSize(graphicsGameElements.spriteFrameScore, lengths[0], lengths[1])
	
	// Mise en place des cadres dans l'interface
	placedFrames()
	
endfunction

// Permet de mettre en place les cadres avec le score,
// la prochaine figure, le niveau...
function placedFrames()
	
	// Coordonnée x du sprite à placer
	coorXSprite as float
	
	// Coordonnée y du sprite à placer
	coorYSprite as float
	
	// =======================================================
	
	// calcules pour le cadre next
	coorXSprite = getSpriteX(graphicsGameElements.spriteRightBar) + 0.3
	coorYSprite = getSpriteY(graphicsGameElements.spriteRightBar)
	
	// Placement pour le cadre next
	SetSpritePosition(graphicsGameElements.spriteFrameNextFigure, coorXSprite , coorYSprite )
	
	// calcules pour le cadre score
	coorXSprite = getSpriteX(graphicsGameElements.spriteRightBar) + 0.3
	coorYSprite = (getSpriteY(graphicsGameElements.spriteRightBar) + GetSpriteHeight(graphicsGameElements.spriteRightBar)) - GetSpriteHeight(graphicsGameElements.spriteFrameScore)
	
	// Placement pour le cadre score
	SetSpritePosition(graphicsGameElements.spriteFrameScore, coorXSprite , coorYSprite )
	
	// calcules pour le cadre level
	coorXSprite = getSpriteX(graphicsGameElements.spriteLeftBar) - GetSpriteWidth(graphicsGameElements.spriteFrameCurrentLevel)
	coorYSprite = getSpriteY(graphicsGameElements.spriteLeftBar)
	
	// Placement pour le cadre level
	SetSpritePosition(graphicsGameElements.spriteFrameCurrentLevel, coorXSprite , coorYSprite)
endfunction

// Calcule la hauteur et la largeur en pourcent depuis la taille
// original en pixel d'une image donnée
// 0 : largeur
// 1 : hauteur
function calculateHeightAndWidthForImage(image as integer)
	lengths as integer[1]
	
	lengths[0] = pixelToPercentWidth(GetImageWidth(image))
	lengths[1] = pixelToPercentHeight(GetImageHeight(image))
endfunction lengths

// Permet de placer les labels pour le score,
// le niveau...
function createAndPlacedLabels()
	
	// Coordonnée x du sprite à placer
	coorXText as float
	
	// Coordonnée y du sprite à placer
	coorYText as float
	
	graphicsGameElements.levelLabel = CreateText(Str(game.level))
	
	graphicsGameElements.scoreLabel = CreateText(Str(game.score))

	// ========= SCORE ==================
	// calcules ...
	coorXText = GetSpriteX(graphicsGameElements.spriteFrameScore) + (GetSpriteWidth(graphicsGameElements.spriteFrameScore)/2.5)
	coorYText = GetSpriteY(graphicsGameElements.spriteFrameScore) + (GetSpriteHeight(graphicsGameElements.spriteFrameScore)/3)
	
	// placement ...
	SetTextSize(graphicsGameElements.scoreLabel, 7)
	SetTextPosition(graphicsGameElements.scoreLabel, coorXText , coorYText)
	SetTextColor(graphicsGameElements.scoreLabel, 255,255,255,255)
	
	// ========= NIVEAU ==================
	// calcules ...
	coorXText = GetSpriteX(graphicsGameElements.spriteFrameCurrentLevel) + (GetSpriteWidth(graphicsGameElements.spriteFrameCurrentLevel)/2.5)
	coorYText = GetSpriteY(graphicsGameElements.spriteFrameCurrentLevel) + (GetSpriteHeight(graphicsGameElements.spriteFrameCurrentLevel)/3)
	
	// placement ...
	SetTextSize(graphicsGameElements.levelLabel, 7)
	SetTextPosition(graphicsGameElements.levelLabel, coorXText , coorYText)
	SetTextColor(graphicsGameElements.levelLabel, 255,255,255,255)
endfunction

// Permet de mettre à jour le score coté interface avec 
// le texte passer en paramètre
function scoreLabelUpdate(score as integer)
	SetTextString(graphicsGameElements.scoreLabel, Str(score))
endfunction

// Permet de mettre à jour le level coté interface avec 
// le texte passer en paramètre
function levelLabelUpdate(level as integer)
	SetTextString(graphicsGameElements.levelLabel, Str(level))
endfunction

// Permet d'effacer le texte du score coté interface
function deleteScoreDisplay()
	DeleteText(graphicsGameElements.scoreLabel)
endfunction

// Permet d'effacer le texte du niveau coté interface
function deleteLevelDisplay()
	DeleteText(graphicsGameElements.levelLabel)
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
	definirLargeurArene()
	
	// On calcul le % en largeur pour un bloc
	graphicsGameElements.tailleBlocLargeurPourcent = graphicsGameElements.largeurArene / GRID_X
	
	// On calcul combien de pixel fait un bloc
	graphicsGameElements.tailleBlock = percentToPixelWidth(graphicsGameElements.tailleBlocLargeurPourcent)
	
	// On calcul combien de % fait un bloc en hauteur
	graphicsGameElements.tailleBlocHauteurPourcent = pixelToPercentHeight(graphicsGameElements.tailleBlock)
endfunction

// Genere les sprites pour chaque colonne et rang de block
function createBlockSprites()
	count as integer = 1
	y as integer
	x as integer
	
	for y = 1 to GRID_Y
		for x = 1 to GRID_X
			CreateSprite(count, blocksPicture.imageArray[0])
			SetSpriteSize(count, graphicsGameElements.tailleBlocLargeurPourcent, graphicsGameElements.tailleBlocHauteurPourcent)
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
function updateGridBlocks()
	count as integer = 1
	image as integer
	y as integer
	x as integer
	
	for y = 1 to GRID_Y 
		for x = 1 to GRID_X
			SetSpriteVisible(count, 1)
			
			select game.dataGrid.grid[x, y]
				case 0
					SetSpriteVisible(count,0)
				endcase
				case 1
					image = blocksPicture.imageArray[0]
				endcase
				case 2
					image = blocksPicture.imageArray[1]
				endcase
				case 3
					image = blocksPicture.imageArray[2]
				endcase
				case 4
					image = blocksPicture.imageArray[3]
				endcase
				case 5
					image = blocksPicture.imageArray[4]
				endcase
				case 6
					image = blocksPicture.imageArray[5]
				endcase
				case 7
					image = blocksPicture.imageArray[6]
				endcase
			endselect
			
			SetSpriteImage(count,image)
			SetSpriteSize(count, graphicsGameElements.tailleBlocLargeurPourcent, graphicsGameElements.tailleBlocHauteurPourcent)
			
			SetSpritePosition(count, graphicsGameElements.tailleBlocLargeurPourcent*x + graphicsGameElements.xOffset, graphicsGameElements.tailleBlocHauteurPourcent*y + graphicsGameElements.yOffset)
			inc count
		next x
	next y
	
endfunction

// Permet d'initialiser les coordonnées d'affichage des blocs,
// barres...
function initOffset()
	graphicsGameElements.xOffset = 35
	graphicsGameElements.yOffset = 0
	//~ graphicsGameElements.yOffset = (yScreen - GRID_Y * graphicsGameElements.tailleBlock)*100/yScreen
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
			setspritesize(count,graphicsGameElements.tailleBlocLargeurPourcent,graphicsGameElements.tailleBlocHauteurPourcent)
			SetSpritePhysicsOn(count,2)
			SetSpritePhysicsVelocity(count,random(-500,1000),random(-500,1000))
			SetSpriteShape(count,2)
			SetSpriteColorAlpha(count,50)
			inc count
		next x
		sync()
	next y

	game.mode = 1
	clearBlockSprites(blocksPicture)
	
	deleteScoreDisplay()
	deleteLevelDisplay()
endfunction

// Définit la largeur de l'arène grâce au facteur x
//
function definirLargeurArene()
	factor as integer = 1
	
	// On definit la largeur de l'arene
	while(yScreen < (xScreen / factor / GRID_X) * GRID_Y)
		factor = factor + 1
		graphicsGameElements.largeurArene = pixelToPercentWidth(xScreen/factor)
	endwhile
	
endfunction

// Définition de l'espace de jeu : 10 colonnes et 16 rangs
#constant GRID_X = 10
#constant GRID_Y = 22

Type dataGridGame	
	grid as integer[GRID_X, GRID_Y]
	
	preMoveShapeX as integer
	
	preMoveShapeY as integer
	
	// Colonne où ce trouve le premier block de la figure
	moveShapeX as integer
	
	// Ligne où ce trouve le premier block de la figure
	moveShapeY as integer
	
	// Score affiché dans l'interface (contient l'id)
	scoreDisplay as integer
	
	// Label du score
	scoreLabel as integer
	
	// Label du niveau
	levelLabel as integer
	
	// affichage du niveau en cours
	levelDisplay as integer
endtype

// Initialisation de la dataGrid
function dataGridGameSetup(game ref as TetrisGame)
	dataGrid as dataGridGame
	
	dataGrid.moveShapeX = 4
	dataGrid.moveShapeY = 1
	
	// Initialisation du score à 0
	game.score = 0
	
	// On charge les labels
	chargingLabels(dataGrid, game)
endfunction dataGrid

// Permet de nettoyer la grille
function clearGrid(dataGrid ref as dataGridGame)

x as integer
y as integer
i as integer

for x = 1 to GRID_X
	for y = 1 to GRID_Y
		dataGrid.grid[x,y] = 0
	next y
next x
for i = 1 to GRID_X
	dataGrid.grid[i, GRID_Y] = 1
next i
for i = 1 to GRID_Y
	dataGrid.grid[1,i] = 1
	dataGrid.grid[GRID_X,i] = 1
next i
endfunction

// Montre un texte de débogage
function displayGrid(dataGrid as dataGridGame)
	y as integer
	x as integer
	text as string
	for y = 1 to GRID_Y
		text = ""
		for x = 1 to GRID_X
			text = text + str(dataGrid.grid[x,y]) + ","
		next x
		print(text)
	next y
endfunction

function fillGrid(grid ref as integer[][], colNumb as integer, rowNumb as integer)
	col as integer
	x as integer
	y as integer
	
	for x = 1 to colNumb
		for y = 1 to rowNumb
			col = Random(0,7)
			grid[x,y] = col
		next y
	next x
endFunction

// Le principe de la fonction est le suivant :
// Une figure du jeu peut avoir des colonnes de 0, et donc ces dernières
// "rentrent" dans les autres blocs déja présent. Lorsque c'est le cas,
// on veux savoir (pour tourner) si les briques font partie d'un meme bloc.
function isSameShape(dataGrid as dataGridGame, currentShape as TetrisShape)
	sameShape as integer = 1
	i as integer
	j as integer
	blocInspect as integer
	shapeBloc as integer
	
	// On parcours de gauche à droite et de haut en bas sur une longueur
	// de 4 "briques" la grille à partir de là où ce situe la figure et on
	// regarde si il y'a correspondance avec notre figure
	for i = 1 to 4
		for j = 1 to 4
			if(dataGrid.moveShapeX + j - 1 <= 10 and dataGrid.moveShapeX + j - 1 >= 1)
				if (dataGrid.moveShapeY + i - 1 <= 16 and dataGrid.moveShapeY + i - 1 >= 1)
					blocInspect = dataGrid.grid[dataGrid.moveShapeX + j - 1, dataGrid.moveShapeY + i - 1]
					shapeBloc = Val(mid(currentShape.rotation[currentShape.moveShapeRotation, i], j, 1))
				endif
			endif
			if(blocInspect <> shapeBloc)
				sameShape = 0
			endif
		next j
	next i
endfunction sameShape


function deleteScoreDisplay(dataGrid ref as dataGridGame)
	DeleteText(dataGrid.scoreDisplay)
	DeleteText(dataGrid.scoreLabel)
endfunction

function deleteLevelDisplay(dataGrid ref as dataGridGame)
	DeleteText(dataGrid.levelDisplay)
	DeleteText(dataGrid.levelLabel)
endfunction

// Permet de charger les labels pour le score et le niveau
function chargingLabels(dataGrid ref as dataGridGame, game as TetrisGame)
	
	dataGrid.levelDisplay = CreateText(Str(game.level))
	dataGrid.levelLabel = CreateText("Niveau :")
	
	dataGrid.scoreDisplay = CreateText(Str(game.score))
	dataGrid.scoreLabel = CreateText("Score :")
	
	// Pour le score
	SetTextSize(dataGrid.scoreLabel, 30)
	SetTextPosition(dataGrid.scoreLabel, SCORE_LABEL_X, SCORE_LABEL_Y)
	SetTextColor(dataGrid.scoreLabel, 0,0,0,255)
	
	SetTextSize(dataGrid.scoreDisplay, 30)
	SetTextPosition(dataGrid.scoreDisplay, SCORE_POSITION_X, SCORE_POSITION_Y)
	SetTextColor(dataGrid.scoreDisplay, 0,0,0,255)
	//=============================
	
	// Pour le niveau
	SetTextSize(dataGrid.levelLabel, 30)
	SetTextPosition(dataGrid.levelLabel, LEVEL_LABEL_X, LEVEL_LABEL_Y)
	SetTextColor(dataGrid.levelLabel, 0,0,0,255)
	
	SetTextSize(dataGrid.levelDisplay, 30)
	SetTextPosition(dataGrid.levelDisplay, LEVEL_POSITION_X, LEVEL_POSITION_Y)
	SetTextColor(dataGrid.levelDisplay, 0,0,0,255)
	//======================================
endfunction

// Parcours la grille de nombre et affiche les blocks associés
function updateGrid(imageGrid as blocksGraphics, game as TetrisGame, 
					xOffset as integer, yOffset as integer)
	count as integer = 1
	image as integer
	y as integer
	x as integer
	xSpace as float

	// Définition de l'espace entre les blocks (espace horizontal) suivant
	// le format d'écran
	
	// ============================================================== //
	// =============== FORMAT 16/9 ================================== //
	//============================================================== //           
	if( xScreen/16  = yScreen/9)
		xSpace = 2.55
	endif
	
	
	// ============================================================== //
	// =============== FORMAT 4/3 ================================== //
	//============================================================== //   
	if( xScreen/4  = yScreen/3)
		xSpace = 3.8
	endif
	
	
	// ============================================================== //
	// ==================== INTEGRATION VERSION MOBILE ============== //
	// ============================================================== //
	
	// ============================================================== //
	// =============== FORMAT 9/19.5 ================================== //
	//============================================================== //  
	
	if( xScreen/9  = yScreen/19.5)
		xSpace = 9.8
	endif
	
	//
	// ============== FIN DEFINITION ===============================
	
	for y = 0 to GRID_Y - 1
		for x = 0 to GRID_X - 1
			SetSpriteVisible(count, 1)
			
			if game.dataGrid.grid[x+1, y+1] = 0
				SetSpriteVisible(count,0)
			elseif game.dataGrid.grid[x+1, y+1] = 1
				image = imageGrid.imageArray[0]
			elseif game.dataGrid.grid[x+1, y+1] = 2
				image = imageGrid.imageArray[1]
			elseif game.dataGrid.grid[x+1, y+1] = 3
				image = imageGrid.imageArray[2]
			elseif game.dataGrid.grid[x+1, y+1] = 4
				image = imageGrid.imageArray[3]
			elseif game.dataGrid.grid[x+1, y+1] = 5
				image = imageGrid.imageArray[4]
			elseif game.dataGrid.grid[x+1, y+1] = 6
				image = imageGrid.imageArray[5]
			elseif game.dataGrid.grid[x+1, y+1] = 7
				image = imageGrid.imageArray[6]
			endif
			
			SetSpriteImage(count,image)
			SetSpriteSize(count, -1, tailleBlocPourcent)
			SetSpritePosition(count, x*xSpace + xOffset, y*tailleBlocPourcent+yOffset)
			inc count
		next x
	next y
	
	// Actualisation du score
	SetTextString(game.dataGrid.scoreDisplay, Str(game.score))
	
	// Actualisation du level
	SetTextString(game.dataGrid.levelDisplay, Str(game.level))
endfunction

// Définition de l'espace de jeu : 10 colonnes et 22 rangs
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
endtype

// Initialisation de la dataGrid
function dataGridGameSetup(game ref as TetrisGame)
	dataGrid as dataGridGame
	
	dataGrid.moveShapeX = 4
	dataGrid.moveShapeY = 1
	
	// Initialisation du score à 0
	game.score = 0
	
	// On charge les labels
	//~ chargingLabels(dataGrid, game)
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

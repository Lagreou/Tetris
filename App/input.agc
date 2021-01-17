//=================================================//
// ================= DESCRIPTION ================= //
//=================================================//

//~ Fichier contenant le code permettant de gérer
//~ les entrées clavier du joueur et les mouvements
//~ associés

//=================================================//

// Fonction permettant de voir si un mouvement est autorisé
// dataGrid : grille où le jeu ce déroule
// shape : figure actuellement en train de tombée
function keychecks(dataGrid ref as dataGridGame, shape ref as TetrisShape)
	
	moveOk as integer = 0
	
	leftOk as integer
	
	// Permet de savoir si il faut changer
	changeShape as integer
	
	// Fleche de droite
	if GetRawKeyPressed(39) and isRightOk(shape, dataGrid) = 1
		moveOk = executeRightMove(dataGrid)
	endif
	
	// Fleche de gauche
	if GetRawKeyPressed(37) and isLeftOk(shape, dataGrid) = 1
		moveOk = executeLeftMove(dataGrid)
	endif
	
	// Fleche du haut : on regarde si la figure peux tourner,
	// sinon on détermine si elle bouge
	if GetRawKeyPressed(38)
		moveOk = executeRotationMove(dataGrid, shape)
	endif
	
	// Fleche du bas
	if GetRawKeyPressed(40)
		moveOk = executeBottomMove(dataGrid, shape)
	endif
	
endfunction moveOk

// Permet de définir la position des différents blocks dans la grille de jeu
// et de savoir si on doit effacer la figure à l'ancienne position
function moveMoveShape(shape ref as TetrisShape, dataGrid ref as dataGridGame, shapeClear as integer)
	
	i as integer
	cell as integer
	shapeLine as String
	
	// On regarde l'ancienne position des blocs afin de passe à 0
	if shapeClear = 1
		for i = 1 to 4
			
			shapeLine =  shape.rotation[shape.preMoveShapeRotation, i]
			cell = val(mid(shapeLine, 1,1))
			if cell<> 0
				dataGrid.grid[dataGrid.preMoveShapeX, dataGrid.preMoveShapeY+i - 1] = 0
			endif
			
			cell = val(mid(shapeLine, 2,1))
			if cell<> 0
				dataGrid.grid[dataGrid.preMoveShapeX+1, dataGrid.preMoveShapeY+i - 1] = 0
			endif
			
			cell = val(mid(shapeLine, 3,1))
			if cell<> 0
				dataGrid.grid[dataGrid.preMoveShapeX+2, dataGrid.preMoveShapeY+i - 1] = 0
			endif
			
			cell = val(mid(shapeLine, 4,1))
			if cell<> 0
				dataGrid.grid[dataGrid.preMoveShapeX+3, dataGrid.preMoveShapeY+i - 1] = 0
			endif
		next i
	endif
	
	// On dessine la figure dans à la nouvelle position
	for i = 1 to 4
		shapeLine = shape.rotation[shape.moveShapeRotation, i]
		
		cell = val(mid(shapeLine,1,1))	
		if cell <> 0
			dataGrid.grid[dataGrid.moveShapeX, dataGrid.moveShapeY+i -1] = cell
		endif
		
		cell = val(mid(shapeLine,2,1))		
		if cell <> 0
			dataGrid.grid[dataGrid.moveShapeX+1, dataGrid.moveShapeY+i -1] = cell
		endif
		
		cell = val(mid(shapeLine,3,1))		
		if cell <> 0
			dataGrid.grid[dataGrid.moveShapeX+2, dataGrid.moveShapeY+i -1] = cell
		endif
		
		cell = val(mid(shapeLine,4,1))	
		if cell <> 0
			dataGrid.grid[dataGrid.moveShapeX+3, dataGrid.moveShapeY+i -1] = cell
		endif	
	next i
	
	
	shapeClear =1 : dataGrid.preMoveShapeX = dataGrid.moveShapeX : dataGrid.preMoveShapeY = dataGrid.moveShapeY : shape.preMoveShapeRotation = shape.moveShapeRotation : shape.preShape = shape.shapeNumb
endfunction	shapeClear

// 
function executeLeftMove(dataGrid ref as dataGridGame)
	moveOk as integer
	dec dataGrid.moveShapeX
	moveOk = 2
endfunction moveOk

function executeRightMove(dataGrid ref as dataGridGame)
	moveOk as integer
	inc dataGrid.moveShapeX
	moveOk = 1
endfunction moveOk

function executeBottomMove(dataGrid ref as dataGridGame, shape ref as tetrisShape)
	moveOk as integer
	changeShape as integer = 0
	if changeshape = 0
			repeat
				inc dataGrid.moveShapeY
				changeShape = checkBelowShape(dataGrid, shape)
			until changeshape<>0
		endif
		moveOk = 4
endfunction moveOk

function executeRotationMove(dataGrid ref as dataGridGame, shape ref as tetrisShape)
	
	moveOk as integer
	move as integer 
		move = determinateDirection(shape, dataGrid)
		if move = -10
			// On joue un son
		else
			if(move <> 0)
				dataGrid.moveShapeX = dataGrid.moveShapeX + move
			endif
			
			inc shape.moveShapeRotation
			if shape.moveShapeRotation = 5
				shape.moveShapeRotation = 1
			endif
		endif
		moveOk = 3
endfunction moveOk

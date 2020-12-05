function keychecks(dataGrid ref as dataGridGame, shape ref as TetrisShape, changeShape as integer)
	
	moveOk as integer = 0
	
	leftOk as integer
	
	// Fleche de droite
	if GetRawKeyPressed(39) and isRightOk(shape, dataGrid) = 1
		inc dataGrid.moveShapeX
		moveOk = 1
	endif
	
	leftOk = isLeftOk(shape, dataGrid)
	
	// Fleche de gauche
	if GetRawKeyPressed(37) and leftOk = 1
		dec dataGrid.moveShapeX
		moveOk = 2
	endif
	
	// Fleche du haut : on regarde si la figure peux tourner,
	// sinon on détermine si elle bouge
	if GetRawKeyPressed(38)
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
	endif
	
	// Fleche du bas
	if GetRawKeyPressed(40)
		if changeshape = 0
			repeat
				inc dataGrid.moveShapeY
				changeShape = checkBelowShape(dataGrid, shape)
			until changeshape<>0
		endif
		moveOk = 4
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

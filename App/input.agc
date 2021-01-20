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
function executeMovementGiveByUser(dataGrid ref as DataGridGame, shape ref as TetrisShape)
	
	// Permet de savoir si un mouvement a été effectué.
	// 0 : pas de mouvement
	// 1 : droite
	// 2 : gauche
	// 3 : rotation
	// 4 : bas
	moveOk as integer = 0
	
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
function movingShape(shape ref as TetrisShape, dataGrid ref as DataGridGame, shapeClear as integer)
	
	// Indice de parcours des lignes
	i as integer
	
	// Cellule de la figure en train d'être parcouru
	cell as integer
	
	// Ligne en cours d'introspection
	shapeLine as String
	
	// On regarde l'ancienne position des blocs afin de passe à 0
	updateOldPosition(dataGrid, shape, shapeClear)
	
	// On dessine la figure dans à la nouvelle position
	updateNewPosition(dataGrid, shape)
	
	shapeClear =1 : dataGrid.preMoveShapeX = dataGrid.moveShapeX : dataGrid.preMoveShapeY = dataGrid.moveShapeY : shape.preMoveShapeRotation = shape.moveShapeRotation : shape.preShape = shape.shapeNumb
endfunction	shapeClear


// Remet à 0 les cases où la figure était avant le
// mouvement
function updateOldPosition(dataGrid ref as DataGridGame, shape as TetrisShape, shapeClear as integer)
	// Indice de parcours des lignes
	i as integer
	
	// Cellule de la figure en train d'être parcouru
	cell as integer
	
	// Ligne en cours d'introspection
	shapeLine as String
	
	// On vérifie qu'on doive bien effacer l'ancienne position
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
endfunction


// Permet de dessiner la figure dans la nouvelle position
// dans la grille
function updateNewPosition(dataGrid ref as DataGridGame, shape as TetrisShape)
	
	// Indice de parcours des lignes
	i as integer
	
	// Cellule de la figure en train d'être parcouru
	cell as integer
	
	// Ligne en cours d'introspection
	shapeLine as String
	
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
	
endfunction


// Bouge la figure à gauche et retourne 2
function executeLeftMove(dataGrid ref as DataGridGame)
	moveOk as integer
	dec dataGrid.moveShapeX
	moveOk = 2
endfunction moveOk


// Bouge la figure à droite et retourne 2
function executeRightMove(dataGrid ref as DataGridGame)
	moveOk as integer
	inc dataGrid.moveShapeX
	moveOk = 1
endfunction moveOk


// Bouge la figure vers le bas et retourne 4
function executeBottomMove(dataGrid ref as DataGridGame, shape ref as TetrisShape)
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


// Fait faire une rotation à la figure
function executeRotationMove(dataGrid ref as DataGridGame, shape ref as TetrisShape)
	
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

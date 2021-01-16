/*
Fichier contenant les fonctions permettant de voir si on peux bouger
la figure dans l'espace de jeu
*/

// ==================== METHODES "PUBLICS" SERVANT A L'EXTERIEUR  ============================= //
// ============================================================================================ //

// Fonction permettant de voir si on peux ce déplacer à gauche
function isLeftOk(shape as TetrisShape, dataGrid as dataGridGame)
	leftOk as integer = 1
	shapeLine as string
	i as integer
	j as integer
	checksX as integer[4] = [0,0,0,0,0]
	xPositions as integer[4] = [0,0,0,0,0]
	
	for i = 1 to 4
		shapeLine = shape.rotation[shape.moveShapeRotation, i]
		
		for j = 1 to 4
			if(checksX[i] = 0 and (Val(Mid(shapeLine,j,1)) <> 0))
				checksX[i] = j
			endIf
		next j
	next i
	
	// On trouve la position x des colonnes dans la grille
	for i = 1 to 4
		if(checksX[i] <> 0)
			xPositions[i] = dataGrid.moveShapeX + checksX[i] - 1
		endif
	next i
	
	// Pour chaque colonne, on regarde si le block entre en collision
	// avec d'autre blocks
	for i = 1 to 4
		if(checksX[i]<>0)
			if(dataGrid.grid[xPositions[i]-1, dataGrid.moveShapeY + i-1] <> 0)
				leftOk = 0 
			endif
		endif
	next i
	
endfunction leftOk

// Fonction permettant de voir si on peux ce déplacer à droite
function isRightOk(shape as TetrisShape, dataGrid as dataGridGame)
	rightOk as integer = 1
	shapeLine as string
	i as integer
	j as integer
	checksX as integer[4] = [0,0,0,0,0]
	xPositions as integer[4] = [0,0,0,0,0]
	
	for i = 1 to 4
		shapeLine = shape.rotation[shape.moveShapeRotation, i]
		
		// Pour chaque ligne, on trouve quelle colonne peut être en collision
		for j = 4 to 1 step -1
			if(Val(Mid(shapeLine,j,1)) <> 0 and checksX[i] = 0)
				checksX[i] = j
			endIf
		next j
	next i
	
	// On trouve la position x des colonnes dans la grille
	for i = 1 to 4
		if(checksX[i] <> 0)
			xPositions[i] = dataGrid.moveShapeX + checksX[i] - 1
		endif
	next i
	
	// Pour chaque colonne, on regarde si le block entre en collision
	// avec d'autre blocks
	for i = 1 to 4
		if(checksX[i]<>0)
			if(dataGrid.grid[xPositions[i]+1, dataGrid.moveShapeY + i-1] <> 0)
				rightOk = 0
			endif
		endif
	next i
	
endfunction rightOk

// Fonction permettant de voir si la figure peux descendre plus bas et
// retourne un booléen disant qu'il faut changer de figure si on ne peux pas descendre
// plus bas.
function checkBelowShape(dataGrid ref as dataGridGame, currentShape as TetrisShape)
	
	changeShape as integer = 0
	
	y1 as integer = 0
	y2 as integer = 0
	y3 as integer = 0
	y4 as integer = 0
	
	checky1 as integer
	checky2 as integer
	checky3 as integer
	checky4 as integer
	
	checky1 = currentShape.checks[currentShape.moveShapeRotation, 1]
	checky2 = currentShape.checks[currentShape.moveShapeRotation, 2]
	checky3 = currentShape.checks[currentShape.moveShapeRotation, 3]
	checky4 = currentShape.checks[currentShape.moveShapeRotation, 4]
	
	// TODO : changer la condition du and ! c'est sale !
	
	// Ici, les différents y représentent les blocks potentiellements "bloquant"
	// pour les différents points de collision de la figure
	if checky1 <> 0 and dataGrid.moveShapeY + checky1 <= 22
		y1 = dataGrid.grid[dataGrid.moveShapeX, dataGrid.moveShapeY+checky1]
	endif
	if checky2 <> 0 and dataGrid.moveShapeY + checky2 <= 22
		y2 = dataGrid.grid[dataGrid.moveShapeX+1, dataGrid.moveShapeY+checky2]
	endif
	if checky3 <> 0 and dataGrid.moveShapeY + checky3 <= 22
		y3 = dataGrid.grid[dataGrid.moveShapeX+2, dataGrid.moveShapeY+checky3]
	endif
	if checky4 <> 0 and dataGrid.moveShapeY + checky4 <= 22
		y4 = dataGrid.grid[dataGrid.moveShapeX+3, dataGrid.moveShapeY+checky4]
	endif
	
	if y1 + y2 + y3 + y4 <> 0
		changeShape = 1
	endif
	
endFunction changeShape


// Permet de déterminer la direction pour bouger la figure si colision
// - nbcases pour la gauche, 0 pour pas changer de place et nbCases pour aller à droite
// - 10 pour ne pas que ça bouge
function determinateDirection(shape as tetrisShape, dataGrid as dataGridGame)
	
	// ================ DECLARATIONS =================
	
	ligne as integer = 1
	
	colonne as integer = 1
	
	// Direction vers laquelle aller
	direction as integer = 0
	
	// Permet de dire si on a trouver une collision
	trouver as integer = 0
	
	// Tableau contenant les blocs où il risque d'y avoir une colision
	// Ici, on s'en sert pour savoir précisement où les collision ont été détectées.
	tabCollision as integer[4,4]
	 
	// ================= INSTRUCTIONS =====================	
	
	tabCollision = getArrayColide(shape)
	
	// On regarde précisément quels blocs sont en collisions
	if(isShapeColideOther(shape, dataGrid, tabCollision))	
		repeat
			colonne = 1
			repeat
				// On regarde si tabCollision = vrai à l'indice donné et si la case lui correspondant dans la grille de jeu
				// est déja prise par un bloc
				if(tabCollision[ligne,colonne] = 1 and dataGrid.grid[dataGrid.moveShapeX + colonne - 1, dataGrid.moveShapeY + ligne - 1] <> 0)
					trouver = 1
				else
					
				endif
				if(trouver = 0)	
					inc colonne
				endif			
			until(colonne > 4 or trouver = 1 or dataGrid.moveShapeX + colonne - 1 > 10)
			
			if(trouver = 0)
				inc ligne
			endif	
		until(ligne > 4 or trouver = 1)
	else
		direction = 0
	endif
	
	if(trouver = 1)
		// On regarde si on il y'a colision à droite de la figure, auquel cas on regarde si on
		// on aller à gauche
		if(isColideAtRight(shape,colonne))
			direction = isLeftColideAfterMove(shape, tabCollision, dataGrid)
		// On regarde si on il y'a colision à gauche de la figure, auquel cas on regarde si on
		// on aller à droite
		elseif(isColideAtLeft(shape,colonne))
			direction = isRightColideAfterMove(shape, tabCollision, dataGrid)
		else
			direction = -10
		endif
	endif

endfunction direction

// ==================== METHODES "PRIVES" SERVANT UNIQUEMENT AUX FONCTIONS AU DESSUS ========== //
// ============================================================================================ //

function isShapeColideOther(shape as tetrisShape, dataGrid as dataGridGame, tabCollision as integer[][])

// ================ DECLARATIONS =================

// Permet de dire si la figure en percute une autre
isColide as integer = 0

// Permet de boucler sur les lignes
ligne as integer

// Permet de boucler sur les colonnes
colonne as integer

// ================= INSTRUCTIONS =====================	

for ligne = 1 to 4
	for colonne = 1 to 4
		// On regarde si tabCollision = vrai à l'indice donné et si la case lui correspondant dans la grille de jeu
		// est déja prise par un bloc
		if(dataGrid.moveShapeX + colonne -1 >= 1 and dataGrid.moveShapeX + colonne -1 <= 10)
			if(tabCollision[ligne,colonne] = 1 and dataGrid.grid[dataGrid.moveShapeX + colonne - 1, dataGrid.moveShapeY + ligne - 1] <> 0)
				if(not isSameShape(dataGrid, shape))
					isColide = 1
				endif
			endif
		endif
	next colonne
next ligne

endfunction isColide

function isColideAtRight(shape as tetrisShape, colonne as integer)
	
	isColide as integer = 0
	
	// Tableau contenant la première et dernière colonne ayant un bloc
	tabCol as integer[2]
	
	// ================= INSTRUCTIONS =====================	
	tabCol = determinerColonnes(shape)
	
	if(tabCol[1] <> tabCol[2] and colonne >= tabCol[2])
		isColide = 1
	elseif(tabCol[1] = tabCol[2] and colonne >= tabCol[1])
		isColide = 1
	endif
endfunction isColide

function isColideAtLeft(shape as tetrisShape, colonne as integer)	
	
	isColide as integer = 0
	
	// Tableau contenant la première et dernière colonne ayant un bloc
	tabCol as integer[2]
	
	// ================= INSTRUCTIONS =====================	
	tabCol = determinerColonnes(shape)
	
	if(tabCol[1] <> tabCol[2] and colonne <= tabCol[2])
		isColide = 1
	elseif(tabCol[1] = tabCol[2] and colonne <= tabCol[1])
		isColide = 1
	endif
endFunction isColide

// renvoi 0 si la figure en cogne une autre en bougeant à droite, sinon
// renvoi le nombre de case dont la figure doit bouger
function isRightColideAfterMove(shape as tetrisShape, tabCollision as integer[][], dataGrid as dataGridGame)
	
	dataGridFuture as dataGridGame 
	
	ligne as integer
	
	colonne as integer
	
	// Nombre de bloc que cogne la figure (permet de déterminer le nombre de case
	// pour bouger
	nbColision as integer = 0
	
	// On compte le nombre de collision réelle
	for ligne = 1 to 4
		for colonne = 1 to 4
			// On regarde si le bloc dépasse du tableau :
			// auquel cas il faut compter le bloc si présent
			if(dataGrid.moveShapeX + colonne -1 >= 1 and dataGrid.moveShapeX + colonne -1 <= 10)
				// On regarde si tabCollision = vrai à l'indice donné et si la case lui correspondant dans la grille de jeu
				// est déja prise par un bloc
				if(tabCollision[ligne,colonne] = 1 and dataGrid.grid[dataGrid.moveShapeX + colonne - 1, dataGrid.moveShapeY + ligne - 1] <> 0)
					inc nbColision
				endif
			else
				// Si on dépasse : on regarde si un bloc
				// est présent physiquement dans la figure, auquel
				// cas il faut le compter
				if(tabCollision[ligne,colonne] = 1)
					inc nbColision
				endif
			endif
		next colonne
	next ligne
	
	// ------ On regarde si le déplacement est réellement faisable	 -----
	
	// on bouge l'indice X de la figure
	inc dataGrid.moveShapeX, nbColision
	
	// Copie
	dataGridFuture = dataGrid
	
	// On applique la transition dans la grille
	//("mise à jour position figure dans la grille")
	moveMoveShape(shape,dataGridFuture,1)
	
	// On regarde si colision, auquel cas on retourne 0
	if isShapeColideOther(shape, dataGridFuture, tabCollision)
		nbColision = 0
	endif
	
endfunction nbColision

// renvoi 0 si la figure en cogne une autre en bougeant à gauche, sinon
// renvoi le nombre de case dont la figure doit bouger
function isLeftColideAfterMove(shape as tetrisShape, tabCollision as integer[][], dataGrid as dataGridGame)
	
	dataGridFuture as dataGridGame 
	
	ligne as integer
	
	colonne as integer
	
	nbColision as integer = 0
	
	// On compte le nombre de collision réelle
	for ligne = 1 to 4
		for colonne = 1 to 4
			// On regarde si tabCollision = vrai à l'indice donné et si la case lui correspondant dans la grille de jeu
			// est déja prise par un bloc
			if(dataGrid.moveShapeX + colonne -1 >= 1 and dataGrid.moveShapeX + colonne -1 <= 10)
				if(tabCollision[ligne,colonne] = 1 and dataGrid.grid[dataGrid.moveShapeX + colonne - 1, dataGrid.moveShapeY + ligne - 1] <> 0)
					inc nbColision 
				endif
			else
				// Si on dépasse : on regarde si un bloc
				// est présent physiquement dans la figure, auquel
				// cas il faut le compter
				if(tabCollision[ligne,colonne] = 1)
					inc nbColision
				endif
			endif
		next colonne
	next ligne
	
	// On regarde si le déplacement est réellement faisable
	
	// on bouge l'indice X de la figure
	dec dataGrid.moveShapeX, nbColision
	
	// Copie
	dataGridFuture = dataGrid
	
	// On applique la transition dans la grille
	//("mise à jour position figure dans la grille")
	moveMoveShape(shape,dataGridFuture,1)
	
	// On regarde si colision, auquel cas on retourne 0
	if isShapeColideOther(shape, dataGridFuture,tabCollision)
		nbColision = 0
	endif
	
endfunction -nbColision

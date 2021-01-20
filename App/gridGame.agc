//=================================================//
// ================= DESCRIPTION ================= //
//=================================================//

//~ Fichier contenant le code permettant de gérer
//~ la grille au niveau des données.
//~ Cette grille contient les chiffres représentant
//~ les blocs

//=================================================//

//=================================================//
// ================= CONSTANTES ================= //
//=================================================//

// Définition de l'espace de jeu : 10 colonnes et 22 rangs
#constant GRID_X = 10
#constant GRID_Y = 22


//=================================================//
// ================= TYPES ======================= //
//=================================================//

// Type représentant la grille de jeu au niveau des données.
Type DataGridGame
	// La grille contenant les chiffres qui représente
	// les blocs ou leur absence	
	grid as integer[GRID_X, GRID_Y]
	
	// Colonne où se trouvait le premier bloc de la figure
	// avant un mouvement
	preMoveShapeX as integer
	
	// Ligne où se trouvait le premier bloc de la figure
	// avant un mouvement
	preMoveShapeY as integer
	
	// Colonne où ce trouve le premier bloc de la figure
	moveShapeX as integer
	
	// Ligne où ce trouve le premier bloc de la figure
	moveShapeY as integer
endtype


//=================================================//
// ================= FONCTIONS ================= //
//=================================================//

// Permet d'initialiser la grille de jeu
function dataGridGameSetup()
	dataGrid as dataGridGame
	
	dataGrid.moveShapeX = 4
	dataGrid.moveShapeY = 1
endfunction dataGrid

// Permet de nettoyer la grille (remettre à 0 tous les blocs)
// et mettre à 1 tous les bloc délimitant l'aire de jeu
function clearGrid(dataGrid ref as dataGridGame)

// indice x
x as integer

// indice y
y as integer

// indice servant à l'initialisation
// ligne fond + 1ère et dernière colonne
i as integer

for x = 1 to GRID_X
	for y = 1 to GRID_Y
		dataGrid.grid[x,y] = 0
	next y
next x

// On met les blocs à 1 pour la ligne du fond
for i = 1 to GRID_X
	dataGrid.grid[i, GRID_Y] = 1
next i

// On met les blocs à 1 pour la première et dernière
// colonne
for i = 1 to GRID_Y
	dataGrid.grid[1,i] = 1
	dataGrid.grid[GRID_X,i] = 1
next i
endfunction

// Le principe de la fonction est le suivant :
// Une figure du jeu peut avoir des colonnes de 0, et donc ces dernières
// "rentrent" dans les autres blocs déja présent. Lorsque c'est le cas,
// on veux savoir (pour tourner) si les briques font partie d'un meme bloc.
// dataGrid : grille du jeu
// currentShape : figure étant en train de tomber.
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

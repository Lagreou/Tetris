#constant IMAGES_COLOR = 7

Type graphicGrid
	imageArray as integer[IMAGES_COLOR]
endtype


// Charge l'image appropriée dans chaque block
function initImages()
	tabImage as graphicGrid
	
	tabImage.imageArray[0] = loadImage("red.png")
	tabImage.imageArray[1] = loadImage("orange.png")
	tabImage.imageArray[2] = loadImage("pink.png")
	tabImage.imageArray[3] = loadImage("black.png")
	tabImage.imageArray[4] = loadImage("blue.png")
	tabImage.imageArray[5] = loadImage("green.png")
	tabImage.imageArray[6] = loadImage("purple.png")
endfunction tabImage

// Genere les sprites pour chaque colonne et rang de block
function createBlockSprites(tabImage ref as graphicGrid)
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

// Test d'un commentaire pour git
function clearBlockSprites(tabImage ref as graphicGrid, gridX as integer, gridY as integer)
	count as integer = 1
	y as integer
	x as integer
	
	for y = 1 to gridY
		for x = 1 to gridX
			DeleteSprite(count)
			DeleteImage(count)
			inc count
		next x
	next y
endfunction

// Parcours la grille de nombre et affiche les blocks associés
function updateGrid(imageGrid as graphicGrid, game as TetrisGame, 
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
		xSpace = 3.4
	endif
	
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

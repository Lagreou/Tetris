Type blocksGraphics
	imageArray as integer[IMAGES_COLOR]
endtype

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
function initBlocDisplay()
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

// Trouve une ligne complète et prête à être effacée
// Descent les lignes au dessus de cette dernière
// Recherche encore des lignes à descendre
// Répéter tant que tout n'est pas fini

function effacerLignes(gridY as integer, gridX as integer, game ref as TetrisGame )
	lineNumb as integer // Nombre de ligne a effacer
	lines as integer[GRID_Y]
	yline as integer
	movey as integer
	xline as integer
	
	lineNumb = regarderLignes(gridX, game.dataGrid, lines)
	
	if lineNumb = 1
		inc game.score, 10 * game.level
	elseif lineNumb > 1
		inc game.score, lineNumb * 10 * 2 * game.level
	endif
	
	yline = gridY - 1
	Repeat
		// Ligne pleine ?
		if lines[yline] = 0
			// Elle est pleine => on efface la ligne et on descend celle du dessus
			for movey = yline to 1 step - 1
				for xline = 2 to gridx - 1
					game.dataGrid.grid[xline,movey] = game.dataGrid.grid[xline,movey-1]
				next xline
			next movey
			
			// On augmente le score
			playsound(deleteLineSound)
			
			//~ if dataGrid.score = 0
				//~ inc dataGrid.score
			//~ else
				//~ dataGrid.score = dataGrid.score*2
			//~ endif
			// Ici, on a abaisser les blocks donc on doit reregarder
			// les blocks a effacée car la première fois qu'on a regarder,
			// la grille était différente
			regarderLignes(gridX, game.dataGrid, lines)
			yline=gridy-1
		else
			dec yline
			// playsound(1)
		endif
	until yline=1
endfunction


// On regarde si les lignes sont remplies de blocks
// Modifie directement le tableau contenant le marquage des lignes a effacer
// et retourne le nombre de lignes qui seront effacées
function regarderLignes(gridX as integer, dataGrid as dataGridGame, tabLines ref as integer[])
	lineNumb as integer = 0// Nombre de ligne à effacer
	y as integer 
	x as integer
	lines as integer[GRID_Y]
	
	for y = 1 to GRID_Y - 1
		line as integer = 0

		// Si on a des 0 sur une ligne, la ligne n'est pas complète
		for x = 2 to gridX - 1
			if dataGrid.grid[x,y] = 0
				line = 1
				exit
			endif
		next x
		
		// On incrémente de 1 le nombre de lignes qui seront à effacer
		if line = 0
			inc lineNumb
		endif
		
		//si lines[y]=0 alors la ligne est marquée pour être effacée
		tabLines[y]=line
	next y
endfunction lineNumb

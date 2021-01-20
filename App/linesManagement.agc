// Trouve une ligne complète et prête à être effacée
// Descent les lignes au dessus de cette dernière
// Recherche encore des lignes à descendre
// Répéter tant que tout n'est pas fini
function effacerLignes()
	
	// nombre de lignes à effacer
	lineNumbToDelete as integer
	
	// Représente les lignes qui doivent être
	// effacées
	linesToDelete as integer[GRID_Y]
	
	// Représente le numéro de ligne
	lineNumber as integer
	movey as integer
	xline as integer
	
	lineNumbToDelete = regarderLignes(game.dataGrid, linesToDelete)
	
	if lineNumbToDelete = 1
		// On met à jour le score
		inc game.score, 10 * game.level
	elseif lineNumbToDelete > 1
		// On met à jour le score mais on multiplie par 2 avec le nombre de ligne
		inc game.score, lineNumbToDelete * 10 * 2 * game.level
	endif
	
	// On met à jour le label
	scoreLabelUpdate(game.score)
	
	lineNumber = GRID_Y - 1
	Repeat
		// Ligne pleine ?
		if linesToDelete[lineNumber] = 0
			// Elle est pleine => on efface la ligne et on descend celle du dessus
			for movey = lineNumber to 1 step - 1
				for xline = 2 to GRID_X - 1
					game.dataGrid.grid[xline,movey] = game.dataGrid.grid[xline,movey-1]
				next xline
			next movey
			
			playsound(deleteLineSound)
			
			regarderLignes(game.dataGrid, linesToDelete)
			lineNumber = GRID_Y-1
		else
			dec lineNumber
			// playsound(1)
		endif
	until lineNumber = 1
endfunction


// On regarde si les lignes sont remplies de blocks
// Modifie directement le tableau contenant le marquage des lignes a effacer
// et retourne le nombre de lignes qui seront effacées
function regarderLignes(dataGrid as dataGridGame, tabLines ref as integer[])
	lineNumb as integer = 0// Nombre de ligne à effacer
	y as integer 
	x as integer
	lines as integer[GRID_Y]
	
	for y = 1 to GRID_Y - 1
		line as integer = 0

		// Si on a des 0 sur une ligne, la ligne n'est pas complète
		for x = 2 to GRID_X - 1
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

/*
 Type représentant une figure dans le jeu
*/
type tetrisShape
	
	// Numéro de la figure
	shapeNumb as integer
	
	// tableau représentant la forme selon la rotation
	// indice 1 : rotation
	// indice 2 : num ligne de la rotation
	rotation as string[4,4]
	
	// Permet de voir selon les colonnes à quel bit est détecté la collision selon la rotation
	// exemple : checks[1,1] permet de voir la colonne 1 de la rotation 1. Si colonne 1 = 3, alors c'est
	// au 3eme rang que la colision est détectée
	checks as integer[4,4]
	
	// Rotation en cours
	moveShapeRotation as integer
	
	preMoveShapeRotation as integer
	
	preShapeX as integer
	
	preShapeY as integer
	
	preShape as integer
	
	// Position où se trouve le premier block (colonne)
	shapeX as integer
	
	// Position où se trouve le premier block (ligne)
	shapeY as integer
	
endtype


// ============== FONCTIONS =================== //

function setupShapes()
	shapesSetup as TetrisShape[7]
	i as integer
	
	// 1ère dimension : figure
	// 2ème dimension : rotation
	// 3ème dimension : numéro de ligne
	
	for i = 1 to shapesSetup.length
		shapesSetup[i].shapeNumb = i
		
		select i
			case 1
				// ======= Figure I =========
				shapesSetup[i].rotation[1] = ["","0100", "0100", "0100", "0100"]
				shapesSetup[i].rotation[2] = ["","0000", "1111", "0000", "0000"]
				shapesSetup[i].rotation[3] = ["","0010", "0010", "0010", "0010"]	
				shapesSetup[i].rotation[4] = ["","0000", "0000", "1111", "0000"]
				
				shapesSetup[i].checks[1] = [0,0,4,0,0]
				shapesSetup[i].checks[2] = [0,2,2,2,2]
				shapesSetup[i].checks[3] = [0,0,0,4,0]
				shapesSetup[i].checks[4] = [0,3,3,3,3]			
			endcase
			
			case 2
				// ======= Figure O =========
				shapesSetup[i].rotation[1] = ["","0000", "0220", "0220", "0000"]
				shapesSetup[i].rotation[2] = ["","0000", "0220", "0220", "0000"]
				shapesSetup[i].rotation[3] = ["","0000", "0220", "0220", "0000"]			
				shapesSetup[i].rotation[4] = ["","0000", "0220", "0220", "0000"]
				
				shapesSetup[i].checks[1] = [0,0,3,3,0]
				shapesSetup[i].checks[2] = [0,0,3,3,0]
				shapesSetup[i].checks[3] = [0,0,3,3,0]
				shapesSetup[i].checks[4] = [0,0,3,3,0]
			endcase
			
			case 3
				// ======= Figure L =========
				shapesSetup[i].rotation[1] = ["","3300", "0300", "0300", "0000"]
				shapesSetup[i].rotation[2] = ["","0030", "3330", "0000", "0000"]
				shapesSetup[i].rotation[3] = ["","0300", "0300", "0330", "0000"]
				shapesSetup[i].rotation[4] = ["","0000", "3330", "3000", "0000"]
				
				shapesSetup[i].checks[1] = [0,1,3,0,0]
				shapesSetup[i].checks[2] = [0,2,2,2,0]
				shapesSetup[i].checks[3] = [0,0,3,3,0]
				shapesSetup[i].checks[4] = [0,3,2,2,0]
			endcase
							
			case 4
				// ======= Figure J =========
				shapesSetup[i].rotation[1] = ["","0440", "0400", "0400", "0000"]
				shapesSetup[i].rotation[2] = ["","0000", "4440", "0040", "0000"]
				shapesSetup[i].rotation[3] = ["","0400", "0400", "4400", "0000"]		
				shapesSetup[i].rotation[4] = ["","4000", "4440", "0000", "0000"]
				
				shapesSetup[i].checks[1] = [0,0,3,1,0]
				shapesSetup[i].checks[2] = [0,2,2,3,0]
				shapesSetup[i].checks[3] = [0,3,3,0,0]
				shapesSetup[i].checks[4] = [0,2,2,2,0]
			endcase
								
			case 5
				// ======= Figure T =========
				shapesSetup[i].rotation[1] = ["","0500", "5550", "0000", "0000"]
				shapesSetup[i].rotation[2] = ["","0500", "0550", "0500", "0000"]
				shapesSetup[i].rotation[3] = ["","0000", "5550", "0500", "0000"]
				shapesSetup[i].rotation[4] = ["","0500", "5500", "0500", "0000"]
				
				shapesSetup[i].checks[1] = [0,2,2,2,0]
				shapesSetup[i].checks[2] = [0,0,3,2,0]
				shapesSetup[i].checks[3] = [0,2,3,2,0]
				shapesSetup[i].checks[4] = [0,2,3,0,0]
			endcase
								
			case 6
				// ======= Figure Z =========
				shapesSetup[i].rotation[1] = ["","0600", "6600", "6000", "0000"]
				shapesSetup[i].rotation[2] = ["","6600", "0660", "0000", "0000"]
				shapesSetup[i].rotation[3] = ["","0060", "0660", "0600", "0000"]
				shapesSetup[i].rotation[4] = ["","0000", "6600", "0660", "0000"]
				
				shapesSetup[i].checks[1] = [0,3,2,0,0]
				shapesSetup[i].checks[2] = [0,1,2,2,0]
				shapesSetup[i].checks[3] = [0,0,3,2,0]
				shapesSetup[i].checks[4] = [0,2,3,3,0]
			endcase
			
			case 7
				// ======= Figure S =========	
				shapesSetup[i].rotation[1] = ["","0700", "0770", "0070", "0000"]
				shapesSetup[i].rotation[2] = ["","0770", "7700", "0000", "0000"]
				shapesSetup[i].rotation[3] = ["","0700", "0770", "0070", "0000"]
				shapesSetup[i].rotation[4] = ["","0000", "0770", "7700", "0000"]
				
				shapesSetup[i].checks[1] = [0,0,2,3,0]
				shapesSetup[i].checks[2] = [0,2,2,1,0]
				shapesSetup[i].checks[3] = [0,0,2,3,0]
				shapesSetup[i].checks[4] = [0,3,3,2,0]
			endcase
		endselect
		
		shapesSetup[i].moveShapeRotation = 1
	next i
	
endfunction shapesSetup

// Permet de déterminer la première et la dernière colonne
// pour lesquelles des blocks sont présents pour la rotation
// actuelle
function determinerColonnes(shape as TetrisShape)
	tabCol as integer[2]
	i as integer = 1
	find as integer = 0
	
	// Repérage de la première colonne
	repeat
		if(shape.moveShapeRotation <= 4 and shape.checks[shape.moveShapeRotation, i] <> 0)
			tabCol[1] = i
			find = 1
		endif
		inc i
	until find <> 0 or i >= 4
	
	// reinitialisation de find + i
	find = 0
	i = 4
	
	// Repérage de la dernière colonne
	repeat
		if(shape.moveShapeRotation <= 4 and shape.checks[shape.moveShapeRotation, i] <> 0)
			tabCol[2] = i
			find = 1
		endif
		dec i
	until find <> 0 or i <= 1
	
endfunction tabCol

// Renvoi un tableau 2 dimensions (colonnes / lignes)
// permettant de savoir où il y'a risque de colision
function getArrayColide(shape as TetrisShape)
	
	// ============= DECLARATION DES VARIABLES =============== //
	
	// Tableau final indiquant si risque de colision ou non
	// (0 pour non, 1 pour vrai)
	tabFinal as integer[4,4]
	
	// Compteur pour les lignes
	ligne as integer
	
	// Compteur pour les colonnes
	colonne as integer
	
	// Rotation actuelle
	rotationActuelle as integer
	
	// Rotation future
	rotationFuture as integer
	
	// ============= INITIALISATIONS ================== //
	
	// Initialisation des rotations
	rotationActuelle = shape.moveShapeRotation
	
	// Initialisation de la rotation future
	if(shape.moveShapeRotation = 4)
		rotationFuture = 1
	else
		rotationFuture = shape.moveShapeRotation + 1
	endif
	// ============== INSTRUCTION PRINCIPALES ========= //
	
	// Début des comparaisons
	// On parcours les lignes
	for ligne = 1 to 4
		// Ligne de la rotation actuelle
		ligneActuelle as String
		
		// Ligne de la rotation future
		ligneFuture as String
		
		// Stockage des lignes pour analyser à la prochaine boucle
		ligneActuelle = shape.rotation[rotationActuelle, ligne]
		
		ligneFuture = shape.rotation[rotationFuture, ligne]
		
		for colonne = 1 to 4
			// Pas de risque de collision (attention, ici contraire de la logique booléenne : 0 = vrai (vue que le bloc est vide), 1 = faux
			if  ((Val(Mid(ligneActuelle, colonne, 1)) <> 0 and Val(Mid(ligneFuture, colonne, 1)) = 0) or (Val(Mid(ligneActuelle, colonne, 1)) = 0 and Val(Mid(ligneFuture, colonne, 1)) = 0) or (Val(Mid(ligneActuelle, colonne, 1)) <> 0 and Val(Mid(ligneFuture, colonne, 1)) <> 0))
				// Par contre, ici on revient à une logique booléenne
				tabFinal[ligne,colonne] = 0
			// risque de collision
			else
				tabFinal[ligne,colonne] = 1
			endif	
		next colonne
	next ligne
endfunction tabFinal

// Charger le bon fichier contenant les résolutions selon
// l'appareil sur lequel le jeu est chargé
function chargingDeviceDisplayFile()
	deviceName as string
	
	deviceName = GetDeviceBaseName()
	
	select deviceName
		
		case "android"
			displayFile = OpenToRead("readingFiles/androidDisplay.datagames")
		endcase
		
		case "windows"
			displayFile = OpenToRead("readingFiles/windowsDisplay.datagames")
		endcase
	
	endselect
endfunction

// Permet d'initialiser la variable recherchée
function initTargetValue(targetValue as string)
	
	// Représente la ligne courante
	currentLine as string
 
	while(not FileEOF(displayFile))
		currentLine = ReadLine(displayFile)
		
		if(currentLine = targetValue)
			// On parcours les diverses résolutions jusqu'à la fin de la catégorie
			//xSpace = getValueWithCategorieParcour()
		endif
	endwhile
endfunction

// Parcours des résolution d'affichage jusqu'à la fin
// de la catégorie en cours de parcours
// La valeur de la variable est retournée lorsque trouvée
function getValueWithCategorieParcour()
	currentLine as string
	obtaindValue as float
	isGoodResolution as integer
		
	repeat
		currentLine = ReadLine(displayFile)
		
		// On regarde si la valeur correspond à une resolution
		if(Left(currentLine, 2) = "~~")
			// si ok => on récupère et on regarde si correspond avec actuelle
			isGoodResolution = comparerResolutionActuelleAvecFichier(currentLine)
			// si correspond avec actuelle => on récupère la valeur
			if(isGoodResolution)
				obtaindValue = ValFloat(ReadLine(displayFile))
			endif
		endif
	until(isCategorieEnding(currentLine) or FileEOF(displayFile))
endfunction obtaindValue

// Permet de regarder si on arrive à la fin d'une
// catégorie dans le fichier
function isCategorieEnding(line as string)
	result as integer = 0
	
	if(Left(line,1) = "#")
		result = 1
	endif
	
endfunction result

// Permet de comparer la résolution sur laquelle on est
// dans le fichier (ligne passée en paramètre)
// retourne vrai si c'est la bonne résolution
function comparerResolutionActuelleAvecFichier(resolution as string)
	isOk as integer = 0
	currentLine as string
	displayValues as float[2]
	i as integer 
	
	currentLine = resolution
	
	// On regarde qu'on à bien un / (si = 0, il n'y a obligatoirement
	// pas de caractère "/", alors que oui si > 0)
	// On récupère les valeurs si ok
	if(CountStringTokens2(currentLine, "/") > 0)
		// On élimine le symbole ~~ afin qu'il ne gêne pas pour
		// la récupération de la première valeur
		// => On récupère tous les caractère de droite - les 2 premiers
		currentLine = Right(currentLine, len(currentLine) - 2)
		for i = 1 to 2 step 1
			displayValues[i] = ValFloat(GetStringToken(currentLine,"/",i))
		next i 
	endif
	
	// On compare les valeurs extraites
	// avec notre résolution
	// dans le fichier, c'est forcément l'ordre longueur / largeur
	// (le plus grand on premier), c'est pour cela qu'on regarde si
	// la largeur de l'écran est plus grande que la hauteur)
	if(xScreen > yScreen)
		if(xScreen/displayValues[1] = yScreen/displayValues[2])
			isOk = 1
		endif
	else
		if(yScreen/displayValues[1] = xScreen/displayValues[2])
			isOk = 1
		endif
	endif
	 
endfunction isOk

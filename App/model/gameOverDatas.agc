//=================================================//
// ================= TYPES ======================= //
//=================================================//

type GameOverDatas
	// contient les scores (top 10)
	scores as integer[10]
	
	// contient les noms (top 10)
	scoreNames as integer[10]	
endtype

// =============================================================== //
// ================ VARIABLES GLOBALES ========================== //
// ============================================================== //

global gameOverData as GameOverDatas

// ===============================================
// ================= FONCTIONS ===================
//================================================

function chargingScores()
	scoreFile as integer
	currentLine as integer
	
	i as integer = 1
	
	// Chargement du fichier
	scoreFile = chargingScoreFile()
	
	// On charge le top 10 
	while(FileEOF(scoreFile))
		
		currentLine = ReadLine(scoreFile)
		
		// On charge le nom pour ce score
		scoreNames[i] = GetStringToken(currentLine, ";", 1)
		
		// On charge le score de la personne
		scores[i] = GetStringToken(currentLine, ";", 2)
		
		inc i, 1
	endwhile
endfunction



function chargingScoreFile()
	scoreFile as integer
	scoreFile = OpenToRead("readingFiles/score.datagames")
endfunction scoreFile

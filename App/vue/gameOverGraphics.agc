// Permet d'inclure la dialogBox
#include "utils/utils.agc"

//=================================================//
// ================= TYPES ======================= //
//=================================================//

type GameOverGraphics
		dialogName as DialogType
		
		playerNamesScores as integer[10]
		
		textScores as integer[10]
endType

// =============================================================== //
// ================ VARIABLES GLOBALES ========================== //
// ============================================================== //

global gameOverGraph as GameOverGraphics

// ===============================================
// ================= FONCTIONS ===================
//================================================

function displayScores()
	for i = 1 to 10 step 1
		playerNamesScores[i] = CreateText(gameOverData.scoreNames[i])
		textScores[i] = CreateText(gameOverData.scores[i])
	

	next i
	
	
endfunction

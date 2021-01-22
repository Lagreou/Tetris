// Fichier permettant de gérer le menu du jeu
// Gère les interaction du joueur avec le menu

//~ // ===============================================
//~ // ================= TYPES =======================
//~ //================================================
//~ type GameMenu
	//~ 
	//~ 
//~ endtype
//~ 
//~ // ===============================================
//~ // ================= VARIABLES GLOBALES ==========
//~ //================================================
//~ 
//~ global menu as GameMenu

// ===============================================
// ================= FONCTIONS ===================
//================================================

// Regarde sur quel bouton le joueur appuie
function interceptClickedButton()
	if GetVirtualButtonPressed(menuInterface.exitButton)
		end
	endif
	if GetVirtualButtonPressed(menuInterface.playButton)
		game.mode = 2
	endif
	if GetVirtualButtonPressed(menuInterface.optionsButton)
		goToOptionsFromMenu()
		game.mode = 3
	endif
endfunction

function goToOptionsFromMenu()
	
	// Déplacer le chargement car si dans le mauvais ordre
	// peut provoquer des bugs
	dechargerSpritesAccueil()	
	
	chargerInterfaceGraphicsOptions()
endfunction

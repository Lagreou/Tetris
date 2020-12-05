function setupShapes()
	shape as string[7,4,4]
	
	// 1ère dimension : figure
	// 2ème dimension : rotation
	// 3ème dimension : numéro de ligne
	
	// ======= Figure I =========
	
	shape[1,1,1] = "0100"
	shape[1,1,2] = "0100"
	shape[1,1,3] = "0100"
	shape[1,1,4] = "0100"
	
	shape[1,2,1] = "0000"
	shape[1,2,2] = "1111"
	shape[1,2,3] = "0000"
	shape[1,2,4] = "0000"
	
	shape[1,3,1] = "0010"
	shape[1,3,2] = "0010"
	shape[1,3,3] = "0010"
	shape[1,3,4] = "0010"
	
	shape[1,4,1] = "0000"
	shape[1,4,2] = "0000"
	shape[1,4,3] = "1111"
	shape[1,4,4] = "0000"
	
	// ======= Figure O =========
	
	shape[2,1,1] = "0000"
	shape[2,1,2] = "0220"
	shape[2,1,3] = "0220"
	shape[2,1,4] = "0000"
	
	shape[2,2,1] = "0000"
	shape[2,2,2] = "0220"
	shape[2,2,3] = "0220"
	shape[2,2,4] = "0000"
	
	shape[2,3,1] = "0000"
	shape[2,3,2] = "0220"
	shape[2,3,3] = "0220"
	shape[2,3,4] = "0000"
	
	shape[2,4,1] = "0000"
	shape[2,4,2] = "0220"
	shape[2,4,3] = "0220"
	shape[2,4,4] = "0000"
	
	// ======= Figure L =========
	
	shape[3,1,1] = "3300"
	shape[3,1,2] = "0300"
	shape[3,1,3] = "0300"
	shape[3,1,4] = "0000"
	
	shape[3,2,1] = "0030"
	shape[3,2,2] = "3330"
	shape[3,2,3] = "0000"
	shape[3,2,4] = "0000"
	
	shape[3,3,1] = "0300"
	shape[3,3,2] = "0300"
	shape[3,3,3] = "0330"
	shape[3,3,4] = "0000"
	
	shape[3,4,1] = "0000"
	shape[3,4,2] = "3330"
	shape[3,4,3] = "3000"
	shape[3,4,4] = "0000"
	
	// ======= Figure J =========
	
	shape[4,1,1] = "0440"
	shape[4,1,2] = "0400"
	shape[4,1,3] = "0400"
	shape[4,1,4] = "0000"
	
	shape[4,2,1] = "0000"
	shape[4,2,2] = "4440"
	shape[4,2,3] = "0040"
	shape[4,2,4] = "0000"
	
	shape[4,3,1] = "0400"
	shape[4,3,2] = "0400"
	shape[4,3,3] = "4400"
	shape[4,3,4] = "0000"
	
	shape[4,4,1] = "4000"
	shape[4,4,2] = "4440"
	shape[4,4,3] = "0000"
	shape[4,4,4] = "0000"
	
	// ======= Figure T =========
	
	shape[5,1,1] = "0500"
	shape[5,1,2] = "5550"
	shape[5,1,3] = "0000"
	shape[5,1,4] = "0000"
	
	shape[5,2,1] = "0500"
	shape[5,2,2] = "0550"
	shape[5,2,3] = "0500"
	shape[5,2,4] = "0000"
	
	shape[5,3,1] = "0000"
	shape[5,3,2] = "5550"
	shape[5,3,3] = "0500"
	shape[5,3,4] = "0000"
	
	shape[5,4,1] = "0500"
	shape[5,4,2] = "5500"
	shape[5,4,3] = "0500"
	shape[5,4,4] = "0000"
	
	// ======= Figure Z =========
	
	shape[6,1,1] = "0600"
	shape[6,1,2] = "6600"
	shape[6,1,3] = "6000"
	shape[6,1,4] = "0000"
	
	shape[6,2,1] = "6600"
	shape[6,2,2] = "0660"
	shape[6,2,3] = "0000"
	shape[6,2,4] = "0000"
	
	shape[6,3,1] = "0060"
	shape[6,3,2] = "0660"
	shape[6,3,3] = "0600"
	shape[6,3,4] = "0000"
	
	shape[6,4,1] = "0000"
	shape[6,4,2] = "6600"
	shape[6,4,3] = "0660"
	shape[6,4,4] = "0000"
	
	// ======= Figure S =========
	
	shape[7,1,1] = "0700"
	shape[7,1,2] = "0770"
	shape[7,1,3] = "0070"
	shape[7,1,4] = "0000"
	
	shape[7,2,1] = "0770"
	shape[7,2,2] = "7700"
	shape[7,2,3] = "0000"
	shape[7,2,4] = "0000"
	
	shape[7,3,1] = "0070"
	shape[7,3,2] = "0077"
	shape[7,3,3] = "0007"
	shape[7,3,4] = "0000"
	
	shape[7,4,1] = "0000"
	shape[7,4,2] = "0770"
	shape[7,4,3] = "7700"
	shape[7,4,4] = "0000"

endfunction shape
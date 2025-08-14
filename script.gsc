// MRVO 1.0 DEVELOPED & TESTED BY MAZA [Mini Royale Verdansk Original]
// use this command seta mrvo_active 1;scr_br_gametype mini;br_minplayers 0;seta playerssizeadopt 0;seta mrvo 1
// OPTIONS: seta playerssizeadopt 1 | seta playerssizeadopt 0 - automatically adopts gas circles sizes for the count of players in lobby. enabled by default
// OPTIONS: seta mrvo 1 | seta mrvo 0 - enable changes of circles sizes & timings
// tested in 1.30, 1.34, 1.36, 1.38, 1.46 (caldera, thx to Kechioma)
// should work in 1.42 and other caldera builds
Init( ) {
    if ( getDvar("scr_br_gametype") == "mini" ) { // Makes sure MRVO only works in Mini Royale
    
        wait 1;

        if ( getdvarint("mrvo", 1) == 1 )
        {
            DefineCirclesRadiuses( );
        }

        if ( getdvarint("mrvo", 1) == 1 )
        {
            // ZONES TIMINGS
            level.br_level.br_circleclosetimes[0] = 2;   // starting zone close time
            level.br_level.br_circledelaytimes[1] = 120; // 1-2 zone delay  
	        level.br_level.br_circleclosetimes[1] = 60;  // 2nd zone close 
            level.br_level.br_circledelaytimes[2] = 60;  // 2-3 zone delay 
	        level.br_level.br_circleclosetimes[2] = 60;  // 3rd zone close
            level.br_level.br_circledelaytimes[3] = 45;  // 3-4 zones delay
	        level.br_level.br_circleclosetimes[3] = 30;  // 4th zone close
            level.br_level.br_circledelaytimes[4] = 45;  // 4-5 zones delay
	        level.br_level.br_circleclosetimes[4] = 60;  // 5th zone close
            // VEHICLES FIX CALL
            level thread VehiclesFix( );
        }

    }

}

DefineCirclesRadiuses( ) {

    if ( getDvarint("playerssizeadopt", 1) == 1 )
    {
        if ( level.players.size == 1 ) { // For playing alone (testing the mod)
            level.br_level.br_circleradii[0] = 15000; // -
            level.br_level.br_circleradii[1] = 15000; // GAS CIRCLE 1
            level.br_level.br_circleradii[2] = 12000; // GAS CIRCLE 2
            level.br_level.br_circleradii[3] = 6500; // GAS CIRCLE 3
            level.br_level.br_circleradii[4] = 3500; // GAS CIRCLE 4 | prelast circle in Mini Royale gametype
        }
        if ( level.players.size >= 2 ) {
            level.br_level.br_circleradii[0] = 6750; // -
            level.br_level.br_circleradii[1] = 6750; // GAS CIRCLE 1
            level.br_level.br_circleradii[2] = 6000; // GAS CIRCLE 2
            level.br_level.br_circleradii[3] = 5500; // GAS CIRCLE 3
            level.br_level.br_circleradii[4] = 3500; // GAS CIRCLE 4 | prelast circle in Mini Royale gametype
        }
        if ( level.players.size >=6 ) {
            level.br_level.br_circleradii[0] = 8600; // -
            level.br_level.br_circleradii[1] = 8600; // GAS CIRCLE 1
            level.br_level.br_circleradii[2] = 6000; // GAS CIRCLE 2
            level.br_level.br_circleradii[3] = 4500; // GAS CIRCLE 3
            level.br_level.br_circleradii[4] = 3500; // GAS CIRCLE 4 | prelast circle in Mini Royale gametype
        }
        if ( level.players.size >=12 ) {
            level.br_level.br_circleradii[0] = 9800; // -
            level.br_level.br_circleradii[1] = 9800; // GAS CIRCLE 1
            level.br_level.br_circleradii[2] = 8000; // GAS CIRCLE 2
            level.br_level.br_circleradii[3] = 6000; // GAS CIRCLE 3
            level.br_level.br_circleradii[4] = 3500; // GAS CIRCLE 4 | prelast circle in Mini Royale gametype
        }
        level.br_level.br_circleradii[5] = 2000; // GAS CIRCLE 5 | last circle in Mini Royale gametype

    }
    else
    {
        level.br_level.br_circleradii[0] = 9800; // -
        level.br_level.br_circleradii[1] = 9800; // GAS CIRCLE 1
        level.br_level.br_circleradii[2] = 7000; // GAS CIRCLE 2
        level.br_level.br_circleradii[3] = 5250; // GAS CIRCLE 3
        level.br_level.br_circleradii[4] = 3500; // GAS CIRCLE 4 | prelast circle in Mini Royale gametype
        level.br_level.br_circleradii[5] = 2000; // GAS CIRCLE 5 | last circle in Mini Royale gametype
    }
}

// Not like in 1.20: since we now use Mini Royale gametype to ease the pain with recreating circle from the game start, zones start with [1] index, not [0] like it was in 1.20 MRON.

VehiclesFix( ) {

    level waittill("prematch_done"); // Wait until Warmup ends
    
    wait 30; // Average time for Host to get into collised area

    level thread scripts\mp\gametypes\br_vehicles.gsc::brvehiclesreset( ); // Reset all vehicles
    level thread scripts\mp\gametypes\br_vehicles.gsc::emptyallvehicles( );
    level thread scripts\mp\gametypes\br_vehicles.gsc::spawninitialvehicles( ); // Respawn vehicles

}

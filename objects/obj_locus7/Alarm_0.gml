var next_room_index = global.current_level;
global.current_level++;

switch (global.current_level) {
	case 2: room_goto(rm_levelTwo); break;
	case 3: room_goto(rm_levelThree); break; 
	case 4: room_goto(rm_levelFour); break; 
	default: 
		//shouldn't happen - lvl 4 uses alarm[1] for win
		room_goto(rm_levelOne);
}
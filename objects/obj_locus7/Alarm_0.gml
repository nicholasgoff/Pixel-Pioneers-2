global.current_level++;

switch (global.current_level) {
	case 1: room_goto(rm_levelOne); break
	case 2: room_goto(rm_levelTwo); break;
	case 3: room_goto(rm_levelThree); break; 
	default: 
		//shouldn't happen - lvl 4 uses alarm[1] for win
		room_goto(rm_win);
}
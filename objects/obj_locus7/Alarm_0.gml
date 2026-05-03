show_debug_message("Alarm fired - current level before increment: " + string(global.current_level));
global.current_level++;
show_debug_message("current level after increment: " + string(global.current_level));

switch (global.current_level) {
	case 1: room_goto(rm_levelOne); break
	case 2: room_goto(rm_levelTwo); break;
	case 3: room_goto(rm_levelThree); break; 
	default: 
		//shouldn't happen - lvl 4 uses alarm[1] for win
		room_goto(rm_win);
}
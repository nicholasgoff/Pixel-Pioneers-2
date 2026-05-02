var mx = mouse_x;
var my = mouse_y;
var cx = room_width / 2;
var cy = room_height / 2;

//WIN SCREEN BUTTONS
if (screen_type == "win") {
	//Play again
	if (point_in_rectangle(mx, my, cx - 200, cy + 100, cx + 200, cy + 160)) {
		global.points = 0;
		global.current_level = 1;
		room_goto(rm_tutorial);
	}
	//Main Menu
	if (point_in_rectangle(mx, my, cx - 200, cy + 180, cx + 200, cy + 240)) {
		global.points = 0;
		global.current_level = 1;
		room_goto(rm_startScreen);
	}
	//Lose Screen Buttons
	if (screen_type == "lose"){
		//Try again - Restart current level
		if (point_in_rectangle(mx, my, cx - 200, cy + 100, cx + 200, cy + 160)) {
			switch (global.current_level) {
				case 1: room_goto(rm_levelOne); break;
				case 2: room_goto(rm_levelTwo); break;
				case 3: room_goto(rm_levelThree); break;
				default: room_goto(rm_tutorial); break;
			}
		}
		//Main menu
		if (point_in_rectangle(mx, my, cx - 200, cy + 180, cx + 200, cy + 240)) {
		global.points = 0;
		global.current_level = 1;
		room_goto(rm_startScreen);
		}
		//quit
		if (point_in_rectangle(mx, my, cx - 200, cy + 260, cx + 200, cy + 320)) {
			game_end();
		}
	}}
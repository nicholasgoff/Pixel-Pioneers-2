var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var cx = display_get_gui_width() / 2;
var cy = display_get_gui_height() / 2;

// WIN SCREEN
if (screen_type == "win") {

    // Play again
    if (point_in_rectangle(mx, my, cx - 200, cy + 100, cx + 200, cy + 160)) {
        global.points = 0;
        global.current_level = 1;
        room_goto(rm_tutorial);
    }

    // Main Menu
    if (point_in_rectangle(mx, my, cx - 200, cy + 180, cx + 200, cy + 240)) {
        global.points = 0;
        global.current_level = 1;
        room_goto(rm_start);
    }

    
    if (point_in_rectangle(mx, my, cx - 200, cy + 260, cx + 200, cy + 320)) {
        game_end();
    }
}

// LOSE SCREEN
if (screen_type == "lose") {

    // Try again
    if (point_in_rectangle(mx, my, cx - 200, cy + 100, cx + 200, cy + 160)) {
        switch (global.current_level) {
            case 1: room_goto(rm_levelOne); break;
            case 2: room_goto(rm_levelTwo); break;
            case 3: room_goto(rm_levelThree); break;
            default: room_goto(rm_tutorial); break;
        }
    }

    // Main menu
    if (point_in_rectangle(mx, my, cx - 200, cy + 180, cx + 200, cy + 240)) {
        global.points = 0;
        global.current_level = 1;
        room_goto(rm_start);
    }

    // Quit
    if (point_in_rectangle(mx, my, cx - 200, cy + 260, cx + 200, cy + 320)) {
        game_end();
    }
}
var cx = room_width / 2;
var cy = room_height / 2;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// TITLE
draw_set_font(fnt_menu);
draw_text(cx, cy - 250, "Possession Protocol");

// MAIN MENU
draw_set_font(fnt_menu);
if (menu == "main") {
	if (point_in_rectangle(mouse_x, mouse_y, cx - 200, cy - 100, cx + 200, cy - 40)) {
        draw_text(cx, cy - 60, "> Start Game <");
    } else draw_text(cx, cy - 60, "Start Game");
	
	if (point_in_rectangle(mouse_x, mouse_y, cx - 200, cy - 20, cx + 200, cy + 40)) {
        draw_text(cx, cy + 20, "> Instructions <");
    } else draw_text(cx, cy + 20, "Instructions");
	
	if (point_in_rectangle(mouse_x, mouse_y, cx - 200, cy + 60, cx + 200, cy + 120)) {
        draw_text(cx, cy + 100, "> Credits <");
    } else draw_text(cx, cy + 100, "Credits");
	
	if (point_in_rectangle(mouse_x, mouse_y, cx - 200, cy + 140, cx + 200, cy + 200)) {
	    draw_text(cx, cy + 180, "> Quit <");
	} else draw_text(cx, cy + 180, "Quit");
	
}

// INSTRUCTIONS
if (menu == "instructions") {
    draw_text(cx, cy - 100, "Instructions:");
	draw_set_halign(fa_left);
    draw_text(cx - 400, cy, "WASD - Move current Host");
	draw_text(cx - 400, cy + 80, "Left Click - Possess nearby unit / interact");
    draw_text(cx - 400, cy + 160, "E - Release current host");
	draw_text(cx - 400, cy + 240, "Right Click - EMP Pulse (Drone Only)");
	draw_text(cx - 400, cy + 320, "F - Pick up / drop object (Drone Only");
	draw_set_halign(fa_center);
	
    
    if (point_in_rectangle(mouse_x, mouse_y, cx - 200, cy + 440, cx + 200, cy + 500)) {
        draw_text(cx, cy + 480, "> Back <");
    } else draw_text(cx, cy + 480, "Back");
}

// CREDITS
if (menu == "credits") {
    draw_text(cx, cy - 100, "--- Credits ---");
    draw_text(cx, cy, "Pixel Pioneers:");
	draw_text(cx, cy + 80, "Nick Goff - Producer");
    draw_text(cx, cy + 160, "Jamison Hill - Designer");
	draw_text(cx, cy + 240, "Jayden Patton - Artist");
	draw_text(cx, cy + 320, "Al'Montay Eley - Programmer");
    
    if (point_in_rectangle(mouse_x, mouse_y, cx - 200, cy + 440, cx + 200, cy + 500)) {
        draw_text(cx, cy + 480, "> Back <");
    } else draw_text(cx, cy + 480, "Back");
}
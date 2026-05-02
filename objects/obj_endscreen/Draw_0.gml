var cx = room_width / 2;
var cy = room_height / 2; 

draw_set_halign(fa_center);
draw_set_valign(fa_middle); 
draw_set_font(fnt_menu);

//WIN SCREEN 
if (screen_type == "win"){
	draw_set_colour(c_lime);
	draw_text(cx, cy - 250, "TRANSMISSION COMPLETE");
	
	draw_set_colour(c_white); 
	draw_text(cx, cy - 150, "LOCUS-7 HAS ESCAPED THE PROMETHEUS COMPLEX");
	draw_text(cx, cy - 70, "ARCHRON-0 HAS BEEN NEUTRALISED"); 
	draw_text(cx, cy + 10, "FINAL SCORE: " + string(global.points));
	
	draw_set_colour(c_lime);
	if (point_in_rectangle(mouse_x, mouse_y, cx - 200, cy + 100, cx + 200, cy + 160)) {
		draw_text(cx, cy + 130, "> Play Again <");
	} else {
		draw_text(cx, cy + 130, "Play Again");
	}
	
	if (point_in_rectangle(mouse_x, mouse_y, cx - 200, cy + 180, cx + 200, cy + 240)) {
		draw_text(cx, cy + 210, "> Main Menu <");
	} else {
		draw_text(cx, cy + 210, "Main Menu");
	}
	
	if (point_in_rectangle(mouse_x, mouse_y, cx - 200, cy + 260, cx + 200, cy + 320)) {
		draw_text(cx, cy + 290, "> Quit <");
	} else {
		draw_text(cx, cy + 290, "Quit");
	}
}
	
//LOSE SCREEN
if (screen_type == "lose"){
	draw_set_colour(c_red);
	draw_text(cx, cy - 250, "LOCUS-7 TERMINATED");
	
	draw_set_colour(c_white); 
	draw_text(cx, cy - 150, "INTEGRITY FAILURE - SYSTEM PURGED");
	draw_text(cx, cy - 70, "THE PROMETHEUS COMPLEX REMAINS SEALED"); 
	draw_text(cx, cy + 10, "FINAL SCORE: " + string(global.points));
	
	draw_set_colour(c_red);
	if (point_in_rectangle(mouse_x, mouse_y, cx - 200, cy + 100, cx + 200, cy + 160)) {
		draw_text(cx, cy + 130, "> Try Again <");
	} else {
		draw_text(cx, cy + 130, "Try Again");
	}
	
	if (point_in_rectangle(mouse_x, mouse_y, cx - 200, cy + 180, cx + 200, cy + 240)) {
		draw_text(cx, cy + 210, "> Main Menu <");
	} else {
		draw_text(cx, cy + 210, "Main Menu");
	}
	
	if (point_in_rectangle(mouse_x, mouse_y, cx - 200, cy + 260, cx + 200, cy + 320)) {
		draw_text(cx, cy + 290, "> Quit <");
	} else {
		draw_text(cx, cy + 290, "Quit");
	}
}

draw_set_colour(c_white); 
	
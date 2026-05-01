//obj_rivalAi Create event
rival_seize_timer = 0;
rival_seize_interval = 600; //seize a new unit every 10 seconds

//announce rival presence on level 3
if (global.current_level == 3) {
	scr_hud_message("WARNING - UNKNOWN AI INTERFERENCE DETECTED");
}
//obj_rivalAi Create event
rival_seize_timer = 0;
rival_seize_interval = 1800; //seize a new unit every 10 seconds
rival_max_units = 1; //only control one unit at a time
move_speed = 2;
sight_range = 150;
sight_angle = 45;
is_possessed = false;
patrol_paused = false;
return_timer = 0;
patrol_path = -1;
patrol_path_pos = 0;
patrol_resume = false;
unit_name = "RIVAL UNIT";

nav_path = path_add();
nav_timer = 0;

//announce rival presence on level 3
if (global.current_level == 3) {
	scr_hud_message("WARNING - UNKNOWN AI INTERFERENCE DETECTED");
}
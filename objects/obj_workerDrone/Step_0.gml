//obj_workerDrone Step event
if (!is_possessed) {
	//patrol
	scr_patrol_step(id);
	
	//detect free-roaming locus
	var locus7 = instance_find(obj_locus7, 0);
	if (locus7 != noone) {
		if (scr_unit_sees_locus7(id, locus7)) {
			global.alert_level = 2; 
			global.alert_timer = 300;
			scr_hud_message("!!! DRONE SPOTTED LOCUS-7 !!!");
		}
	}
	
	//rival AI override (level 3+)
	if (global.rival_active && ds_list_find_index(global.rival_targets, id) >= 0) {
		patrol_paused = true;
	}
}

//drop carried object if possession is lost
if (!is_possessed && carrying_object != noone) {
	carrying_object.is_carried = false;
	carrying_object = noone;
}

//image blend based on state
if (is_possessed) {
	image_blend = possessed_blend;
} else if (global.rival_active && ds_list_find_index(global.rival_targets, id) >= 0) {
	image_blend = c_red;
} else {
	image_blend = c_white;
}
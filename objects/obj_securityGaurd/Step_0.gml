if (!is_possessed) {
	scr_patrol_step(id);
	
	//detect locus7
	var locus7 = instance_find(obj_locus7, 0);
	if (instance_exists(locus7)) {
		if (scr_guard_sees_locus7(id, locus7)) {
			global.alert_level = 2; 
			global.alert_timer = 300;
			scr_hud_message("GUARD SPOTTED LOCUS7");
		}
	}
	
	//rival AI override (level 3+) 
	if (global.rival_active && ds_list_find_index(global.rival_targets, id) >= 0) {
		//movement handled by scr_rival_unit_pursue in scr_boss_step
		patrol_paused = true; 
	}
	
	//green tint when possessed, red when rival-controlled
	if (is_possessed) {
		image_blend = possessed_blend; 
	} else if (global.rival_active && ds_list_find_index(global.rival_targets, id) >= 0) {
		image_blend = c_red;
	} else {
		image_blend = c_white;
	}
}
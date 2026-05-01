//tick alert system
scr_alert_step(); 

//HUD message timer
if (global.hud_msg_timer > 0) global.hud_msg_timer--;

if (global.possessed_unit == noone) { 
	//free roam
	scr_locus_free_move(id); 
	
	//possess on left-click
	if (mouse_check_button_pressed(mb_left)) {
		scr_try_possess(id);
	}
} else {
	//Inhabiting a host
	scr_host_move(id);
	
	//drone abilities
	if (global.possessed_unit.object_index == obj_workerDrone) {
		//EMP on right click
		if (mouse_check_button_pressed(mb_right) && global.possessed_unit.emp_cooldown <= 0) {
			scr_drone_emp(global.possessed_unit);
		}
		if (global.possessed_unit.emp_cooldown > 0) global.possessed_unit.emp_cooldown--;
		
		//carry on F
		if (keyboard_check_pressed(ord("F"))) {
			scr_drone_carry(global.possessed_unit);
		}
		
		//update carried object position
		scr_drone_carry_update(global.possessed_unit);
	}
	
	//interact on left-click
	if (mouse_check_button_pressed(mb_left)) {
		//in level 4: check if clicking the core terminal while inside
		// a rival controlled unit -> redirect mechanic
		if (global.current_level == 4 && global.rival_active) {
			var term = instance_nearest(global.possessed_unit.x, global.possessed_unit.y, obj_terminal);
			if (term != noone && term.is_exit && point_distance(global.possessed_unit.x, global.possessed_unit.y, term.x, term.y) < 72){
				if (!scr_boss_redirect_unit(id)) {
					//not a rival unit - normal terminal use
					scr_interact(global.possessed_unit);
				}
			} else {
				scr_interact(global.possessed_unit);
			} 
		} else { 
			scr_interact(global.possessed_unit);
		}
	}
	
	//release host on E 
	if (keyboard_check_pressed(ord("E"))) {
		scr_release_host(id);
	}
}

// Level 4 boss step 
if (global.current_level == 4 && global.rival_active) {
	scr_boss_step(id);
}
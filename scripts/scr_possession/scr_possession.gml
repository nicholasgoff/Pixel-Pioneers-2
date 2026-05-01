// Core Possession and Release logic for LOCUS-7

//scr_try_possess(locus_inst)
// called when player left clicks while in ghost form
// find a possessable unit within range of locus and takes it over
function scr_try_possess(locus_inst) {
	var POSSESS_RANGE = 64; //pixels from locus position
	
	//cannot possess while on full alert
	if (global.alert_level >= 2) {
		scr_hud_message("CANNOT POSSESS - FULL ALERT ACTIVE");
		return false;
	}
	
	//scan all possessable unit types
	var unit_types = [obj_securityGuard, obj_workerDrone, obj_securityRobot];
	var best = noone; 
	var best_dist = POSSESS_RANGE; 
	
	//loop through all unit types and find closest to locus
	var i = 0;
	repeat(array_length(unit_types)) {
		var utype = unit_types[i];
		with (utype) {
			var d = point_distance(locus_inst.x, locus_inst.y, x, y);
			if (d < best_dist) {
				//cannot possess a unit the rival AI owns
				if (ds_list_find_index(global.rival_targets, id) < 0 || !global.rival_active) {
					best_dist = d;
					best = id;
				}
			}
		}
		i++;
	}
	
	if (best == noone) return false;
	
	//Possess the unit - stop its path
	global.possessed_unit = best;
	with (best) {
		patrol_path_pos = path_position; //save current position on path
		path_end();
	}
best.is_possessed = true; 
best.patrol_paused = true; //freeze AI patrol while possessed
	
	//restore stamina to full when entering a new host
	global.host_stamina = global.host_stamina_max; 
	
	//visual: locus snaps to host position (hidden in host mode)
	locus_inst.visible = false;
	
	//HUD feedback
	scr_hud_message("LINK ESTABLISHED - " + string(best.unit_name));
	return true;
}

//scr_release_host(locus_inst)
// called when player presses E, or forcefully ejected
function scr_release_host(locus_inst) {
	if (global.possessed_unit == noone) return; 
	
	var host = global.possessed_unit; 
	
	//Return locus to host position before detaching
	locus_inst.x = host.x;
	locus_inst.y = host.y;
	locus_inst.visible = true;
	
	//Host resumes patrol after a short delay via return_timer
	host.is_possessed = false;
	host.patrol_paused = true;
	host.return_timer = 180; //3 seconds at 60 fps before patrol resumes
	
	global.possessed_unit = noone;
	
	scr_hud_message("LINK SEVERED - FREE ROAM");
}

//scr_force_eject(locus_inst)
// called by camera detection or rival AI interference
function scr_force_eject(locus_inst) {
	scr_release_host(locus_inst);
	scr_hud_message("!!! LINK BROKEN - DETECTED !!!");
	//Bump alert level
	global.alert_level = min(global.alert_level + 1, 2);
	global.alert_timer = 300; //5 seconds
}

//scr_hud_message(msg) 
// queues a temporary message on the HUD
function scr_hud_message(msg) {
	global.hud_message = msg;
	global.hud_msg_timer = 240; //4 seconds
}
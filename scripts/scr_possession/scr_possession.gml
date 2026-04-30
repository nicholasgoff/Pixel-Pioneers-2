// Core Possession and Release logic for LOCUS-7

//scr_try_possess(locus_inst)
// called when player left clicks while in ghost form
// find a possessable unit within range and takes it over
function scr_try_possess(locus_inst) {
	var POSSESS_RANGE = 64; //pixels
	
	//scan all possessable unit types
	var unit_types = [obj_securityGuard, obj_workerDrone, obj_securityRobot];
	var best = noone; 
	var best_dist = POSSESS_RANGE; 
	
	//room-space mouse coords
	var mx = mouse_x;
	var my = mouse_y;
	
	var i = 0;
	repeat(array_length(unit_types)) {
		var utype = unit_types[i];
		var inst = instance_nearest(mx, my, utype);
		if (inst != noone) {
			var d = point_distance(mx, my, inst.x, inst.y);
			if (d < best_dist) {
				//cannot possess a unit the rival AI owns
				if (ds_list_find_index(global.rival_targets, inst) < 0 || !global.rival_active) {
					best_dist = d;
					best = inst;
				}
			}
		}
		i++;
	}
	
	if (best == noone) return false;
	
	//Possess the unit
	global.possessed_unit = best;
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
	
	//Host resumes patrol after a short delay
	host.is_possessed = false; 
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
// Core Possession and Release logic for LOCUS-7

//scr_try_possess(locus_inst)
// called when player left clicks while in ghost form
// find a possessable unit with range and takes it over

function scr_try_possess(locus_inst) {
	var POSSESS_RANGE = 64; //pixels
	
	//scan all possessable unit types
	var unit_types = [obj_securityGaurd, obj_workerDrone, obj_securityRobot];
	var best = noone; 
	var best_dist = POSSESS_RANGE; 
	
	var mx = device_mouse_x_to gui(0); //mouse in room coords if camera is 1:1
	var my = device_mouse_y_to_gui(0); 
	//for room-space mouse:
	mx = mouse_x;
	my = mouse_y;
	
	var i = 0;
	repeat(array_length(unit_types)) {
		var utype = unit_types[i];
		var inst = instance_nearest(mx, my, utype);
		if (inst != noone) {
			var d = point_distance(mx, my, inst.x, inst.y);
			if (d < best_dist) {
				//cannot possess unit the rival Ai owns
				if (!ds_list_find_index(globa.rival_targets, inst) >= 0 || !global.rival_active) {
					best_dist = d;
					best = inst;
				}
			}
		}
		i++;
	}
	
	if (best = noone) return false;
	
	//Possess the unit
	global.possessd_unit = best;
	best.is_possessed = true; 
	best.patrol_paused = true; //freeze AI patrol while possessed
	
	//restore stamina to full when entering a new host
	global.host_stamina = global.host_stamina_max; 
	
	//visual: locus snaps to host postition (hidden in host mode)
	locus_inst.visible = false;
	
	//HUD feedback
	scr_hud_message("LINK ESTABLISHED - " + string(best.unit_name));
	return true;
}

//scr_release_host(ghost_inst)
// called when player presses E, or forefully ejected
function scr_release_host(locus_inst) {
	if (global.possessed_unit == noone) return; 
	
	var host = global.possessed_unit; 
	
	//Return locus to host position before detatching
	locus_inst.x = host.x;
	locus_inst.y = host.y;
	locus_inst.visible = true;
	
	//Host resumes patrol after a short delay
	host.is_possessed = false; 
	host.return_timer = 180; //3 seconds at 60 fps beforepatrol resumes
	
	global.possessed_unit = noone;
	
	scr_hud_message("LINK SEVERED - FREE ROAM");
}

//scr_froce_eject(locus_inst)
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
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
	
	//Possession Particle Burst (Advanced Feature)
	//Clean up any previous particle system first
	if (global.particle_system != -1 && global.particle_type != -1) {
		part_type_destroy(global.particle_type);
		part_system_destroy(global.particle_system);
		global.particle_system = -1;
		global.particle_type = -1;
	}
	
	global.particle_system = part_system_create();
	part_system_depth(global.particle_system, -200); 
	
	global.particle_type = part_type_create();
	part_type_shape(global.particle_type, pt_shape_spark);
	part_type_colour2(global.particle_type, c_lime, c_teal); 
	part_type_alpha2(global.particle_type, 1, 0);
	part_type_speed(global.particle_type, 2, 5, 0, 0);
	part_type_direction(global.particle_type, 0, 360, 0, 10);
	part_type_life(global.particle_type, 20, 40);
	part_type_size(global.particle_type, 0.3, 0.8, -0.01, 0);
	
	var pe = part_emitter_create(global.particle_system);
	part_emitter_region(global.particle_system, pe, best.x, best.y, best.x, best.y, 0, 0);
	part_emitter_burst(global.particle_system, pe, global.particle_type, 35);
	
	with (obj_locus7) alarm[2] = 45;
	
	
	//HUD feedback
	scr_hud_message("LINK ESTABLISHED - " + string(best.unit_name));
	global.points += 100; //points for successful possession
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
	
	var release_x = host.x; 
	var release_y = host.y;
	
	//Host resumes patrol after a short delay via return_timer
	host.is_possessed = false;
	host.patrol_paused = true;
	host.return_timer = 180; //3 seconds at 60 fps before patrol resumes
	
	global.possessed_unit = noone;
	
	scr_hud_message("LINK SEVERED - FREE ROAM");
	
	//Release Particle burst
	with (obj_locus7) alarm[2] = -1;
	
	if (global.particle_system != -1 && global.particle_type != -1) {
		part_type_destroy(global.particle_type); 
		part_system_destroy(global.particle_system);
		global.particle_system = -1;
		global.particle_type = -1;
	}
	
	global.particle_system = part_system_create();
	part_system_depth(global.particle_system, -200); 
	
	global.particle_type = part_type_create();
	part_type_shape(global.particle_type, pt_shape_spark); 
	part_type_colour2(global.particle_type, c_red, c_orange); 
	part_type_alpha2(global.particle_type, 1, 0);
	part_type_speed(global.particle_type, 3, 7, 0, 0);
	part_type_direction(global.particle_type, 0, 360, 0, 10);
	part_type_life(global.particle_type, 20, 45);
	part_type_size(global.particle_type, 0.3, 0.9, -0.01, 0);
	
	var pe = part_emitter_create(global.particle_system); 
	part_emitter_region(global.particle_system, pe, release_x, release_y, release_x, release_y, 0, 0);
	part_emitter_burst(global.particle_system, pe, global.particle_type, 35);
	
	with (obj_locus7) alarm[2] = 45;
}

//scr_force_eject(locus_inst)
// called by camera detection or rival AI interference
function scr_force_eject(locus_inst) {
	//store host position before releasing
	var eject_x = locus_inst.x;
	var eject_y = locus_inst.y;
	if (global.possessed_unit != noone) {
		eject_x = global.possessed_unit.x;
		eject_y = global.possed_unit.y; 
	}
	
	scr_release_host(locus_inst);
	scr_hud_message("!!! LINK BROKEN - DETECTED !!!");
	//Bump alert level
	global.alert_level = min(global.alert_level + 1, 2);
	global.alert_timer = 300; //5 seconds
	
	//ejection particle burst
	if (global.particle_system != -1 && global.particle_type != -1) {
		part_type_destroy(global.particle_type); 
		part_system_destroy(global.particle_system);
		global.particle_system = -1;
		global.particle_type = -1;
	}
	
	with (obj_locus7) alarm[2] = -1;
	
	global.particle_system = part_system_create();
	part_system_depth(global.particle_system, -200); 
	
	global.particle_type = part_type_create();
	part_type_shape(global.particle_type, pt_shape_spark); 
	part_type_colour2(global.particle_type, c_red, c_orange); 
	part_type_alpha2(global.particle_type, 1, 0);
	part_type_speed(global.particle_type, 3, 7, 0, 0);
	part_type_direction(global.particle_type, 0, 360, 0, 10);
	part_type_life(global.particle_type, 20, 45);
	part_type_size(global.particle_type, 0.3, 0.9, -0.01, 0);
	
	var pe = part_emitter_create(global.particle_system); 
	part_emitter_region(global.particle_system, pe, eject_x, eject_y, eject_x, eject_y, 0, 0);
	part_emitter_burst(global.particle_system, pe, global.particle_type, 35);
	
	with (obj_locus7) alarm[2] = 45;
}

//scr_hud_message(msg) 
// queues a temporary message on the HUD
function scr_hud_message(msg) {
	global.hud_message = msg;
	global.hud_msg_timer = 240; //4 seconds
}
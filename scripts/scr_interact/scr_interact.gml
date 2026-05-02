//scr_interact(host)
// called when player left clicks while possessing a unit
// behaviour depends on the unit type
function scr_interact(host) {
	var INTERACT_RANGE = 48;
	
	var nearest_door = instance_nearest(host.x, host.y, obj_keycardDoor);
	var nearest_barrier = instance_nearest(host.x, host.y, obj_barrier);
	var nearest_terminal = instance_nearest(host.x, host.y, obj_terminal);
	
	//Security Guard interactions
	if (host.object_index == obj_securityGuard) {
		//open keycard door
		if (nearest_door != noone && point_distance(host.x, host.y, nearest_door.x, nearest_door.y) < INTERACT_RANGE) {
			nearest_door.is_open = true;
			nearest_door.solid = false;
			nearest_door.visible = false;
			scr_hud_message("KEYCARD ACCESS GRANTED");
		}
		//use terminal
		else if (nearest_terminal != noone && point_distance(host.x, host.y, nearest_terminal.x, nearest_terminal.y) < INTERACT_RANGE) {
			scr_use_terminal(nearest_terminal, host);
		}
	}
	
	//Worker Drone interactions
	else if (host.object_index == obj_workerDrone) {
		//use terminal
		if (nearest_terminal != noone && point_distance(host.x, host.y, nearest_terminal.x, nearest_terminal.y) < INTERACT_RANGE) {
			scr_use_terminal(nearest_terminal, host);
		}
	}
	
	//Security Robot interactions
	//Security Robot interactions
	else if (host.object_index == obj_securityRobot) {
	//smash barrier
	if (instance_exists(obj_barrier)) {
		if (nearest_barrier != noone && point_distance(host.x, host.y, nearest_barrier.x, nearest_barrier.y) < INTERACT_RANGE) {
			instance_destroy(nearest_barrier);
			scr_hud_message("BARRIER DESTROYED");
			exit;
		}
	}
	
	//destroy pylon
	if (instance_exists(obj_pylon)) {
	var nearest_pylon = instance_nearest(host.x, host.y, obj_pylon);
	if (nearest_pylon != noone && rectangle_in_circle(nearest_pylon.bbox_left, nearest_pylon.bbox_top, nearest_pylon.bbox_right, nearest_pylon.bbox_bottom, host.x, host.y, INTERACT_RANGE)) {
		instance_destroy(nearest_pylon);
		scr_hud_message("PYLON DESTROYED");
		exit;
	}
}
	
	//hit main terminal
	if (instance_exists(obj_main_terminal)) {
		var nearest_mt = instance_nearest(host.x, host.y, obj_main_terminal);
		if (nearest_mt != noone && rectangle_in_circle(nearest_mt.bbox_left, nearest_mt.bbox_top, nearest_mt.bbox_right, nearest_mt.bbox_bottom, host.x, host.y, INTERACT_RANGE)) {
			if (instance_number(obj_pylon) == 0) {
				if (nearest_mt.hit_cooldown <= 0 && !nearest_mt.is_destroyed) {
					nearest_mt.hp--;
					nearest_mt.hit_cooldown = 180;
					scr_hud_message("TERMINAL HIT - " + string(nearest_mt.hp) + " HITS REMAINING");
					if (nearest_mt.hp <= 0) {
						nearest_mt.is_destroyed = true;
						scr_hud_message("TERMINAL DESTROYED - ACCESS GRANTED");
						instance_destroy(nearest_mt)
					}
				}
			} else {
				scr_hud_message("DESTROY ALL PYLONS FIRST");
			}
		}
	}
	
	
	//use terminal
	if (nearest_terminal != noone && point_distance(host.x, host.y, nearest_terminal.x, nearest_terminal.y) < INTERACT_RANGE) {
		scr_use_terminal(nearest_terminal, host);
	}
}
		//use terminal
		if (nearest_terminal != noone && point_distance(host.x, host.y, nearest_terminal.x, nearest_terminal.y) < INTERACT_RANGE) {
			scr_use_terminal(nearest_terminal, host);
		}
	}

//scr_use_terminal(term, host)
// handles terminal interaction logic
function scr_use_terminal(term, host) {
	//exit terminal - complete the level
	if (term.is_exit) {
		global.level_complete = true;
		scr_hud_message("UPLINK ESTABLISHED - TRANSMITTING...");
		with (obj_locus7) alarm[0] = 180; //3 second delay before room change
		return;
	}
	
	//standard terminal - trigger its effect
	term.has_been_used = true;
	scr_hud_message("TERMINAL ACCESSED");
}
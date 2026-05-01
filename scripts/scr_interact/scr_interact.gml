//scr_interact(host)
// called when player left clicks while possessing a unit
// behaviour depends on the unit type
function scr_interact(host) {
	var INTERACT_RANGE = 48; //pixels
	
	//find nearest interactable object
	var nearest_door = instance_nearest(host.x, host.y, obj_keycardDoor);
	var nearest_barrier = instance_nearest(host.x, host.y, obj_barrier);
	var nearest_terminal = instance_nearest(host.x, host.y, obj_terminal);
	
	if (instance_exists(obj_keycardDoor)) {
    var door = instance_nearest(host.x, host.y, obj_keycardDoor);
    if (door != noone && point_distance(host.x, host.y, door.x, door.y) < 48) {
        // only guards can open keycard doors
        if (host.object_index == obj_securityGuard) {
            door.is_open = true;
            door.solid = false;
            door.visible = false;
            scr_hud_message("KEYCARD ACCESS GRANTED");
        } else {
            scr_hud_message("KEYCARD REQUIRED");
        }
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
	else if (host.object_index == obj_securityRobot) {
		//smash barrier
		if (nearest_barrier != noone && point_distance(host.x, host.y, nearest_barrier.x, nearest_barrier.y) < INTERACT_RANGE) {
			instance_destroy(nearest_barrier);
			scr_hud_message("BARRIER DESTROYED");
		}
		//use terminal
		else if (nearest_terminal != noone && point_distance(host.x, host.y, nearest_terminal.x, nearest_terminal.y) < INTERACT_RANGE) {
			scr_use_terminal(nearest_terminal, host);
		}
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
//Handle free-roam locus movement and possessed-host movement each step

//scr_locus_free_move(inst)
// call from obj_locus7 Step when NOT possessing a unit
// Locus passes through everything - no collision, but cannot open doors
function scr_locus_free_move(inst) { 
	var SPD = 3;
	
	var dx = (keyboard_check(ord("D")) - keyboard_check(ord("A"))) * SPD;
	var dy = (keyboard_check(ord("S")) - keyboard_check(ord("W"))) * SPD;
	
	inst.x += dx;
	inst.y += dy;
	
	//keep locus inside room bounds
	inst.x = clamp(inst.x, 8, room_width - 8); 
	inst.y = clamp(inst.y, 8, room_height - 8); 
	
	//locus is detected by cameras - check exposure
	scr_locus_camera_check(inst);
}

//scr_host_move(locus_inst)
// call from obj_locus7 step when possessing a unit
// routes input through the current hosts movement rules
function scr_host_move(ghost_inst) {
	var host = global.possessed_unit;
	if (!instance_exists(host)) {
		scr_release_host(ghost_inst);
		return;
	}
	
	var SPD = host.move_speed;
	var sprinting = keyboard_check(vk_shift) && host.can_sprint;
	
	//stamina drain when sprinting
	if (sprinting) {
		global.host_stamina <= 0) {
			sprinting = false; 
			global.host_stamina = 0;
		}
		SPD *= 1.6;
	} else {
		global.host_stamina = min(global.host_stamina + 0.2, global.host_stamina_max);
	}
	
	var dx = (keyboard_check(ord("D")) - keyboard_check(ord("A"))) * SPD; 
	var dy = (keyboard_check(ord("S")) - keyboard_check(ord("W"))) * SPD;
	
	//collision: drone ingnore walls; others don't
	if (host.object_index == obj_workerDrone) {
		host.x += dx;
		host.y += dy;
	} else {
		//horizontal
		if (!place_meeting(host.x + dx, host.y, obj_wall)) host.x += dx;
		//vertical
		if (!place_meeting(host.x, host.y + dy, obj_wall)) host.y += dy;
	}
	
	//sync locus position to host
	locus_inst.x = host.x;
	locus_inst.y = host.y; 
	
	//bounds
	host.x = clamp(host.x, 8, room_width - 8);
	host.y = clamp(host.y, 8, room_height - 8);
	
	//drone vent traversal - drones can pass through obj_vent tiles
	if (host.object_index == obj_workerDrone) {
		//no extra logic needed
		//mark obj_vent as non-solid
	}
}

//scr_locus_camera_check(locus_inst)
// if locus is in free-roam and insside a camera cone, trigger eject penalty
function scr_ghost_camera_check(locus_inst) {
	if (global.possessed_unit != noone) return; //only matters when free
	
	with (obj_camera) {
		if (scr_camera_sees(id, locus_inst.x, locus_inst.y)) {
			//being seen in unpossessed form triggers an alert immediately
			global.alert_level = 2;
			global.alert_timer = 300; 
			scr_hud_message("!!! LOCUS DETECTED BY CAMERA !!!");
		}
	}
}
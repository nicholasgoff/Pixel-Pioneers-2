//scr_drone_emp(drone_inst)
// triggered by right click while possessing a drone
// disables all cameras within radius for 5 seconds
function scr_drone_emp(drone_inst) {
	var EMP_RADIUS = 200; //pixels
	
	with (obj_camera) {
		if (point_distance(drone_inst.x, drone_inst.y, x, y) < EMP_RADIUS) {
			is_disabled = true;
			disable_timer = 300; //5 seconds at 60fps
		}
	}
	
	drone_inst.emp_cooldown = 600; //10 second cooldown before EMP can be used again
	scr_hud_message("EMP DISCHARGED - CAMERAS DISABLED");
}

//scr_drone_carry(drone_inst)
// triggered by F key while possessing a drone
// picks up or drops nearest carriable object
function scr_drone_carry(drone_inst) {
	var CARRY_RANGE = 48;
	
	//if already carrying something, drop it
	if (drone_inst.carrying_object != noone) {
		var obj = drone_inst.carrying_object;
		obj.x = drone_inst.x;
		obj.y = drone_inst.y;
		obj.is_carried = false;
		drone_inst.carrying_object = noone;
		scr_hud_message("OBJECT DROPPED");
		
		//check if any guard is distracted by the dropped object
		with (obj_securityGuard) {
			if (!is_possessed && point_distance(x, y, obj.x, obj.y) < 100) {
				patrol_paused = true;
				return_timer = 300; //guard distracted for 5 seconds
				scr_hud_message("GUARD DISTRACTED");
			}
		}
		return;
	}
	
	//find nearest carriable object
	var nearest = instance_nearest(drone_inst.x, drone_inst.y, obj_carriable);
	if (nearest != noone && point_distance(drone_inst.x, drone_inst.y, nearest.x, nearest.y) < CARRY_RANGE) {
		drone_inst.carrying_object = nearest;
		nearest.is_carried = true;
		scr_hud_message("OBJECT ACQUIRED");
	}
}

//scr_drone_carry_update(drone_inst)
// call every step while possessing a drone
// keeps carried object synced to drone position
function scr_drone_carry_update(drone_inst) {
	if (drone_inst.carrying_object != noone) {
		drone_inst.carrying_object.x = drone_inst.x;
		drone_inst.carrying_object.y = drone_inst.y - 16; //slightly above drone
	}
}
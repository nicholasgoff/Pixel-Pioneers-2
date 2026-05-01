x = clamp(x, 8, room_width - 8);
y = clamp(y, 8, room_height - 8);

if (!is_possessed) {
	scr_patrol_step(id);
	
	//detect locus7
	var locus7 = instance_find(obj_locus7, 0);
	if (locus7 != noone) {
		if (scr_unit_sees_locus7(id, locus7)) {
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
}

if (place_meeting(x, y, obj_wall)) {
    show_debug_message("WALL DETECTED");
}

//intimidation - robot forces guard off path
var nearest_robot = instance_nearest(x, y, obj_securityRobot);
if (nearest_robot != noone) {
	var robot_dist = point_distance(x, y, nearest_robot.x, nearest_robot.y);
	
	if (robot_dist < nearest_robot.intimidate_range) {
		if (!patrol_paused) {
			patrol_path_pos = path_position;
			patrol_paused = true;
			return_timer = 120;
		}
		
		path_end();
		
		//push guard away from robot with manual wall collision
		var push_dir = point_direction(nearest_robot.x, nearest_robot.y, x, y);
		var push_spd = 2;
		
		//move one pixel at a time to prevent clipping
		var steps = push_spd;
		repeat(steps) {
			var ddx = lengthdir_x(1, push_dir);
			var ddy = lengthdir_y(1, push_dir);
			
			if (!place_meeting(x + ddx, y, obj_wall)) {
				x += ddx;
			}
			if (!place_meeting(x, y + ddy, obj_wall)) {
				y += ddy;
			}
		}
	}
}
	
	//green tint when possessed, red when rival-controlled
	if (is_possessed) {
		image_blend = possessed_blend; 
	} else if (global.rival_active && ds_list_find_index(global.rival_targets, id) >= 0) {
		image_blend = c_red;
	} else {
		image_blend = c_white;
	}
	
//flip sprite and update image_angle based on movement direction
if (speed > 0) {
	var dir = direction;
	image_angle = dir; //keep image_angle synced to movement direction
	if (dir > 90 && dir < 270) {
		image_xscale = -1; //facing left
	} else {
		image_xscale = 1; //facing right
	}
}
x = clamp(x, 8, room_width - 8);
y = clamp(y, 8, room_height - 8);

if (!is_possessed) {
	//patrol
	scr_patrol_step(id);
	
	//detect locus7
var locus7 = instance_find(obj_locus7, 0);
if (locus7 != noone) {
    if (scr_unit_sees_locus7(id, locus7)) {
        locus_sight_timer++;
        
        if (locus_sight_timer >= ALERT_THRESHOLD) {
            //seen for 2 seconds - full alert
            global.alert_level = 2;
            global.alert_timer = 300;
            scr_hud_message("!!! ROBOT LOCKED ON LOCUS-7 !!!");
        } else {
            //just spotted - suspicious
            if (global.alert_level < 1) {
                global.alert_level = 1;
                global.alert_timer = 300;
                scr_hud_message("ROBOT DETECTING ANOMALY...");
            }
        }
    } else {
        //lost sight - reset timer
        locus_sight_timer = 0;
    }
}
	
	//rival AI override (level 3+)
	if (global.rival_active && ds_list_find_index(global.rival_targets, id) >= 0) {
		patrol_paused = true;
	}
	
	//intimidate nearby guards - they move aside
	with (obj_securityGuard) {
		if (!is_possessed && point_distance(x, y, other.x, other.y) < other.intimidate_range) {
			//push guard away from robot
			var push_dir = point_direction(other.x, other.y, x, y);
			x += lengthdir_x(2, push_dir);
			y += lengthdir_y(2, push_dir);
		}
	}
}

//image blend based on state
if (is_possessed) {
	image_blend = possessed_blend;
} else if (global.rival_active && ds_list_find_index(global.rival_targets, id) >= 0) {
	image_blend = c_red;
} else {
	image_blend = c_white;
}

//flip sprite based on movement direction
if (speed > 0) {
	var dir = direction;
	if (dir > 90 && dir < 270) {
		image_xscale = -1; //facing left
	} else {
		image_xscale = 1; //facing right
	}
}
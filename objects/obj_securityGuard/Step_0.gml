if (!is_possessed) {
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
            scr_hud_message("!!! GUARD LOCKED ON LOCUS-7 !!!");
			audio_play_sound(snd_spotted, 1, false);
        } else {
            //just spotted - suspicious
            if (global.alert_level < 1) {
                global.alert_level = 1;
                global.alert_timer = 300;
                scr_hud_message("GUARD DETECTING ANOMALY...");
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
		
		var push_dir = point_direction(nearest_robot.x, nearest_robot.y, x, y);
		var push_spd = 2;
		
		repeat(push_spd) {
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

//animate guard based on movement direction and state
//track last direction when moving
var is_moving = (x != last_x || y != last_y);

if (is_moving) {
    var new_dir = point_direction(last_x, last_y, x, y);
    //only update direction if it has changed significantly
    if (abs(angle_difference(new_dir, last_direction)) > 45) {
        last_direction = new_dir;
    }
}

last_x = x;
last_y = y;

anim_timer++;
if (anim_timer >= anim_speed) {
    anim_timer = 0;
    
    var start_frame = 0;
    
    if (is_moving) {
        if (last_direction >= 315 || last_direction < 45) start_frame = 24;
        else if (last_direction >= 45 && last_direction < 135) start_frame = 30;
        else if (last_direction >= 135 && last_direction < 225) start_frame = 36;
        else start_frame = 42;
    } else {
        if (last_direction >= 315 || last_direction < 45) start_frame = 0;
        else if (last_direction >= 45 && last_direction < 135) start_frame = 6;
        else if (last_direction >= 135 && last_direction < 225) start_frame = 12;
        else start_frame = 18;
    }
    
    var frame_offset = (image_index - start_frame + 1) mod 6;
    image_index = start_frame + frame_offset;
    image_speed = 0;
}

//keep unit inside room bounds
if (place_meeting(x, y, obj_wall)) {
    x = xprevious;
    y = yprevious;
}
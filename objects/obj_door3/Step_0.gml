//obj_door3 Step event
//check if all 4 pylons are destroyed
if (!is_open && instance_number(obj_pylon) == 0 && instance_number(obj_main_terminal) == 0){
	is_open = true;
	solid = false;
	scr_hud_message("ALL PYLONS DESTROYED - ACCESS GRANTED");
}

//animate and transition
if (is_open) {
	//play opening animation
	if (image_index < image_number - 1) {
		image_speed = 1;
	} else {
		image_speed = 0;
	}
	var host = noone;
	if (global.possessed_unit != noone) {
		host = global.possessed_unit;
	} else {
		host = instance_find(obj_locus7, 0);
	}
	
	if (host != noone) {
		if (point_distance(x, y, host.x, host.y) < 100) {
			var locus7 = instance_find(obj_locus7, 0);
			if (locus7 != noone && locus7.alarm[0] == -1) {
				global.fading = true;
				global.fade_alpha = 0;
				room_goto(rm_win)
				scr_hud_message("ESCAPING...");
			}
		}
	}
}
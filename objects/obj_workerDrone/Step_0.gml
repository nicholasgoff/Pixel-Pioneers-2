x = clamp(x, 8, room_width - 8);
y = clamp(y, 8, room_height - 8);

//obj_workerDrone Step event
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
            scr_hud_message("!!! DRONE LOCKED ON LOCUS-7 !!!");
        } else {
            //just spotted - suspicious
            if (global.alert_level < 1) {
                global.alert_level = 1;
                global.alert_timer = 300;
                scr_hud_message("DRONE DETECTING ANOMALY...");
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

//drop carried object if possession is lost
if (!is_possessed && carrying_object != noone) {
	carrying_object.is_carried = false;
	carrying_object = noone;
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
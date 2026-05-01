//obj_camera Step event

//EMP disable countdown
if (is_disabled) {
	if (disable_timer > 0) {
		disable_timer--;
	} else {
		is_disabled = false;
		locus_in_sight = false;
		locus_sight_timer = 0;
	}
	exit;
}

//detection
var locus7 = instance_find(obj_locus7, 0);
if (locus7 != noone) {
	if (scr_camera_sees(id, locus7.x, locus7.y)) {
		locus_in_sight = true;
		locus_sight_timer++;
		
		if (locus_sight_timer >= ALERT_THRESHOLD) {
			//seen for 2 seconds - full alert
			global.alert_level = 2;
			global.alert_timer = 300;
			scr_hud_message("!!! CAMERA LOCKED ON LOCUS-7 !!!");
		} else {
			//just spotted - suspicious
			if (global.alert_level < 1) {
				global.alert_level = 1;
				global.alert_timer = 300;
				scr_hud_message("CAMERA DETECTING ANOMALY...");
			}
		}
	} else {
		//locus left sight - reset timer
		locus_in_sight = false;
		locus_sight_timer = 0;
	}
}
//scr_alert_step()
// call every step from obj_locus7
// handles alert level decay over time
function scr_alert_step() {
	if (global.alert_timer > 0) {
		global.alert_timer--;
	} else {
		//timer expired - decay alert level
		if (global.alert_level > 0) {
			global.alert_level--;
			global.alert_timer = 300; //5 seconds before next decay
		}
	}
	
	//full alert - eject locus from host
	if (global.alert_level >= 2) {
		if (global.possessed_unit != noone) {
			scr_force_eject(obj_locus7);
			 global.alert_level = 1; //step down after ejecting
		}
	}
}
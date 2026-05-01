//scr_alert_step()
// call every step from obj_locus7
// handles alert level decay over time
function scr_alert_step() {
	if (global.alert_timer > 0) {
		global.alert_timer--;
	} else {
		if (global.alert_level > 0) {
			global.alert_level--;
			global.alert_timer = 300;
		}
	}
	
	//full alert - eject locus from host
	if (global.alert_level == 2) {
		if (global.possessed_unit != noone) {
			scr_force_eject(obj_locus7);
			global.alert_level = 1;
		}
		
		//drain locus hp - 1 HP every 2 seconds
		global.locus_drain_timer++;
		if (global.locus_drain_timer >= 120) { //2 seconds at 60fps
			global.locus_drain_timer = 0;
			global.locus_hp--;
			scr_hud_message("WARNING - LOCUS INTEGRITY FAILING");
			
			//game over
			if (global.locus_hp <= 0) {
				global.locus_hp = 0;
				room_goto(rm_gameover);
			}
		}
		
		//reset regen timer when on full alert
		global.locus_regen_timer = 0;
		
	} else if (global.alert_level == 0) {
		//regen hp after 10 seconds of calm
		global.locus_drain_timer = 0;
		global.locus_regen_timer++;
		
		if (global.locus_regen_timer >= 600) { //10 seconds at 60fps
			if (global.locus_hp < global.locus_hp_max) {
				global.locus_hp++;
				global.locus_regen_timer = 0;
			}
		}
	} else {
		//level 1 alert - no drain no regen, reset both timers
		global.locus_drain_timer = 0;
		global.locus_regen_timer = 0;
	}
}
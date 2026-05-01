//obj_rivalAi Step event
if (!global.rival_active) exit;

//seize timer
rival_seize_timer++;
if (rival_seize_timer >= rival_seize_interval) {
	rival_seize_timer = 0;
	scr_rival_seize_unit();
}

//move all seized units toward locus
var locus7 = instance_find(obj_locus7, 0);
if (locus7 != noone) {
	with (obj_securityGuard) {
		if (ds_list_find_index(global.rival_targets, id) >= 0) {
			scr_rival_unit_pursue(id, locus7);
		}
	}
	with (obj_workerDrone) {
		if (ds_list_find_index(global.rival_targets, id) >= 0) {
			scr_rival_unit_pursue(id, locus7);
		}
	}
	with (obj_securityRobot) {
		if (ds_list_find_index(global.rival_targets, id) >= 0) {
			scr_rival_unit_pursue(id, locus7);
		}
	}
}
//Redirect current level from room 
ds_list_clear(global.rival_targets);
if (room == rm_levelOne) global.current_level = 1;
else if (room == rm_levelTwo) global.current_level = 2; 
else if (room == rm_levelThree) { global.current_level = 3; global.rival_active = true; }

global.level_complete = false; 
global.alert_level = 0; 
global.alert_timer = 0;
global.possessed_unit = noone;
global.locus_hp = global.locus_hp_max;
global.locus_drain_timer = 0;
global.locus_regen_timer = 0;
visible = true;

with (obj_camera) {
	if (!variable_instance_exists(id, "face_direction")) face_direction = 270;
	if (!variable_instance_exists(id, "view_fov")) view_fov = 30;
	if (!variable_instance_exists(id, "view_range")) view_range = 200;
	if (!variable_instance_exists(id, "is_disabled")) is_disabled = false;
	if (!variable_instance_exists(id, "disable_timer")) disable_timer = 0;
	if (!variable_instance_exists(id, "locus_in_sight")) locus_in_sight = false;
	if (!variable_instance_exists(id, "locus_sight_timer")) locus_sight_timer = 0;
	if (!variable_instance_exists(id, "ALERT_THRESHOLD")) ALERT_THRESHOLD = 120;
}
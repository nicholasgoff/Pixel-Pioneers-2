//obj_button Step event
if (is_pressed) exit;

//check if possessed unit is near and pressing F
if (global.possessed_unit != noone) {
	var host = global.possessed_unit;
	if (keyboard_check_pressed(ord("F")) && point_distance(x, y, host.x, host.y) < 64) {
		is_pressed = true;
		if (instance_exists(linked_door)) {
			instance_destroy(linked_door);
			scr_hud_message("DOOR OPENED");
		}
	}
}
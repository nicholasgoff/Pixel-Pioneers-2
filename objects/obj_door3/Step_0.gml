//obj_door3 Step event
//check if all 4 pylons are destroyed
if (!is_open && instance_number(obj_pylon) == 0) {
	is_open = true;
	solid = false;
	scr_hud_message("ALL PYLONS DESTROYED - ACCESS GRANTED");
}

//animate door
if (is_open) {
	if (image_index < image_number - 1) {
		image_speed = 1;
	} else {
		image_speed = 0;
	}
}
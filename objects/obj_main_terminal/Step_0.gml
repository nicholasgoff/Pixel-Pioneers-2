//obj_main_terminal Step event
if (hit_cooldown > 0) hit_cooldown--;

//open door when destroyed
if (is_destroyed) {
	with (obj_door3) {
		is_open = true;
		solid = false;
	}
}
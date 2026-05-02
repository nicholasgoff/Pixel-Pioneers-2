//obj_keycardDoor Step event
var nearest_guard = instance_nearest(x, y, obj_securityGuard);
var guard_close = false;

if (nearest_guard != noone) {
	if (point_distance(x, y, nearest_guard.x, nearest_guard.y) < 64) {
		guard_close = true;
	}
}

//open if guard is close or door was manually opened via interact
if (guard_close || is_open) {
	solid = false;
	if (image_index < image_number - 1) {
		image_speed = 1; //play forward
	} else {
		image_speed = 0; //freeze at last frame
	}
} else {
	//play in reverse when guard walks away
	if (image_index > 0) {
		image_speed = -1; //play backward
	} else {
		image_speed = 0; //freeze at first frame
		solid = true;
	}
}
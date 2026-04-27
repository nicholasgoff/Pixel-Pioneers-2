//shared helper functions used by guard, drone, and robot objects

//scr_patrol_step(inst)
// simple waypoint patrol. inst must have: 
//	  inst.patrol_points - array of [x,y] pairs
//    inst.patrol_index - current waypoint index
//    inst.patrol_speed - pixels per frame
//    inst.patrol_paused - bool; true while possessed
//    inst.return_timer  - countdown before resuming release
function scr_patrol_step(inst) {
	if (inst.patrol_paused) {
		if (inst.return_timer > 0) {
			inst.return_timer--;
		} else {
			inst.patrol_paused = false;
		}
		return;
	}
	
	var target_x = inst.patrol_points[inst.patrol_index][0];
	var target_y = inst.patrol_points[inst.patrol_index][1];
	var dist = point_distance(inst.x, inst.y, target_x, target_y);
	
	if (dist < inst.patrol_speed) {
		//arrived - advance to next waypoint
		inst.x = target_x;
		inst.y = target_y;
		inst.patrol_index = (inst.patrol_index + 1) mod array_length(inst.patrol_points);
	} else {
		var dir = point_direction(inst.x, inst.y, target_x, target_y);
		inst.x += lengthdir_x(inst.patrol_speed, dir);
		inst.y += lengthdir_y(inst.patrol_speed, dir);
		inst.image_angle = dir; // face direction of travel
	}
}

//scr_camer_sees(cam_inst, tx, ty)
// returns true if point (tx, ty) is withing the cameras cone of vision
// cam_inst must have:
//  cam_inst.view_angle - direction the camera faces (degrees)
//  cam_inst.view_fov - half-angle of cone
//  cam_inst.view_range - max distance in pixels
function scr_camera_sees(cam_inst, tx, ty) {
	var dist = point_distance(cam_inst.x, cam_inst.y, tx, ty);
	if (dist > cam_inst.view_range) return false; 
	
	var dir_to_target = point_direction(cam_inst.x, cam_inst.y, tx, ty);
	var angle_diff = abs(angle_difference(dir_to_target, cam_inst.view_angle)); 
	
	if (angle_diff > cam_inst.view_fov) return false; 
	
	//Line of sight check against walls
	if (collision_line(cam_inst.x, cam_inst.y, tx, ty, obj_wall, false, false))
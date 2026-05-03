if (global.possessed_unit == noone) {
	//animate locus based on movement direction
	var is_moving = (x != last_x || y != last_y);
	
	if (is_moving) {
		var new_dir = point_direction(last_x, last_y, x, y);
		if (abs(angle_difference(new_dir, last_direction)) > 45) {
			last_direction = new_dir;
		}
	}
	
	last_x = x;
	last_y = y;
	
	anim_timer++;
	if (anim_timer >= anim_speed) {
		anim_timer = 0;
		
		var start_frame = 0;
		if (last_direction >= 315 || last_direction < 45) start_frame = 0;
		else if (last_direction >= 45 && last_direction < 135) start_frame = 6;
		else if (last_direction >= 135 && last_direction < 225) start_frame = 12;
		else start_frame = 18;
		
		var frame_offset = (image_index - start_frame + 1) mod 6;
		image_index = start_frame + frame_offset;
		image_speed = 0;
	}
	
	//threat detection for shader
	var threat = 0;
	
	with (obj_camera) {
		if (!is_disabled) {
			var d = point_distance(x, y, other.x, other.y); 
			var t = 1 - clamp(d / view_range, 0, 1);
			threat = max(threat, t);
		}
	}
	
	with (obj_securityGuard) {
		if (!is_possessed) {
			var d = point_distance(x, y, other.x, other.y); 
			var t = 1 - clamp(d / sight_range, 0, 1);
			threat = max(threat, t);
		}
	}
	
	with (obj_securityRobot) {
		if (!is_possessed) {
			var d = point_distance(x, y, other.x, other.y); 
			var t = 1 - clamp(d / sight_range, 0, 1);
			threat = max(threat, t);
		}
	}
	
	with (obj_rivalAi) {
		var d = point_distance(x, y, other.x, other.y); 
		var t = 1 - clamp(d / sight_range, 0, 1);
		threat = max(threat, t);
	}
	
	threat = max(threat, 0.2);
	
	shader_set(shd_detection_pulse); 
	shader_set_uniform_f(shader_get_uniform(shd_detection_pulse, "u_intensity"), threat);
	draw_self(); 
	shader_reset();
} else {
	
}
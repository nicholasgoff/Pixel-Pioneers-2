//Apply shader if in free roam form
if (global.possessed_unit == noone) {
	
	var threat = 0;
	
	//Check Cameras
	with (obj_camera) {
		if (!is_disabled) {
			var d = point_distance(x, y, other.x, other.y); 
			var t = 1 - clamp(d / view_range, 0, 1);
			threat = max(threat, t);
		}
	}
	
	//check guards
	with (obj_securityGuard) {
		if (!is_possessed) {
			var d = point_distance(x, y, other.x, other.y); 
			var t = 1 - clamp(d / sight_range, 0, 1);
			threat = max(threat, t);
		}
	}
	
	//check security robot
	with (obj_securityRobot) {
		if (!is_possessed) {
			var d = point_distance(x, y, other.x, other.y); 
			var t = 1 - clamp(d / sight_range, 0, 1);
			threat = max(threat, t);
		}
	}
	
	//check rivalAi
	with (obj_rivalAi) {
			var d = point_distance(x, y, other.x, other.y); 
			var t = 1 - clamp(d / sight_range, 0, 1);
			threat = max(threat, t);
	}
	
	//show a minimum glow to show shader active
	threat = max(threat, 0.2);
	
	
	shader_set(shd_detection_pulse); 
	shader_set_uniform_f(shader_get_uniform(shd_detection_pulse, "u_intensity"), threat);
	draw_self(); 
	shader_reset();
} else {
	//inside host - no shader
	draw_self();
}
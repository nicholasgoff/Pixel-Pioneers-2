draw_self();

if (!is_disabled) {
	draw_set_alpha(0.15);
	
	var locus7 = instance_find(obj_locus7, 0);
	if (locus7 != noone && scr_camera_sees(id, locus7.x, locus7.y)) {
		draw_set_color(c_red);
	} else {
		draw_set_color(c_yellow);
	}
	
	var cone_dir = face_direction;
	var cone_half = view_fov;
	var px1 = x + lengthdir_x(view_range, cone_dir - cone_half);
	var py1 = y + lengthdir_y(view_range, cone_dir - cone_half);
	var px2 = x + lengthdir_x(view_range, cone_dir + cone_half);
	var py2 = y + lengthdir_y(view_range, cone_dir + cone_half);
	draw_triangle(x, y, px1, py1, px2, py2, false);
	draw_set_alpha(1);
	draw_set_color(c_white);
} else {
	draw_set_alpha(0.15);
	draw_set_color(c_gray);
	var cone_dir = face_direction;
	var cone_half = view_fov;
	var px1 = x + lengthdir_x(view_range, cone_dir - cone_half);
	var py1 = y + lengthdir_y(view_range, cone_dir - cone_half);
	var px2 = x + lengthdir_x(view_range, cone_dir + cone_half);
	var py2 = y + lengthdir_y(view_range, cone_dir + cone_half);
	draw_triangle(x, y, px1, py1, px2, py2, false);
	draw_set_alpha(1);
	draw_set_color(c_white);
}
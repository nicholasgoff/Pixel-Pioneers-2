draw_self(); 

//sight cone 
if (!is_possessed) {
	draw_set_alpha(0.1);
//turn red if locus is spotted
	var locus7 = instance_find(obj_locus7, 0);
	if (locus7 != noone && scr_unit_sees_locus7(id, locus7)) {
		draw_set_color(c_red);
	} else {
		draw_set_color(c_yellow);
	}
	var cone_dir = direction; 
	var cone_half = sight_angle; 
	var px1 = x + lengthdir_x(sight_range, cone_dir - cone_half); 
	var py1 = y + lengthdir_y(sight_range, cone_dir - cone_half); 
	var px2 = x + lengthdir_x(sight_range, cone_dir + cone_half); 
	var py2 = y + lengthdir_y(sight_range, cone_dir + cone_half);
	draw_triangle(x, y, px1, py1, px2, py2, false); 
	draw_set_alpha(1); 
	draw_set_colour(c_white); 
}
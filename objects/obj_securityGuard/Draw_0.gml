draw_self(); 

//sight cone 
if (!is_possessed) {
	draw_set_alpha(0.1);
	draw_set_colour(c_yellow); 
	var cone_dir = image_angle; 
	var cone_half = sight_angle; 
	var px1 = x + lengthdir_x(sight_range, cone_dir - cone_half); 
	var py1 = y + lengthdir_y(sight_range, cone_dir - cone_half); 
	var px2 = x + lengthdir_x(sight_range, cone_dir + cone_half); 
	var py2 = y + lengthdir_y(sight_range, cone_dir + cone_half);
	draw_triangle(x, y, px1, py1, px2, py2, false); 
	draw_set_alpha(1); 
	draw_set_colour(c_white); 
}

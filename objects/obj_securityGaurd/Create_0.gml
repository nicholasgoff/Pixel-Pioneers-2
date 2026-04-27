unit_name = "SECURITY GUARD";
move_speed = 1.8;
can_sprint = true;
is_possessed = false;
patrol_paused = false; 
return_timer = 0; 
patrol_index = 0;

//patrol waypoints - OVERRIDE in room's creation
patrol_points = [[x, y]];

//sight / detection 
sight_range = 150; 
sight_angle = 60; 

//image tint for possession indicator
possessed_blend = make_colour_rgb(100, 255, 100);
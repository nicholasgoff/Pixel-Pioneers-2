//patrol
patrol_points = [[0,0],[0,0]]; //override in room editor creation code per guard
patrol_index = 0;
patrol_speed = 2;
patrol_paused = false;
return_timer = 0;

//possession
is_possessed = false;
possessed_blend = c_lime;
unit_name = "SECURITY GUARD";
move_speed = 2;
can_sprint = true;

//vision
sight_range = 150;
sight_angle = 45; //half angle - total cone is 90 degrees

//stats
stamina = 100;
stamina_max = 100;
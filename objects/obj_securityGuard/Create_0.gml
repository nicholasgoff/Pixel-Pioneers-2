patrol_path = -1;  //assign in room editor creation code
patrol_speed = 0.7;  //adjust per unit type
patrol_paused = false;
return_timer = 0;
patrol_resume = false;
patrol_path_pos = 0; //saves position on path when possessed
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
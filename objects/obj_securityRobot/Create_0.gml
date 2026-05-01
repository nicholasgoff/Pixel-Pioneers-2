patrol_path = -1;  //assign in room editor creation code
patrol_speed = 0.5;  //adjust per unit type
patrol_paused = false;
return_timer = 0;
patrol_resume = false;
patrol_path_pos = 0;
//possession
is_possessed = false;
possessed_blend = c_lime;
unit_name = "SECURITY ROBOT";
move_speed = 1;
can_sprint = false; //robots don't sprint

//vision
sight_range = 120;
sight_angle = 35; //narrower cone than guard, 70 degrees total

//robot specific
intimidate_range = 80; //distance at which guards move aside
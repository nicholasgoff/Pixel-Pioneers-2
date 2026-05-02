patrol_path = -1;  //assign in room editor creation code
patrol_speed = 2;  //adjust per unit type
patrol_paused = false;
return_timer = 0;
patrol_resume = false;
patrol_path_pos = 0;

//possession
is_possessed = false;
possessed_blend = c_lime;
unit_name = "WORKER DRONE";
move_speed = 3;
can_sprint = false; 

//vision
sight_range = 100; //shorter range than guard
sight_angle = 60; //wider cone, 120 degrees total
locus_sight_timer = 0;
ALERT_THRESHOLD = 120; //2 seconds at 60fps
//drone specific
carrying_object = noone; //for object carry mechanic
emp_cooldown = 0; //frames before EMP can be used again
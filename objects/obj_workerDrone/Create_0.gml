//obj_workerDrone Create event
//patrol
patrol_points = [[0,0],[0,0]]; //override in room editor creation code per drone
patrol_index = 0;
patrol_speed = 3; //slightly faster than guard
patrol_paused = false;
return_timer = 0;

//possession
is_possessed = false;
possessed_blend = c_lime;
unit_name = "WORKER DRONE";
move_speed = 3;
can_sprint = false; 

//vision
sight_range = 100; //shorter range than guard
sight_angle = 60; //wider cone, 120 degrees total

//drone specific
carrying_object = noone; //for object carry mechanic
emp_cooldown = 0; //frames before EMP can be used again
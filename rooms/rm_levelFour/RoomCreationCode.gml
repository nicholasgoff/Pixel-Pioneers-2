//LEVEL 4 - THE CORE (BOSS)
global.current_level = 4;
global.level_complete = false; 
global.alert_level = 0;
global.alert_timer = 0;
global.possessed_unit = noone; 
ds_list_clear(global.rival_targets);

scr_boss_init(); //sets rival_active = true, boss_hp = 3, phases

with (obj_locus7) { x = 80; y = 360; visible = true; }

// Gaurds (mix)
var g1 = instance_create_layer(300, 200, "Instances", obj_securityGaurd);
g1.patrol_points = [[200, 200], [500, 200]];
var g2 = instance_create_layer(300, 520, "Instances", obj_securityGaurd);
g2.patrol_points = [[200, 520], [500, 520]];
var g3 = instance_create_layer(800, 360, "Instances", obj_securityGaurd);
g3.patrol_points = [[700, 360], [1000, 360]]; 

//Drone
var d = instance_create_layer(200, 360, "Instances", obj_workerDrone);
d.patrol_points = [[200, 360], [200, 200]];

//Robot
var rb = instance_create_layer(600, 500, "Instances", obj_securityRobot);
rb.patrol_points = [[600, 500], [900, 500]];

//Pre-Place rival AI (2 at start) 
var r1 = instance_create_layer(700, 200, "Instances", obj_rivalAi);
var r2 = instance_create_layer(700, 520, "Instances", obj_rivalAi);

//Cameras
var cam1 = instance_create_layer(500, 80, "Instances", obj_camera);
cam1.view_angle = 270; cam1.base_angle = 270; cam1.view_fov = 50;
var cam2 = instance_create_layer(1000, 80, "Instances", obj_camera);
cam2.view_angle = 270; cam2.base_angle = 270; cam2.view_fov = 50;

//Doors
instance_create_layer(550, 360, "Instances", obj_keycardDoor);
instance_create_layer(1050, 360, "Instances", obj_keycardDoor);

//Core uplink terminal (boss mechanic target)
var core = instance_create_layer(1200, 360, "Instances", obj_terminal);
with (core) {
	is_exit = true; 
	lore_text = "CORE UPLINK - REDIRECT A RIVAL UNIT TO OVERLOAD"; 
}

scr_hud_message("LEVEL 4 - POSSESS RIVAL UNITS. REDIRECT THEM TO THE CORE.");
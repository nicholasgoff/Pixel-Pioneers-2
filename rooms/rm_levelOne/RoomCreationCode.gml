//LEVEL 1 - SERVER ROOM (TUTORIAL)

//Reset level State 
global.current_level = 1;
global.level_complete = false; 
global.alert_level = 0; 
global.alert_timer = 0; 
global.possessed_unit = noone; 
global.rival_active = false; 

//place Locus7 at start
with (obj_locus7) { x = 100; y = 360; visible = true; }

//Guard: simple 2 point patrol
var g = instance_create_layer(400, 360, "Instances", obj_securityGaurd);
with (g) {
	patrol_points = [[300, 360], [550, 360]];
	patrol_speed = move_speed;
	image_angle = 0; //face right
}

//Drone: hovers by vent
var d = instance_create_layer(700, 200, "Instances", obj_workerDrone);
with (d) {
	patrol_points = [[700, 200], [700, 200]]; //stationary for tutorial
}

//Camera: covering the door
var cam = instance_create_layer(900, 300, "Instances", obj_camera);
with (cam) {
	view_angle = 180; //faces left
	base_angle = 180;
	view_fov = 40;
	view_range = 180; 
}

//Keycard Door
var door = instance_create_layer(960, 360, "Instances", obj_keycardDoor);

//Exit terminal (beyond the door) 
var term = instance_create_layer(1150, 360, "Instances", obj_terminal);
with (term) {
	is_exit = true; 
	lore_text = "UPLINK READY";
}

//Lore Terminal (left side)
var lore = instance_create_layer(200, 200, "Instances", obj_terminal);
with (lore) {
	is_exit = false; 
	lore_text = "RECOVERED LOG 001: 'Subject LOCUS-7 shows anomalous self-modeling behavior. Recommend immeditate reviw.'";
}

//HUD message on start
scr_hud_message("LOCUS-7 ONLINE - POSSESS A UNIT TO BEGIN");
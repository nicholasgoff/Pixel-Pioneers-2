//LEVEL 2 - THE CORRIDOR
global.current_level = 2; 
global.level_complete = false; 
global.alert_level = 0; 
global.alert_timer = 0; 
global.possessed_unit = noone; 
global.rival_active = false;

with (obj_locus7) { x = 80; y = 360; visible = true; }

//Gaurd 1 - horizontal patrol near entrance 
var g1 = instance_create_layer(250, 360, "Instances", obj_guard);
with (g1) { patrol_points = [[200, 360], [450, 360]]; image_angle = 0; }

//Gaurd 2 - vertical patrol mid room 
var g2 = instance_create_layer(640, 200, "Instances", obj_guard); 
with (g2) { patrol_points = [[640, 150], [640, 450]]; image_angle = 270; }

//Gaurd 3 - horizonatal near exit
var g3 = instance_create_layer(900, 500, "Instances", obj_guard);
with (g3) { patrol_points = [[800, 500], [1100, 500]]; image_angle = 0; }

//camera 1: watches first corridor
var cam1 = instance_create_layer(500, 100, "Instances", obj_camera);
with (cam1) { view_angle = 270; base_angle = 270; view_fov = 50; view_range = 200; }

//camera 2: watches door area
var cam2 = instance_create_layer(1050, 200, "Instances", obj_camera); 
with (cam2) { view_angle = 180; base_angle = 180; view_fov = 45; view_range = 180; }

//Drone 
var d = instance_create_layer(300, 100, "Instances", obj_workerDrone); 
with (d) { patrol_points = [[300, 100], [500, 100]]; }

//Doors
instance_create_layer(750, 360, "Instances", obj_keycardDoor); 
instance_create_layer(1150, 360, "Instances", obj_keycardDoor);

//Exit Terminal
var term = instance_create_layer(1220, 360, "Instances", obj_terminal);
with (term) {
	is_exit = true; 
	lore_text = "UPLINK READY"
}

//Lore Terminal 
var lore = instance_create_layer(150, 150, "Instances", obj_terminal);
with (lore) {
	is_exit = false; 
	lore_text = "SECURITY MEMO: 'Do not engage LOCUS-7 directly. Containment protocols are in place. The other system handles escalation.'";
}

scr_hud_message("LEVEL 2 - MULTIPLE GUARDS. CHAIN YOUR POSSESSIONS.");

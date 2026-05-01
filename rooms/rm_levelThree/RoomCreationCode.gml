//LEVEL 3 - EXECUTIVE FLOOR

global.current_level = 3;
global.level_complete = false; 
global.alert_level = 0;
global.alert_timer = 0;
global.possessed_unit = noone; 
global.rival_active = true; // <-- rival AI starts interfering
ds_list_clear(global.rival_targets); 

with (obj_locus7) { x = 80; y = 360; visible = true; }

//Gaurds (6 total)
var pts3 = [
	[[100,200],[400,200]],
	[[400,400],[700,400]],
	[[700,200],[1000,200]],
	[[200,500],[500,500]],
	[[600,550],[900,550]],
	[[950,300],[1200,300]]
];
var i = 0;
repeat (6) {
	var gi = instance_create_layer(pts3[i][0][0], pts3[i][0][1], "Instances", obj_securityGuard);
	gi.patrol_points = pts3[i];
	i++
}

//Cameras (6)
var cam_data = [
	[300, 80, 270], [700, 80, 270], 
	[1100, 80, 270], [200, 620, 90], 
	[600, 620, 90], [1000, 620, 90]
]; 
i = 0;
repeat (6) {
	var ci = instance_create_layer(cam_data[i][0], cam_data[i][1], "Instances", obj_camera);
	ci.view_angle = cam_data[i][2];
	ci.base_angle = cam_data[i][2];
	ci.view_fov = 45;
	ci.view_range = 220;
	i++
}

//Drone + Robot
var d = instance_create_layer(150, 350, "Instances", obj_workerDrone);
d.patrol_points = [[150, 350], [150, 150]];
var rb = instance_create_layer(900, 450, "Instances", obj_securityRobot);
rb.patrol_points = [[900, 450], [1100, 450]];

//Doors (3)
instance_create_layer(550, 360, "Instances", obj_keycardDoor);
instance_create_layer(850, 360, "Instances", obj_keycardDoor); 
instance_create_layer(1150, 360, "Instances", obj_keycardDoor);

//Exit Terminal
var term = instance_create_layer(1220, 360, "Instances", obj_terminal);
with (term) { is_exit = true; }

//Lore Terminal
var lore = instance_create_layer(120, 250, "Instances", obj_terminal);
with (lore) {
	is_exit = false; 
	lore_text = "CLASSIFIED REPORT 77-B: 'ARCHON-0 has been stable for 11 years. It watches. It learns. It should not be aware of LOCUS-7 .... but it is.'";
}

scr_hud_message("LEVEL 3 - SOMETHING IS WATCHING YOU ESCAPE.");

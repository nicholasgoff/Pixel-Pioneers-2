//Call this ONCE from obj_locus7 create event or persisten controller object
//Initialises all global state for Possession Protocol

function scr_global_init(){
	//Core possession state
	global.possessed_unit = noone; //instance currently inhabited
	global.locus_x = 0; //locus world position (synced when free)
	global.locus_y = 0; 
	
	//level / progression
	global.current_level = 1; // 1-4
	global.level_complete = false;
	
	//AI Systems 
	global.rival_active = false; //true from level 3 onward
	global.rival_targets = ds_list_create(); //instances the rival AI controls
	
	//Alert system
	// 0 = calm | 1 = suspicious | 2 = full alert (ejects locus from host)
	global.alert_level = 0;
	global.alert_timer = 0;  // frames before alert decays
	
	// HUD / UI
	global.hud_message = ""; //bottom screen text
	global.hud_msg_timer = 0; //frames remaining to show message
	
	// Stamina (used by guards and robots when sprinting
	global.host_stamina = 100;
	global.hot_stamina_max = 100;
	
}
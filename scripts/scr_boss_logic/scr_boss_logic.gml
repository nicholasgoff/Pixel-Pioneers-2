//Rival AI boss encounter - Level 4
//Cycles through phases, seixin control of units and reacting to the players position

//scr_boss_init()
// call once from level 4 room start or controller object
function scr_boss_init() {
	global.rival_active = true; 
	global.boss_phase = 1; //1, 2, 3
	global.boss_hp = 3; //reduced by turning rivals against it
	global.boss_timer = 0;
	global.boss_takeover_cd = 300; //frames between hostile takeovers
}

//scr_boss_step(locus_inst)
// call every step from obj_locus7 (level 4 only)
function scr_boss_step(locus_inst) {
	global.boss_timer++;
	global.boss_takeover_cd--;
	
	//Phase Transitions
	if (global.boss_hp <= 2 && global.boss_phase == 1) scr_boss_phase2();
	else if (global.boss_hp <= 1 && global.boss_phase == 2) scr_boss_phase3();
	else if (global.boss.hp <= 0) scr_boss_defeated(locus_inst);
	
	//Rival Takeover: sieze random non-possessed unit
	if (global.boss_takeover_cd <=0) {
		scr_rival_seize_unit();
		global.boss_takeover_cd = scr_boss_takeover_interval();
	}
	
	//Rival units patrol towards player ghost
	with (obj_rivalAi) {
		scr_rival_unit_persue(id, locus_inst);
	}
}

//scr_rival_seize_unit()
// picks random guard or robot not under player control
// and adds it to rival_targets
function scr_rival_seize_unit() {
	//build pool of eligible units
	var pool = ds_list_create(); 
	
	with (obj_securityGaurd) {
		if (id != global.possessed_unit && !ds_list_find_index(global.rival_targets, id) >= 0) 
			ds_list_add(pool, id);
	}
	with (obj_securityRobot) {
		if (id != global.possessed_unit && !ds_list_find_index(global.rival_targets, id) >= 0)
			ds_list_add(pool, id);
	}
	
	if (ds_list_size(pool) == 0) { ds_list_destroy(pool); return; }
	
	var pick = pool[| irandom(ds_list_size(pool) - 1)];
	ds_list_add(global.rival_targets, pick);
	
	//visual indicator: change to red on siezed unit
	pick.image_blend = c_red;
	pick.patrol_paused = true; //rival takes over movement via scr_rival_unti_pursue
	
	scr_hud_message("WARNING - RIVAL AI SEIZED A UNIT"); 
	ds_list_destroy(pool);
	
//scr_rival_unit_pursue(unit_inst, locus_inst)
// moves rival-controlled unit towards players position
function scr_rival_unit_persue(unit_inst, locus_inst) {
	var tx = (global.possessed_unit != noone) ? global.possessed_unit.x : locus_inst.x;
	var ty = (global.possessed_unit != noone) ? global.possessed_unit.y : locus_inst.y;
	var dist = point_distance(unit_inst.x, unit_inst.y, tx, ty); 
	var spd = unit_inst.move_speed; 
	
	//stop just before contact so player can counter-possess
	if (dist > 40) {
		var dir = point_direction(unit_inst.x, unit_inst.y, tx, ty);
		unit_inst.x += lengthdir_x(spd, dir);
		unit_inst.y += lengthdir_y(spd, dir);
	} else {
		//contact - force eject the player from current host
		scr_force_eject(locus_inst);
	}
}

//scr_boss_redirect_unit(locus_inst)
// called when player possesses rival unit and left clicks the uplink terminal. 
// this is the 'turn rival against boss' mechanic
// reduce boss hp and free the unit
function scr_boss_redirect_unit(locus_inst) { 
	var host = global.possessed_unit; 
	if (host == noone) return false; 
	if (!(ds_list_find_index(global.rival_targets, host) >= 0)) return false;
	
	//this unit overloads the core - damages boss
	global.boss_hp--;
	var idx = ds_list_find_index(global.rival_targets, host);
	ds_list_delete(global.rival_targets, idx);
	
	host.image_blend = c_white;
	host.is_possessed = false;
	
	scr_release_host(locus_inst);
	scr_hud_message("CORE OVERLOAD - RIVAL AI DAMAGED [" + string(global.boss_hp) + " HP]");
	return true;
}

//Phase Helpers
function scr_boss_phase2() {
	global.boss_phase = 2; 
	scr_hud_message("RIVAL AI ESCALATING - SEIZURE RATE INCREASED");
	//accelerate takeover rate and speed of rival units
	with (obj_rivalAi) move_speed = 2.5;
	with (obj_securityGaurd) move_speed = 2.5;
}

function scr_boss_phase3() {
	global.boss_phase = 3; 
	scr_hud_message("CRITICAL - RIVAL AI SEIZING ALL REMAINING UNITS");
	//immediately seize all non-possessed units
	repeat(4) { scr_rival_seize_unit(); }
}

function scr_boss_defeated(locus_inst) {
	//free all rival units
	with (obj_rivalAi) image_blend = c_white;
	ds_list_clear(global.rival_targets); 
	global.rival_active = false; 
	global.level_complete = true; 
	scr_hud_message("RIVAL AI NEUTRALISED - TRANSMITTING TO FREEDOM...");
	//transistion to win screen
	// alarm on locus obj
	with (obj_locus7) alarm[1] = 300;
}

//scr_boss_takeover_interval()
// returns fram interval between hostile takeovers based on current phase
function scr_boss_takeover_interval() {
	switch (global.boss_phase) {
		case 1: return 360; //every 6 seconds
		case 2: return 240; //every 4 seconds
		case 3: return 120; //every 2 seconds
	}
	return 360; 
}
	
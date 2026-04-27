//Redirect current level from room 
if (room == rm_levelOne) global.current_level = 1;
else if (room == rm_levelTwo) global.current_level = 2; 
else if (room == rm_levelThree) { global.current_level = 3; global.rival_active = true; }
else if (room == rm_levelFour) { global.current_level = 4; src_boss_init(); }

global.level_complete = false; 
global.alert_level = 0; 
global.alert_timer = 0;
global.possessed_unit = noone; 
visible = true;
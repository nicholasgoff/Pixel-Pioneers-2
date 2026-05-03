if (!is_opening && global.has_key) {
    var host = noone;
    if (global.possessed_unit != noone) {
        host = global.possessed_unit;
    } else {
        host = instance_find(obj_locus7, 0);
    }
    
    if (host != noone && keyboard_check_pressed(ord("F"))) {
        if (point_distance(x, y, host.x, host.y) < 64) {
            is_opening = true;
            image_speed = 1;
            scr_hud_message("ACCESS GRANTED - EVACUATING...");
        }
    }
}

//when animation finishes trigger fade and level transition
if (is_opening && !is_open) {
    if (image_index >= image_number - 1) {
        is_open = true;
        image_speed = 0;
        //check locus7's alarm not elevator's alarm
        var locus7 = instance_find(obj_locus7, 0);
        if (locus7 != noone && locus7.alarm[0] == -1) {
            global.fading = true;
            global.fade_alpha = 0;
            locus7.alarm[0] = 180;
        }
    }
}
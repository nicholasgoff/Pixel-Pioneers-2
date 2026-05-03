if (is_pressed) exit;

var host = noone;

//get current controller - possessed unit or free roam locus
if (global.possessed_unit != noone) {
    host = global.possessed_unit;
} else {
    host = instance_find(obj_locus7, 0);
}

if (host != noone) {
    if (keyboard_check_pressed(ord("F")) && point_distance(x, y, host.x, host.y) < 64) {
        is_pressed = true;
		audio_play_sound(snd_button, 1, false)
        if (instance_exists(linked_door)) {
            instance_destroy(linked_door);
            scr_hud_message("DOOR OPENED");
		}
    }
}
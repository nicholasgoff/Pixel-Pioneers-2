if (is_collected) exit;

//check if locus or any possessed unit is nearby
var collector = noone;

if (global.possessed_unit != noone) {
    if (point_distance(x, y, global.possessed_unit.x, global.possessed_unit.y) < 48) {
        collector = global.possessed_unit;
    }
} else {
    var locus7 = instance_find(obj_locus7, 0);
    if (locus7 != noone && point_distance(x, y, locus7.x, locus7.y) < 48) {
        collector = locus7;
    }
}

if (collector != noone) {
    is_collected = true;
    global.has_key = true;
	audio_play_sound(snd_collect, 1, false);
    scr_hud_message("KEY COLLECTED");
    instance_destroy();
}
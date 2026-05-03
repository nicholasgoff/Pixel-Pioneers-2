var host = noone;
if (global.possessed_unit != noone) {
    host = global.possessed_unit;
} else {
    host = instance_find(obj_locus7, 0);
}

if (host != noone) {
    if (point_distance(x, y, host.x, host.y) < 48) {
        scr_hud_message("DOOR LOCKED - FIND BUTTON TO UNLOCK");
    }
}
//obj_keycardDoor Step event
if (is_open) {
    solid = false;
    //reset door if no guard is nearby
    //doors stay open permanently once opened
}

// block locus7 ghost from passing through
if (place_meeting(x, y, obj_locus7)) {
    if (global.possessed_unit == noone) {
        // push locus back
        with (obj_locus7) {
            x = xprevious;
            y = yprevious;
        }
    }
}
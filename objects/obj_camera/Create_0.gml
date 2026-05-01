view_angle = 0  //set per camera in room editor creation code
view_fov = 45;       //half angle - 90 degree total cone
view_range = 200;    //max detection distance in pixels

//disable state (EMP)
is_disabled = false;
disable_timer = 0;

//detection
locus_in_sight = false;
locus_sight_timer = 0; //frames locus has been in view
ALERT_THRESHOLD = 120; //2 seconds at 60fps before full alert 0;
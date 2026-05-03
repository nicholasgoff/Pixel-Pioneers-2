var cam = view_camera[0];

var cam_w = camera_get_view_width(cam);
var cam_h = camera_get_view_height(cam);

var cam_x = x - cam_w / 2;
var cam_y = y - cam_h / 2;

// Clamp within room bounds
cam_x = clamp(cam_x, 0, room_width - cam_w);
cam_y = clamp(cam_y, 0, room_height - cam_h);

camera_set_view_pos(cam, cam_x, cam_y);
var cam = view_camera[0];
var cam_x = x - camera_get_view_width(cam) / 2;
var cam_y = y - camera_get_view_height(cam) / 2;

camera_set_view_pos(cam, cam_x, cam_y);
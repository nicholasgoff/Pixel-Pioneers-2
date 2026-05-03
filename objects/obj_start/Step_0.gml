var _cx = display_get_gui_width() / 2;
var _cy = display_get_gui_height() / 2;
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

if (mouse_check_button_pressed(mb_left)) {
    if (menu == "main") {
        if (point_in_rectangle(_mx, _my, _cx-200, _cy-100, _cx+200, _cy-40))
            room_goto(rm_tutorial); // your game room
        if (point_in_rectangle(_mx, _my, _cx-200, _cy-20, _cx+200, _cy+40))
            menu = "instructions";
        if (point_in_rectangle(_mx, _my, _cx-200, _cy+60, _cx+200, _cy+120))
            menu = "credits";
        if (point_in_rectangle(_mx, _my, _cx-200, _cy+140, _cx+200, _cy+200))
            game_end();
    }
    if (menu == "instructions") {
        if (point_in_rectangle(_mx, _my, _cx-200, _cy+440, _cx+200, _cy+500))
            menu = "main";
    }
    if (menu == "credits") {
        if (point_in_rectangle(_mx, _my, _cx-200, _cy+440, _cx+200, _cy+500))
            menu = "main";
    }
}
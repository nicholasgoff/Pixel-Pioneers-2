//obj_keycardDoor Draw event - placeholder
if (is_open) {
    //draw open door - tinted green
    draw_set_color(c_green);
    draw_rectangle(x, y, x + sprite_width, y + sprite_height, false);
    draw_set_color(c_white);
} else {
    //draw closed door - tinted red
    draw_set_color(c_red);
    draw_rectangle(x, y, x + sprite_width, y + sprite_height, false);
    draw_set_color(c_white);
}
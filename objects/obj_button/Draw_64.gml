if (showing_help) {
    var _cx = display_get_gui_width() / 2;
    var _cy = display_get_gui_height() / 2;
    var _pad = 12;
    
    draw_set_font(fnt_message);
    var _w = string_width(help_text) / 2;
    var _h = string_height(help_text);
    
    draw_set_alpha(0.8); draw_set_color(c_black);
    draw_roundrect(_cx - _w - _pad, _cy - _pad, _cx + _w + _pad, _cy + _h + _pad, false);
    draw_set_alpha(1); draw_set_color(c_white);
    draw_set_halign(fa_center); draw_set_valign(fa_top);
    draw_text(_cx, _cy, help_text);
    draw_set_halign(fa_left);
}
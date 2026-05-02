//HUD message - top center
if (global.hud_msg_timer > 0) {
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	draw_set_font(fnt_hud);
	draw_text(display_get_gui_width() / 2, 10, global.hud_message);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

//health bar
var bar_width = 200;
var bar_height = 20;
var health_pct = global.locus_hp / global.locus_hp_max;
draw_set_color(c_dkgray);
draw_rectangle(10, 10, 10 + bar_width, 10 + bar_height, false);
draw_set_color(c_lime);
draw_rectangle(10, 10, 10 + (bar_width * health_pct), 10 + bar_height, false);

//alert level - below health bar
var alert_col = c_white;
if (global.alert_level == 1) alert_col = c_yellow;
if (global.alert_level == 2) alert_col = c_red;
draw_set_color(alert_col);
draw_text(120, 98, "ALERT: " + string(global.alert_level));
draw_set_color(c_white);

//fade to black
if (global.fading) {
	draw_set_alpha(global.fade_alpha);
	draw_set_color(c_black);
	draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
	draw_set_alpha(1);
}
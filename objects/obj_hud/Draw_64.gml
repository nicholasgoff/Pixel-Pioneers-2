//minimap border
draw_set_colour(c_white); 
draw_set_alpha(0.8); 
draw_rectangle(1618, 18, 1902, 180, true); 

//Minimap label
draw_set_halign(fa_left); 
draw_set_font(fnt_hud); 
draw_text(1620, 4, "FACILITY MAP");
draw_set_alpha(1); 
draw_set_colour(c_white);
//particle system cleanup 
if (global.particle_system != -1) {
	part_type_destroy(global.particle_type);
	part_system_destroy(global.particle_system);
	global.particle_system = -1;
	global.particle_type = -1;
}
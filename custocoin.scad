// Set to your DXF file
profile_file = "kamila.dxf";
// Adjust scale and x/y offsets so profile is centered inside the coin
profile_scale = 0.07;
profile_offset_x = -16;
profile_offset_y = -9;
// profile_width + coin_width = total width of the coin
profile_width = 1;
coin_radius = 12;
coin_width = 1;
brim_radius = 1;
outer_grooves = true;
grooves_number = 20;
grooves_circular_pitch = 200;

use <gears.scad>;

module profile(file) {
	scale(profile_scale)
		linear_extrude(height=1/profile_scale + 1)
			import(file, center=true);
}

difference() {
	cylinder(h=profile_width, r=coin_radius);
	translate([profile_offset_x, profile_offset_y, 0])
		profile(profile_file);
}

translate([0, 0, -coin_width])
	cylinder(h=coin_width, r=coin_radius, $fn=100);

difference() {
	cylinder(h=coin_width, r=coin_radius, $fn=100);
	cylinder(h=coin_width, r=coin_radius-brim_radius, $fn=100);
}

if (outer_grooves) {
	translate([0, 0, -coin_width])
		difference() {
			linear_extrude(height=coin_width+profile_width)
				gear(number_of_teeth=grooves_number, circular_pitch=grooves_circular_pitch);
			cylinder(h=coin_width+profile_width, r=coin_radius, $fn=100);
		}
}
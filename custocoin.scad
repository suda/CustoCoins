// Set to your DXF file
profile_file = "kamila.dxf";
// Adjust scale and x/y offsets so profile is centered inside the coin
profile_scale = 0.07;
profile_offset_x = -16;
profile_offset_y = -9;
profile_width = 1;
coin_radius = 12;
coin_width = 1;
brim_radius = 1;

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
// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_basic_components.scad>
include <config.scad>
include <params_alu_profiles.scad>

//-----------------------------------------------------------------------
module alu_sigma_profile_30x30(length)
{//
	perete = wall_thick_2;
	adancime = 9;
	diametru_mare = 16.5;
    
	
    difference(){
        color(frame_color)
            translate ([-profile_30x30_size[0] / 2, -profile_30x30_size[1] / 2, 0]) cube([profile_30x30_size[0], profile_30x30_size[1], length]);
// center hole
		translate (sigma_profile_holes[0] - display_tolerance_z) cylinder (h = length + 2 * display_tolerance, r = 3.4, $fn = 30);

// groves
        for (i = [0 : 3])
            rotate([0, 0, 90 * i]){
                translate ([profile_30x30_size[0] / 2 - groove_height, -groove_diameter / 2, 0] - tolerance_z) cube([groove_height, groove_diameter, length] + 2 * display_tolerance_xz);
                translate ([profile_30x30_size[0] / 2 - groove_wall_thick - 3, -8.5, 0] - tolerance_z) cube([3, 17, length] + 2 * display_tolerance_z);

                hull(){
                    translate ([5, 0, 0]) rotate ([0, 90, 0]) cylinder (h = groove_height - groove_wall_thick - 3, r1 = groove_diameter / 2, r2 = 8.5);
                    translate ([5, 0, length]) rotate ([0, 90, 0]) cylinder (h = groove_height - groove_wall_thick - 3, r1 = groove_diameter / 2, r2 = 8.5);
                }        
            }        
            
        // small holes
        for (i = [1 : 4])
            translate (sigma_profile_holes[i] - display_tolerance_z) cylinder (h = length + 2 * display_tolerance, r = 2, $fn = 20);
	}
}
//-----------------------------------------------------------------------
alu_sigma_profile_30x30(length = 300);

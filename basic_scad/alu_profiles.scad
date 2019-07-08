// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_basic_components.scad>
include <material_colors.scad>
include <params_alu_profiles.scad>
include <tolerance.scad>

//-----------------------------------------------------------------------
module alu_sigma_profile_30x30(length)
{//
	perete = wall_thick_2;
	adancime = 9;
	diametru_mare = 16.5;
    
	
    color(frame_color)
    render()
    difference(){
        
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
module U(length, base, height, wall_thick)
{
    //render(){
        difference(){
            cube ([length, base, height]);
            translate ([-display_tolerance, wall_thick, wall_thick]) cube ([length + 2 * display_tolerance, base - 2 * wall_thick, height - wall_thick + display_tolerance]);
        }
    //}
}
//--------------------------------------------------------------
module L_profile(length, edge_1_width = 20, edge_2_width = 20, wall_thick = 3)
{
  difference(){
    color (aluminium_color) cube ([edge_2_width, length, edge_1_width]);
    translate ([wall_thick, 0, wall_thick] - display_tolerance_y) cube ([edge_2_width - wall_thick, length, edge_1_width - wall_thick] + display_tolerance_xyz + display_tolerance_y);
  }
}
//--------------------------------------------------------------

alu_sigma_profile_30x30(length = 300);

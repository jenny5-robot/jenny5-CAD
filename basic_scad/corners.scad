// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_corners.scad>
include <tolerance.scad>

//-------------------------------------------------------------------------
module corner_half_T(tube_radius)
{
    corner_width = f_corner_width(tube_radius);
    corner_height = f_corner_height(tube_radius);

    difference(){
        union(){
            color(plastic_color) cube([corner_length, corner_width, corner_height]);
            translate ([-corner_width / 2 + corner_length / 2, corner_width - (wall_thick_3 + 2 * m4_screw_radius), 0]) color(plastic_color)cube([corner_width, corner_length, corner_height]);
        }
        // tube horizontal
        translate ([0, corner_width / 2, corner_base_thick + tube_radius] - display_tolerance_x) rotate([0, 90, 0]) cylinder(h = corner_length + 2 * display_tolerance, r = tube_radius, $fn = 50);
    // tube vertical
        translate ([corner_length / 2, corner_width - (wall_thick_3 + 2 * m4_screw_radius) - tube_radius, corner_base_thick + tube_radius]) rotate([-90, 0, 0]) cylinder(h = corner_length + display_tolerance + tube_radius, r = tube_radius, $fn = 50);
    
        for (i = [0 : 5])
            translate(corner_holes[i] - display_tolerance_z) cylinder (h = corner_height + 2 * display_tolerance, r = m4_screw_radius, $fn = 15);
    }
}

//-------------------------------------------------------------------------
module tube_corner(tube_radius)
{
    corner_height = f_corner_height(tube_radius);
    corner_width = f_corner_width(tube_radius);
    
    translate ([-corner_length / 2, -corner_width / 2, - corner_sheet_size[2] - corner_base_thick - tube_radius]){
        corner_sheet(tube_radius);
        translate ([0, 0, corner_sheet_size[2]]) corner_half_T(tube_radius);
        translate ([0, 0, 2 * tube_radius + 2 * corner_base_thick + corner_sheet_size[2]]) mirror([0, 0, 1]) corner_half_T(tube_radius);  
        translate ([0, 0, 2 * tube_radius + 2 * corner_base_thick + corner_sheet_size[2]]) corner_sheet(tube_radius);
    }
}
//-------------------------------------------------------------------------

//tube_corner(12.5);
//corner_sheet(12.5);
corner_half_T(12.5);
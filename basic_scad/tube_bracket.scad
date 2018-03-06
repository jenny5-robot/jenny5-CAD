// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_tube_bracket.scad>

//-------------------------------------------------------------------------
module tube_bracket_half(bracket_length, tube_radius)
{
    bracket_width = f_bracket_width(tube_radius);
    bracket_height = f_bracket_height(tube_radius);
    
    holes = f_tube_bracket_holes(bracket_length, tube_radius);

    difference(){
        union(){
            color(plastic_color) cube([bracket_length, bracket_width, bracket_height]);
        }
        // tube horizontal
        translate ([0, bracket_width / 2, tube_bracket_base_thick + tube_radius] - display_tolerance_x) rotate([0, 90, 0]) cylinder(h = bracket_length + 2 * display_tolerance, r = tube_radius, $fn = 50);
    
        for (i = [0 : 3])
            translate(holes[i] - display_tolerance_z) cylinder (h = bracket_height + 2 * display_tolerance, r = m4_screw_radius, $fn = 15);
    }
}
//-------------------------------------------------------------------------
module tube_bracket_long(bracket_length, tube_radius)
{
    bracket_width = f_bracket_width(tube_radius);
    bracket_height = f_bracket_height(tube_radius);
    
    holes = f_tube_bracket_holes(bracket_length, tube_radius);

    difference(){
        union(){
            color(plastic_color) cube([bracket_length, bracket_width, bracket_height]);
        }
        hull(){
        // tube horizontal
            translate ([0, bracket_width / 2, tube_bracket_base_thick + tube_radius] - display_tolerance_x) rotate([0, 90, 0]) cylinder(h = bracket_length + 2 * display_tolerance, r = tube_radius, $fn = 50);
            translate ([0, bracket_width / 2, tube_bracket_base_thick + 2 * tube_radius] - display_tolerance_x) rotate([0, 90, 0]) cylinder(h = bracket_length + 2 * display_tolerance, r = tube_radius, $fn = 50);
        }
        for (i = [0 : 3])
            translate(holes[i] - display_tolerance_z) cylinder (h = bracket_height + 2 * display_tolerance, r = m4_screw_radius, $fn = 15);
    }
}
//-------------------------------------------------------------------------
module tube_bracket_long_one_hole(bracket_thick, tube_radius, half = false)
{
    bracket_width = f_bracket_width(tube_radius);
    bracket_height = 0;
    holes = f_tube_bracket_single_hole(bracket_thick, tube_radius);

    translate([-bracket_thick / 2, -bracket_width / 2, -tube_radius - tube_bracket_base_thick_strong])
    if (half){
        bracket_height = f_bracket_height_strong_half(tube_radius);
    difference(){
        union(){
            color(plastic_color) cube([bracket_thick, bracket_width, bracket_height]);
        }
        hull(){
        // tube horizontal
            translate ([0, bracket_width / 2, tube_bracket_base_thick_strong + tube_radius] - display_tolerance_x) rotate([0, 90, 0]) cylinder(h = bracket_thick + 2 * display_tolerance, r = tube_radius, $fn = 50);
            translate ([0, bracket_width / 2, tube_bracket_base_thick_strong + 2 * tube_radius] - display_tolerance_x) rotate([0, 90, 0]) cylinder(h = bracket_thick + 2 * display_tolerance, r = tube_radius, $fn = 50);
        }
        for (i = [0 : 1])
            translate(holes[i] - display_tolerance_z) cylinder (h = bracket_height + 2 * display_tolerance, r = m4_screw_radius, $fn = 15);
    }
    }
    else{
        bracket_height = f_bracket_height_strong(tube_radius);
    

    difference(){
        union(){
            color(plastic_color) cube([bracket_thick, bracket_width, bracket_height]);
        }
        hull(){
        // tube horizontal
            translate ([0, bracket_width / 2, tube_bracket_base_thick_strong + tube_radius] - display_tolerance_x) rotate([0, 90, 0]) cylinder(h = bracket_thick + 2 * display_tolerance, r = tube_radius, $fn = 50);
            translate ([0, bracket_width / 2, tube_bracket_base_thick_strong + 2 * tube_radius] - display_tolerance_x) rotate([0, 90, 0]) cylinder(h = bracket_thick + 2 * display_tolerance, r = tube_radius, $fn = 50);
        }
        for (i = [0 : 1])
            translate(holes[i] - display_tolerance_z) cylinder (h = bracket_height + 2 * display_tolerance, r = m4_screw_radius, $fn = 15);
    }
}
}
//-------------------------------------------------------------------------
module tube_bracket_long_strong(bracket_length, tube_radius)
{
    bracket_width = f_bracket_width(tube_radius);
    bracket_height = f_bracket_height_strong(tube_radius);
    
    holes = f_tube_bracket_holes(bracket_length, tube_radius);

    difference(){
        union(){
            color(plastic_color) cube([bracket_length, bracket_width, bracket_height]);
        }
        hull(){
        // tube horizontal
            translate ([0, bracket_width / 2, tube_bracket_base_thick_strong + tube_radius] - display_tolerance_x) rotate([0, 90, 0]) cylinder(h = bracket_length + 2 * display_tolerance, r = tube_radius, $fn = 50);
            translate ([0, bracket_width / 2, tube_bracket_base_thick_strong + 2 * tube_radius] - display_tolerance_x) rotate([0, 90, 0]) cylinder(h = bracket_length + 2 * display_tolerance, r = tube_radius, $fn = 50);
        }
        for (i = [0 : 3])
            translate(holes[i] - display_tolerance_z) cylinder (h = bracket_height + 2 * display_tolerance, r = m4_screw_radius, $fn = 15);
    }
}
//-------------------------------------------------------------------------
//tube_bracket_half(40, 12.5);
//tube_bracket_long(40, 12.5);

tube_bracket_long_one_hole(bracket_thick = 12, tube_radius = 12.5, half = false);
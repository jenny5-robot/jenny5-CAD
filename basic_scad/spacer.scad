// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_basic_components.scad>
include <config.scad>
include <tolerance.scad>

//---------------------------------------------------------------
module spacer_with_2_holes(length, width, height, distance_between_holes)
{
    difference(){
        cube([length, width, height]);
        translate ([0, (width - distance_between_holes) / 2, height / 2] - display_tolerance_x) rotate ([0, 90, 0]) cylinder (h = length + 2 * display_tolerance, r = 2, $fn = 30);
        translate ([0, width - (width - distance_between_holes) / 2, height / 2] - display_tolerance_x) rotate ([0, 90, 0]) cylinder (h = length + 2 * display_tolerance, r = 2, $fn = 30);
    }
}
//---------------------------------------------------------------
/*
module spacer_with_1_hole(length, width, height)
{
    difference(){
        color(plastic_color) cube([length, width, height]);
        translate ([0, width / 2, height / 2] - display_tolerance_x) rotate ([0, 90, 0]) cylinder (h = length + 2 * display_tolerance, r = 2, $fn = 30);
    }
}
*/
//---------------------------------------------------------------
module spacer_with_1_hole(spacer_size)
{
    difference(){
        color(plastic_color) cube(spacer_size);
        translate ([0, spacer_size[1] / 2, spacer_size[2] / 2] - display_tolerance_x) rotate ([0, 90, 0]) cylinder (h = spacer_size[0] + 2 * display_tolerance, r = 2, $fn = 30);
    }
}
//---------------------------------------------------------------
module spacer_with_1_hole_with_ears(length, width, height)
{
    difference(){
        cube([length, width, height]);
        translate ([0, width / 2, height / 2] - display_tolerance_x) rotate ([0, 90, 0]) cylinder (h = length + 2 * display_tolerance, r = 2, $fn = 30);
    }
}
//---------------------------------------------------------------
module spacer_with_2_holes_and_screw_holder(length, width, height, distance_between_holes)
{
    difference(){
        union(){
          cube([length, width, height]);
          translate ([0, 0, height / 2]) rotate([0, 90, 0]) cylinder (h = length, r = 5, $fn = 30);
        }
        translate ([(length - distance_between_holes) / 2, width / 2, 0] - display_tolerance_z) cylinder (h = height + 2 * display_tolerance, r = 2, $fn = 30);
        translate ([length - (length - distance_between_holes) / 2, width / 2, 0] - display_tolerance_z) cylinder (h = height + 2 * display_tolerance, r = 2, $fn = 30);
            translate ([0, 0, height / 2]) rotate([0, 90, 0]) cylinder (h = length, r = 1.5, $fn = 30);
    }
}
//---------------------------------------------------------------
module spacer_with_1_hole_empty(length, width, height, wall_thick)
{
    difference(){
        cube([length, width, height]);
        // scoate cutie
        translate ([wall_thick, wall_thick, wall_thick]) cube([length - 2 * wall_thick, width, height - 2 * wall_thick]);
        // gaura verticala
        translate ([length / 2, wall_thick + (width - wall_thick) / 2, 0] - display_tolerance_z) cylinder (h = height + 2 * display_tolerance, r = 2, $fn = 30);
        
        translate ([length / 2, 0, wall_thick]) cylinder (h = 15, r = 11, $fn = 30);
        translate ([length / 2, 0, height - wall_thick - 15]) cylinder (h = 15, r = 11, $fn = 30);
        
        // gaura orizontala
        translate ([0, wall_thick + (width - wall_thick) / 2, height / 2] - display_tolerance_x) rotate([0, 90, 0]) cylinder (h = length + 2 * display_tolerance, r = 1.5, $fn = 30);
    }
}
//---------------------------------------------------------------

//spacer_with_2_holes(17, 40, 11, 31);

//spacer_with_2_holes(35, 40, 11, 31);

//spacer_with_2_holes(86, 40, 11, 32);

//spacer_with_2_holes(38, 40, 11, 31);

//spacer_with_2_holes(34, 40, 11, 29);

//spacer_with_2_holes_and_screw_holder(37, 12, 73, 25);

//spacer_with_1_hole_empty(37, 13, 73, 3);
//spacer_with_1_hole_empty(37, 13, 90, 3);

spacer_with_1_hole(30, 37, 11);
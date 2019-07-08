// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_screws_nuts_washers.scad>
include <params_radial_bearings.scad>
include <params_belt_tensioner.scad>
include <material_colors.scad>
include <tolerance.scad>


//---------------------------------------------------------------------------
module belt_tensioner_spacer(distance_between_screws)
{
    length = distance_between_screws + 2 * m4_nut_radius + 2 * wall_thick_2;
    height = 5;
    difference(){
        translate ([- length / 2, -6, 0]) cube([length, 12, height]);
// first screw
        translate ([-distance_between_screws / 2, 0, 0] - display_tolerance_z) cylinder(h = height + 2 * display_tolerance, r = 2);
        translate ([-distance_between_screws / 2, 0, height - m4_nut_thick]) cylinder(h = height + 2 * display_tolerance, r = m4_nut_radius, $fn = 6);
// second screw hole
        translate ([distance_between_screws / 2, 0, 0] - display_tolerance_z) cylinder(h = height + 2 * display_tolerance, r = 2);
        translate ([distance_between_screws / 2, 0, height - m4_nut_thick]) cylinder(h = height + 2 * display_tolerance, r = m4_nut_radius, $fn = 6);
    }
}
//---------------------------------------------------------------------------

belt_tensioner_spacer(28);



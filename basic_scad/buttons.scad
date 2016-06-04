// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_buttons.scad>
include <params_stepper_motors.scad>
include <params_basic_components.scad>
include <params_screws_nuts_washers.scad>
use <basic_components.scad>

include <../basic_scad/config.scad>
//--------------------------------------------------------
module button()
{
	color("black") cylinder(h = button_length, r = button_screw_radius, $fn = 30);
    color("black")translate ([0, 0, button_length - 14]) cylinder(h = 2, r = button_large_radius, $fn = 50);
}
//--------------------------------------------------------
module button_support()
{
    thick = 3;
    width = 9;
    difference(){
        color (plastic_color) my_cube_rounded2([nema_17_width, 9, 3]);
        translate([nema_17_width / 2 - nema_17_dist_between_screw_holes / 2, width / 2, 0] - display_tolerance_z)
        cylinder (h = thick + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
        translate([nema_17_width / 2 + nema_17_dist_between_screw_holes / 2, width / 2, 0] - display_tolerance_z)
        cylinder (h = thick + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
        
    }
    color (plastic_color) 
    difference(){
        hull(){
            translate([nema_17_width / 2 - 9, width / 2, 10]) rotate ([0, 90, 0]) cylinder (h = 3, r = 7);
            translate([nema_17_width / 2 - 9, width / 2, 7]) rotate ([0, 90, 0]) cylinder (h = 3, r = 6);
        }
        translate([nema_17_width / 2 - 9, width / 2, 10] - display_tolerance_x) rotate([0, 90, 0]) cylinder (h = 3 + 2 * display_tolerance, r = button_screw_radius + 0.3, $fn = 30);
    }
}
//--------------------------------------------------------
module button_on_support()
{
    button_support();
    translate ([-6, 9 / 2, 10])  rotate ([0, 90, 0]) button();
}
//--------------------------------------------------------

//button();

button_support();

//button_on_support();
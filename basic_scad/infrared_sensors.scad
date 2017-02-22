// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_basic_components.scad>
include <params_infrared_sensors.scad>

//------------------------------------------------------
module GP2Y0D805Z0F()
{
    difference(){
        color("green") cube([GP2Y0D805Z0F_size[0], GP2Y0D805Z0F_size[1], 2]);
        // screw hole
        translate([GP2Y0D805Z0F_size[0] - GP2Y0D805Z0F_dist_to_hole, GP2Y0D805Z0F_size[1] / 2, 0] - display_tolerance_z) cylinder (h = 2 + 2 * display_tolerance, r = 1, $fn = 10);
    }
    translate([3, -GP2Y0D805_size[1] / 2 + GP2Y0D805Z0F_size[1] / 2, 2]) color("black") cube(GP2Y0D805_size);
}
//------------------------------------------------------
module GP2Y0A41SK0F()
{
    color ("black")
    translate (-[GP2Y0A41SK0F_size[0] / 2, GP2Y0A41SK0F_size[1] / 2, 0]) cube(GP2Y0A41SK0F_size);
    // ears
    difference(){
    color ("black")
        hull(){
            translate (-[GP2Y0A41SK0F_size[0] / 2, 0, 0] - [GP2Y0A41SK0F_ear_radius, 0, 0]) cylinder (h = 2, r = GP2Y0A41SK0F_ear_radius, $fn = 30);
            translate (-[GP2Y0A41SK0F_size[0] / 2, 0, 0]) cylinder (h = 2, r = GP2Y0A41SK0F_ear_radius);
        }
        translate (-[GP2Y0A41SK0F_size[0] / 2, 0, 0] - [GP2Y0A41SK0F_ear_radius, 0, 0] - display_tolerance_z) cylinder (h = 2 + 2 * display_tolerance, r = GP2Y0A41SK0F_ear_hole_radius, $fn = 30);
    }
    difference(){
    color ("black")
        hull(){
          translate ([GP2Y0A41SK0F_size[0] / 2, 0, 0] + [GP2Y0A41SK0F_ear_radius, 0, 0]) cylinder (h = 2, r = GP2Y0A41SK0F_ear_radius, $fn = 30);
          translate ([GP2Y0A41SK0F_size[0] / 2, 0, 0]) cylinder (h = 2, r = GP2Y0A41SK0F_ear_radius);
        }
          translate ([GP2Y0A41SK0F_size[0] / 2, 0, 0] + [GP2Y0A41SK0F_ear_radius, 0, 0] - display_tolerance_z) cylinder (h = 2 + 2 * display_tolerance, r = GP2Y0A41SK0F_ear_hole_radius, $fn = 30);        
    }
}
//------------------------------------------------------

GP2Y0A41SK0F ();

//GP2Y0D805Z0F();
// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <config.scad>
include <params_ultrasonic.scad>
include <params_screws_nuts_washers.scad>
use <basic_components.scad>
include <params_basic_components.scad>
include <params_webcam.scad>
use <webcam_support.scad>


//--------------------------------------------------------------
module hc_sr04_support_plate()
{
  difference(){
    color(plastic_color) 
    union(){
      my_cube_rounded2([hc_sr04_sizes[0] + 2, hc_sr04_sizes[1] + 2, 3]);
      for (i = [0:3])
        translate([1.5, 1.5, 0])
          translate (hc_sr04_hole_position[i]) 
            cylinder (h = 8, r = 2, $fn = 20);
    }
    for (i = [0:3])
      translate([1.5, 1.5, 0] - display_tolerance_z)
        translate (hc_sr04_hole_position[i]) 
          cylinder (h = 8 + 2 * display_tolerance, r = 1, $fn = 20);

// hole for arm    
    translate([0, 1, 0])
      translate ([3.5, hc_sr04_sizes[1] / 2, 0] - display_tolerance_z)
        cylinder (h = 3 + 2 * display_tolerance, r = 1.5, $fn = 20);
    
    translate([0, 1, 0])
      translate ([hc_sr04_sizes[0] + 2 - 3.5, hc_sr04_sizes[1] / 2, 0] - display_tolerance_z)
        cylinder (h = 3 + 2 * display_tolerance, r = 1.5, $fn = 20);
  }
}
//--------------------------------------------------------------
module hc_sr04_and_c920_support_plate()
{
    hc_sr04_support_plate();
    // c920 plate
    translate ([hc_sr04_sizes[0] / 2 - c920_depth / 2 - c920_dist_between_holder_holes / 2, -wall_thick_3, 0]) 
    c920_support();
    translate ([hc_sr04_sizes[0] / 2 - 10, 0, 0]) cube([20, 4, 6]);
}
//--------------------------------------------------------------
module hc_sr04_arm()
{
    thick_sheet = 1;
    difference(){
      color(plastic_color) 
        union(){
          cube(hc_sr04_arm_sizes);
          translate([-thick_sheet, 0, -thick_sheet]) cube([hc_sr04_arm_sizes[0] + thick_sheet, hc_sr04_arm_sizes[1], thick_sheet]);
        }
        // bone's hole
        translate ([hc_sr04_arm_sizes[0] - 11 - 6, (hc_sr04_arm_sizes[1] - 10.5) / 2, 0] - [0, 0, thick_sheet] - display_tolerance_z) cube([11, 10.5, hc_sr04_arm_sizes[2]] + [0, 0, thick_sheet] + 2 * display_tolerance_z);
        // other hole
        translate ([4, 5, 0] - [0, 0, thick_sheet] - display_tolerance_z) cube([20, hc_sr04_arm_sizes[1] - 10, hc_sr04_arm_sizes[1]] + [0, 0, thick_sheet] + 2 * display_tolerance_z);
        
        // m3 screw hole
        translate([0, hc_sr04_arm_sizes[1] / 2, hc_sr04_arm_sizes[2] / 2 - 1] - display_tolerance_x) rotate([0, 90, 0]) cylinder (h = 4 + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
        // m4 screw hole
        translate([34, hc_sr04_arm_sizes[1] / 2, hc_sr04_arm_sizes[2] / 2]) rotate([0, 90, 0]) cylinder (h = 10, r = m4_screw_radius, $fn = 20);
        // nut hole
        translate([hc_sr04_arm_sizes[0] - 6, hc_sr04_arm_sizes[1] / 2, hc_sr04_arm_sizes[2] / 2]) rotate([0, 90, 0]) cylinder (h = m4_nut_thick, r = m4_nut_radius, $fn = 6);
        
    }
}
//--------------------------------------------------------------
module hc_sr04_support()
{
    rotate ([0, 90, 0]) hc_sr04_arm();
    translate ([0, - hc_sr04_sizes[1] / 2 + hc_sr04_arm_sizes[1] / 2 - 1, 0]) hc_sr04_support_plate();
}
//--------------------------------------------------------------
module hc_sr04_and_c920_support()
{
    rotate ([0, 90, 0]) hc_sr04_arm();
    translate ([0, - hc_sr04_sizes[1] / 2 + hc_sr04_arm_sizes[1] / 2 - 1, 0]) hc_sr04_and_c920_support_plate();
}
//--------------------------------------------------------------

hc_sr04_and_c920_support();
//hc_sr04_support();
//hc_sr04_and_c920_support_plate();
//hc_sr04_arm();
//--------------------------------------------------------------
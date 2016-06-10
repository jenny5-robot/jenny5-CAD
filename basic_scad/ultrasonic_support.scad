// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_ultrasonic.scad>
include <params_screws_nuts_washers.scad>
use <basic_components.scad>
include <params_basic_components.scad>
include <params_webcam.scad>


//--------------------------------------------------------------
module hc_sr04_support_plate()
{
  difference(){
    
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
    translate ([hc_sr04_sizes[0] / 2 - c920_length / 2, -wall_thick_3, 0]) 
        difference(){
            translate ([c920_length / 2 - c920_dist_between_holder_holes / 2, wall_thick_3, c920_depth / 2])
            rotate([90, 0, 0]) 
                hull(){
                    cylinder(h = wall_thick_3, r = c920_depth / 2);
                    translate ([c920_dist_between_holder_holes, 0, 0]) cylinder(h = wall_thick_3, r = c920_depth / 2);
                }
        // remove some parts in order to avoid interference with US sensor
            translate ([c920_length / 2, 0, 65]) rotate([-90, 0, 0]) cylinder (h = wall_thick_3, r = 50);
// holder screws
            translate ([c920_length / 2 - c920_dist_between_holder_holes / 2, 0, c920_depth / 2] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h = wall_thick_3 + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);
            translate ([c920_length / 2 + c920_dist_between_holder_holes / 2, 0, c920_depth / 2] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h = wall_thick_3 + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);
    }
    translate ([hc_sr04_sizes[0] / 2 - 5, 0, 0]) cube([10, 5, 6]);
}
//--------------------------------------------------------------
module hc_sr04_arm()
{
    
    difference(){
      cube(hc_sr04_arm_sizes);
        // bone's hole
        translate ([hc_sr04_arm_sizes[0] - 11 - 6, (hc_sr04_arm_sizes[1] - 10.5) / 2, -1]) cube([11, 10.5, 9]);
        // other hole
        translate ([3, 3, -1]) cube([22, hc_sr04_arm_sizes[1] - 6, 9]);
        
        translate([0, hc_sr04_arm_sizes[1] / 2, hc_sr04_arm_sizes[2] / 2]) rotate([0, 90, 0]) cylinder (h = 3, r = m3_screw_radius, $fn = 20);
        // screw hole
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
//hc_sr04_and_c920_support();
//hc_sr04_support();
hc_sr04_and_c920_support_plate();
//hc_sr04_arm();
//--------------------------------------------------------------
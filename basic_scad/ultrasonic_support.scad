// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_ultrasonic.scad>
include <params_screws_nuts_washers.scad>
use <basic_components.scad>


//--------------------------------------------------------------
module hc_sr04_support_plate()
{
  difference(){
    
    union(){
      my_cube_rounded2([hc_sr04_sizes[0] + 2, hc_sr04_sizes[1] + 2, 3]);
      for (i = [0:3])
        translate([1.5, 1.5, 0])
          translate (hc_sr04_hole_position[i]) 
            cylinder (h = 7, r = 2, $fn = 20);
    }
    for (i = [0:3])
      translate([1.5, 1.5, 0])
        translate (hc_sr04_hole_position[i]) 
          cylinder (h = 7, r = 1, $fn = 20);
    
    translate([0, 1, 0])
      translate ([3.5, hc_sr04_sizes[1] / 2, 0])
        cylinder (h = 3, r = 1.5, $fn = 20);
  }
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
    hc_sr04_support_plate();
}
//--------------------------------------------------------------
hc_sr04_support();
//hc_sr04_arm();
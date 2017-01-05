// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <config.scad>
include <params_screws_nuts_washers.scad>
use <basic_components.scad>
include <params_basic_components.scad>
include <params_webcam.scad>

//--------------------------------------------------------------
module c920_support()
{
  color(plastic_color) 
  difference(){
    translate ([c920_depth / 2, wall_thick_3, c920_depth / 2])
      rotate([90, 0, 0]) 
        hull(){
          cylinder(h = wall_thick_3, r = c920_depth / 2);
          translate ([c920_dist_between_holder_holes, 0, 0]) cylinder(h = wall_thick_3, r = c920_depth / 2);
        }
        // remove some parts in order to avoid interference with US sensor
        translate ([c920_dist_between_holder_holes / 2 + c920_depth / 2, 0, 60] - display_tolerance_y) rotate([-90, 0, 0]) cylinder (h = wall_thick_3 + 2 * display_tolerance, r = c920_length / 2);
        // holder screws
        translate ([c920_length / 2 - c920_dist_between_holder_holes / 2, 0, c920_depth / 2] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h = wall_thick_3 + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);
        translate ([c920_length / 2 + c920_dist_between_holder_holes / 2, 0, c920_depth / 2] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h = wall_thick_3 + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);
  }
}
//--------------------------------------------------------------


c920_support();
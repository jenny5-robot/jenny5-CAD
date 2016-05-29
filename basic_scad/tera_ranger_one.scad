// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_tera_ranger_one.scad>
include <params_basic_components.scad>
include <params_screws_nuts_washers.scad>


//---------------------------------------------------------------------
module tera_ranger_one_support()
{
    difference(){
union(){
      cube(tera_ranger_one_sizes);
    // motor shaft holder
    
      translate ([tera_ranger_one_sizes[0] / 2 - 9, 0, 0]) cube([15, 15, 12]);

}
        // remove for button
        cube([16, 16, 4])
      translate ([5, 5, 0])
        for (i=[0:2])
          translate (tera_ranger_one_holes_position[i] - display_tolerance_z)
            cylinder (h = tera_ranger_one_sizes[2] + 2 * display_tolerance, r = 1.25, $fn = 20);
        
    
        for (i=[0:11]){
    translate ([5 * i + 5, tera_ranger_one_sizes[1] - 5, 0] - display_tolerance_z)
            cylinder (h = tera_ranger_one_sizes[2] + 2 * display_tolerance, r = 1.25, $fn = 20);
    translate ([5, 5 * i + 5, 0] - display_tolerance_z)
            cylinder (h = tera_ranger_one_sizes[2] + 2 * display_tolerance, r = 1.25, $fn = 20);
    translate ([tera_ranger_one_sizes[0] - 5, 5 * i + 5, 0] - display_tolerance_z)
            cylinder (h = tera_ranger_one_sizes[2] + 2 * display_tolerance, r = 1.25, $fn = 20);

    translate ([10, 5 * i + 5, 0] - display_tolerance_z)
            cylinder (h = tera_ranger_one_sizes[2] + 2 * display_tolerance, r = 1.25, $fn = 20);
    translate ([tera_ranger_one_sizes[0] - 10, 5 * i + 5, 0] - display_tolerance_z)
            cylinder (h = tera_ranger_one_sizes[2] + 2 * display_tolerance, r = 1.25, $fn = 20);
        }
      
    
        // motor shaft hole
      translate ([tera_ranger_one_sizes[0] / 2, 0, 5.5]) rotate ([-90, 0, 0]) cylinder (h = 15, r = 2.5, $fn = 20);
        // screw
      translate ([tera_ranger_one_sizes[0] / 2 - 9, 7.5, 5.5]) rotate ([0, 90, 0]) cylinder (h = 10, r = m4_screw_radius, $fn = 20);
// nuts
        hull(){
      translate ([tera_ranger_one_sizes[0] / 2 - 7, 7.5, 5.5]) rotate ([0, 90, 0]) cylinder (h = m4_nut_thick + 0.5, r = m4_nut_radius + 0.2, $fn = 6);
      translate ([tera_ranger_one_sizes[0] / 2 - 7, 7.5, 15]) rotate ([0, 90, 0]) cylinder (h = m4_nut_thick + 0.5, r = m4_nut_radius + 0.2, $fn = 6);
        }
    }
}
//---------------------------------------------------------------------

tera_ranger_one_support();

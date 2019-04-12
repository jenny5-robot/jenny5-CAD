// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_tera_ranger_one.scad>
include <params_basic_components.scad>
include <params_screws_nuts_washers.scad>

include <config.scad>
include <tolerance.scad>
//---------------------------------------------------------------------
module tera_ranger_one_support()
{
    base_cube_width = 12;
    
    difference(){
    union(){
      color (plastic_color) cube(tera_ranger_one_sizes);
            
    // motor shaft holder
    
      color (plastic_color) translate ([tera_ranger_one_sizes[0] / 2 - base_cube_width / 2, 0, 0]) cube([base_cube_width, 20, base_cube_width]);

}
        // remove for button
        translate (-display_tolerance_z) cube([tera_ranger_one_sizes[0] / 2 - base_cube_width / 2, 12, 4] + 2 * display_tolerance_z);
        translate ([tera_ranger_one_sizes[0] / 2 + base_cube_width / 2, 0, 0] -display_tolerance_z) 
cube([tera_ranger_one_sizes[0] / 2 - 5, 12, 4] + 2 * display_tolerance_z)

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
      translate ([tera_ranger_one_sizes[0] / 2, 0, base_cube_width / 2] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h = 21.1, r = 4, $fn = 20);
        // screw
      translate ([tera_ranger_one_sizes[0] / 2 - 9, 5, base_cube_width / 2]) rotate ([0, 90, 0]) cylinder (h = 10, r = m4_screw_radius, $fn = 20);
    }
}
//---------------------------------------------------------------------

tera_ranger_one_support();

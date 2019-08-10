// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// License: MIT
//--------------------------------------------------------------

use <../../basic_scad/basic_components.scad>
include <../../basic_scad/params_screws_nuts_washers.scad>
use <../../basic_scad/screws_nuts_washers.scad>
include <../../basic_scad/params_radial_bearings_u_housing.scad>

include <../../basic_scad/material_colors.scad>

include <leg_params.scad>

include <../../basic_scad/tolerance.scad>

use <leg_sheets.scad>
//---------------------------------------------------------
module leg_bone()
{
    //render(){
    
        difference(){
          //  translate ([-leg_bone_thick[0] / 2, -leg_bone_thick[1] / 2, 0])
            color(aluminium_color) rectangular_tube (leg_bone_thick[0], leg_bone_thick[1], 2, leg_bone_length);
            // shaft hole
            echo("middle hole", rbearing_6001_housing_holes_position[0] + [ rbearing_6001_housing_size_thicker[0] / 2, leg_bone_thick[0] / 2, 0], "radius = 12.5");
            translate ([0, leg_bone_thick[1] / 2, rbearing_6001_housing_size_thicker[0] / 2])
                rotate([90, 0, 0]) {
                    translate (rbearing_6001_housing_holes_position[0] - display_tolerance_z) cylinder (h = leg_bone_thick[1] + 2 * display_tolerance, r = 12.5, $fn = 70);
        // screws holes
                    echo("screw hole");
                    for (i = [1 : 4]){
                        translate (rbearing_6001_housing_holes_position[i] - display_tolerance_z) cylinder (h = leg_bone_thick[1] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
                    echo(rbearing_6001_housing_holes_position[i] + [ rbearing_6001_housing_size_thicker[0] / 2, leg_bone_thick[0] / 2, 0], "radius = 2");
                    }
                }
            // holes in the other side
            translate ([0, leg_bone_thick[1] / 2, leg_bone_length - rbearing_6001_housing_size_thicker[0] / 2])
                rotate([90, 0, 0]) {
                    translate (rbearing_6001_housing_holes_position[0] - display_tolerance_z) cylinder (h = leg_bone_thick[1] + 2 * display_tolerance, r = 12.5, $fn = 70);
        // screws holes
                    for (i = [1 : 4])
                        translate (rbearing_6001_housing_holes_position[i] - display_tolerance_z) cylinder (h = leg_bone_thick[1] + 2 * display_tolerance, r = 1.6, $fn = 20);
                }
                
        }
}
//----------------------------------------------------------------------
leg_bone();


// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <shaft_support_params.scad>
include <tolerance.scad>
include <material_colors.scad>

//--------------------------------------------------------------
module shaft_support_SHF20()
{
    color(aluminium_color)
    difference(){
        union(){
            cylinder(h = SHF20_shaft_suport_height, r = SHF20_shaft_suport_middle_external_radius);
            hull(){
            translate ([SHF20_shaft_suport_distance_between_holes / 2, 0, 0])     cylinder(h = SHF20_shaft_suport_small_height, r = SHF20_shaft_suport_lateral_internal_radius + 2.5);
            translate ([-SHF20_shaft_suport_distance_between_holes / 2, 0, 0])     cylinder(h = SHF20_shaft_suport_small_height, r = SHF20_shaft_suport_lateral_internal_radius + 2.5);
            }
        }
        // now holes
            translate (-display_tolerance_z) cylinder(h = SHF20_shaft_suport_height + 2 * display_tolerance, r = SHF20_shaft_suport_middle_internal_radius);
            translate ([SHF20_shaft_suport_distance_between_holes / 2, 0, 0]-display_tolerance_z)     cylinder(h = SHF20_shaft_suport_small_height + 2 * display_tolerance, r = SHF20_shaft_suport_lateral_internal_radius);
            translate ([-SHF20_shaft_suport_distance_between_holes / 2, 0, 0]-display_tolerance_z)     cylinder(h = SHF20_shaft_suport_small_height + 2 * display_tolerance, r = SHF20_shaft_suport_lateral_internal_radius);
        
    }
}

//--------------------------------------------------------------


shaft_support_SHF20();
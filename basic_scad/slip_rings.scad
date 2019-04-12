// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_slip_rings.scad>
include <params_basic_components.scad>
include <tolerance.scad>

//----------------------------------------------------------
module SRC022A_6()
{
    // stator
    color("black") cylinder(h = SRC022A_6_stator_length, r = SRC022A_6_stator_radius, $fn = 50);
    // flange
    
    color("black") 
    translate([0, 0, SRC022A_6_stator_length - SRC022A_6_flange_thickness]) 
    difference(){
        cylinder (h = SRC022A_6_flange_thickness, r = SRC022A_6_flange_radius, $fn = 100);
        for (i=[1:3])
            translate (SRC022A_6_flange_holes_position[i] - display_tolerance_z) cylinder (h = SRC022A_6_flange_thickness + 2 * display_tolerance, r = SRC022A_6_flange_holes_radius, $fn = 20); 
    }
    // rotor
    color("black") 
    translate([0, 0, SRC022A_6_stator_length]) cylinder (h = SRC022A_6_rotor_length, r = SRC022A_6_rotor_radius, $fn = 20);
}
//----------------------------------------------------------

SRC022A_6();
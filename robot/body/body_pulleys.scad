// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------


include <../../basic_scad/params_basic_components.scad>
use <../../basic_scad/basic_components.scad>

include <../../basic_scad/config.scad>

include <../../basic_scad/params_pulleys.scad>
use <../../basic_scad/pulleys.scad>
include <../../basic_scad/params_screws_nuts_washers.scad>

include <../../basic_scad/tolerance.scad>

include <body_params.scad>

//---------------------------------------------------------------------------
module body_arm_traction_pulley()
{    
    difference(){
        color(plastic_color){
            pulley(profile = "T5mm_pulley", num_teeth = 42, pulley_b_ht = 0, pulley_b_dia = 17, pulley_t_ht = printed_pulley_thick - 3);
            translate([0, 0, printed_pulley_thick]) cylinder (h = pulley_spacer_length, r = 19, $fn = 80);

        }
        
        // shaft hole 
        translate ([-body_arm_bone_size / 2 - 0.1, -body_arm_bone_size / 2 - 0.1, 0] -display_tolerance_z) 
        cube([body_arm_bone_size + 0.2, body_arm_bone_size + 0.2, printed_pulley_thick + pulley_spacer_length + 2 * display_tolerance]);

        dist_to_nut = 17;

        // 1st screw hole
        for (i = [-1 : 2 : 1]){
            dist_to_1st_screw = i * 9;
            
            for (angle = [0: 90: 270])
            rotate([0, 0, angle]){
                translate ([-37, dist_to_1st_screw, printed_pulley_thick / 2]) rotate ([0, 90, 0]) cylinder(h = 30, r = m4_screw_radius, $fn = 20);
            // nut hole
                hull(){
                    translate ([-dist_to_nut - m4_nut_thick, dist_to_1st_screw, printed_pulley_thick / 2]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
                    translate ([-dist_to_nut - m4_nut_thick, dist_to_1st_screw, printed_pulley_thick + 6]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
                }
            }
        }           
    }
}
//---------------------------------------------------------------------------

body_arm_traction_pulley();

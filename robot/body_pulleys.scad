// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------


include <../basic_scad/params_basic_components.scad>
use <../basic_scad/basic_components.scad>

include <../basic_scad/config.scad>

include <../basic_scad/params_pulleys.scad>
use <../basic_scad/pulleys.scad>
include <../basic_scad/params_screws_nuts_washers.scad>

include <../basic_scad/tolerance.scad>

include <body_params.scad>

//---------------------------------------------------------------------------
module body_arm_traction_pulley()
{
    spacer_length = 4;
    
    difference(){
        color(plastic_color){
            pulley(profile = "T5mm_pulley", num_teeth = 42, pulley_b_ht = 0, pulley_b_dia = 17, pulley_t_ht = body_shaft_pulley_height - 3);
            translate ([0, 0, body_shaft_pulley_height]) cylinder (h = spacer_length, r = body_shaft_radius + 3);
        }
        
              hull(){
            cylinder(h = 10, r = body_shaft_radius + 0.5, $fn = 6);
            translate ([0, 0, body_shaft_pulley_height + spacer_length + display_tolerance - 1]) cylinder(h = 1, r = body_shaft_radius, $fn = 50);
        }
      
     //   translate(- display_tolerance_z) cylinder(h = body_shaft_pulley_height + spacer_length + 2 * display_tolerance, r = body_shaft_radius, $fn = 30);

        // 1st screw hole
        dist_to_1st_screw = 17;
        
        dist_to_nut = 14;
        translate ([-23, dist_to_1st_screw, body_shaft_pulley_height / 2]) rotate ([0, 90, 0]) cylinder(h = 45, r = m4_screw_radius, $fn = 20);
        // 1 st screw head hole
        translate ([20, dist_to_1st_screw, body_shaft_pulley_height / 2]) rotate ([0, 90, 0]) cylinder(h = 30, r = 3.5, $fn = 20);
        // nut hole
        hull(){
            translate ([-dist_to_nut - m4_nut_thick, dist_to_1st_screw, body_shaft_pulley_height / 2]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
            translate ([-dist_to_nut - m4_nut_thick, dist_to_1st_screw, body_shaft_pulley_height]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
        }
      
        // cut window
        cube([1.5, 40, 20]);        
    }
}
//---------------------------------------------------------------------------
module half_1_body_arm_traction_pulley()
{
    difference(){
        body_arm_traction_pulley();
        translate ([-0.25, -40, 0] - display_tolerance_z) cube([40, 80, 19] + 2 * display_tolerance_z);
    }
}
//---------------------------------------------------------------------------
module half_2_body_arm_traction_pulley()
{
    difference(){
        body_arm_traction_pulley();
        translate ([-40, -40, 0] - display_tolerance_z) cube([40.25, 80, 19] + 2 * display_tolerance_z);
    }
}
//---------------------------------------------------------------------------

body_arm_traction_pulley();

//half_1_body_arm_traction_pulley();
//half_2_body_arm_traction_pulley();
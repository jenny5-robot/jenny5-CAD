// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_table_robot.scad>
include <../basic_scad/params_stepper_motors.scad>
include <../basic_scad/params_screws_nuts_washers.scad>

module tabla_motor_cot(motor_tolerance)
{
    difference(){
        cube(tabla_motor_cot_sizes);
        // gauri nema 17
        translate ([nema_17_width / 2 + bone_thick, nema_17_width / 2, 0] - display_tolerance_z){
            // gaura motor
            translate (gauri_nema_17[0] + [0, -nema_17_width / 2 + tabla_motor_cot_sizes[1] / 2, 0]) cylinder (h = tabla_motor_cot_sizes[2] + 2 * display_tolerance, r = nema_17_motor_hole_radius_camiel, $fn = 30); 
            // gauri suruburi
            for (i=[1:4])
              translate (gauri_nema_17[i] + [0, -nema_17_width / 2 + tabla_motor_cot_sizes[1] / 2, 0]) cylinder (h = tabla_motor_cot_sizes[2] + 2 * display_tolerance, r = m3_screw_radius, $fn = 30);  
        }
        // gauri prindere os
        translate ([nema_17_width / 2 + bone_thick, nema_17_width / 2, 0] - display_tolerance_z){
        }
        // gauri prindere os
        hull(){
            translate ([bone_thick / 2, tabla_motor_cot_sizes[1] / 2 - 15 - motor_tolerance / 2, 0] - display_tolerance_z) cylinder (h = tabla_motor_cot_sizes[2] + 2 * display_tolerance, r = m3_screw_radius, $fn = 30);
            translate ([bone_thick / 2, tabla_motor_cot_sizes[1] / 2 - 15 + motor_tolerance / 2, 0] - display_tolerance_z) cylinder (h = tabla_motor_cot_sizes[2] + 2 * display_tolerance, r = m3_screw_radius, $fn = 30);
        }
        hull(){
            translate ([bone_thick / 2, tabla_motor_cot_sizes[1] / 2 + 15 - motor_tolerance / 2, 0] - display_tolerance_z) cylinder (h = tabla_motor_cot_sizes[2] + 2 * display_tolerance, r = m3_screw_radius, $fn = 30);
            translate ([bone_thick / 2, tabla_motor_cot_sizes[1] / 2 + 15 + motor_tolerance / 2, 0] - display_tolerance_z) cylinder (h = tabla_motor_cot_sizes[2] + 2 * display_tolerance, r = m3_screw_radius, $fn = 30);
        }
    }
}


tabla_motor_cot(10);
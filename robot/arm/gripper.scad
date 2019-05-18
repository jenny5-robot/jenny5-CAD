// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//---------------------------------------------------------------

include <../../basic_scad/tolerance.scad>
use <../../basic_scad/basic_components.scad>
include <gripper_params.scad>
include <../../basic_scad/params_screws_nuts_washers.scad>
use <../../basic_scad/screws_nuts_washers.scad>
include <../../basic_scad/params_basic_components.scad>
include <../../basic_scad/params_radial_bearings.scad>
include <../../basic_scad/params_webcam.scad>
include <../../basic_scad/config.scad>
use <../../basic_scad/buttons.scad>
include <../../basic_scad/servos_params.scad>
use <../../basic_scad/servos.scad>
use <../../basic_scad/involute_gears.scad>

use <arm_pulleys.scad>
include <arm_params.scad>

//-----------------------------------------------------------------------------------
module fixed_finger()
{
    difference(){
        hull(){
            cylinder(h = fixed_finger_size[2], r = fixed_finger_size[1] / 2);
            translate ([fixed_finger_size[0], 0, 0]) cylinder(h = fixed_finger_size[2], r = fixed_finger_size[1] / 2);
        }
        // screw hole
        translate ([fixed_finger_size[0], 0, 0]) cylinder(h = fixed_finger_size[2], r = m3_screw_radius);
        translate ([fixed_finger_size[0], 0, fixed_finger_size[2] - 4]) cylinder(h = fixed_finger_size[2], r = m3_nut_radius, $fn = 6);
        
        // pulley fixed finger screw holes
        translate ([-2, 0, 0] - display_tolerance_z) cylinder(h = fixed_finger_size[2] + 2 * display_tolerance, r = m3_screw_radius, $fn = 14);
        //translate ([0, 0, fixed_finger_size[2] - 4]) cylinder(h = fixed_finger_size[2], r = m3_nut_radius, $fn = 6);
        translate ([elbow_pulley_holes_dist_x + elbow_pulley_holes_dist_x - 2, 0, 0] - display_tolerance_z) cylinder(h = fixed_finger_size[2] + 2 * display_tolerance, r = m3_screw_radius, $fn = 14);
        //translate ([elbow_pulley_holes_dist_x + elbow_pulley_holes_dist_x, 0, fixed_finger_size[2] - 4]) cylinder(h = fixed_finger_size[2], r = m3_nut_radius, $fn = 6);
        
    }
}
//-----------------------------------------------------------------------------------
module mobile_finger_gear()
{
    difference(){
            gear (number_of_teeth = 18,
					circular_pitch = 250,
					bore_diameter = 6,
					hub_diameter = 10,
					rim_width = 0,
					hub_thickness = gripper_mobile_finger_gear_height,
					rim_thickness = gripper_mobile_finger_gear_height,
					gear_thickness = gripper_mobile_finger_gear_height,
					pressure_angle = 31
            );
        translate(-display_tolerance_z) 
            hull(){
                cylinder(h = 2 + display_tolerance, r = mobile_finger_size[1] / 2);
                translate ([mobile_finger_size[0], 0, 0]) cylinder(h = 2 + display_tolerance, r = mobile_finger_size[1] / 2);
            }
    }
}
//-----------------------------------------------------------------------------------
module mobile_finger()
{
    difference(){
        union(){
            hull(){
                cylinder(h = mobile_finger_size[2], r = mobile_finger_size[1] / 2);
                translate ([mobile_finger_size[0], 0, 0]) cylinder(h = mobile_finger_size[2], r = mobile_finger_size[1] / 2);
            }
            
            translate([20, -55, 0]) {
                difference(){
                    arc_thick_rounded(radius_exterior = 60, radius_interior = 50, thick = mobile_finger_size[2], angle = 90);
                    translate ([55, 6, 0]) cylinder(h = mobile_finger_size[2], r = m3_screw_radius);
                    translate ([55, 6, fixed_finger_size[2] - 4]) rotate([0, 0, 30]) cylinder(h = mobile_finger_size[2], r = m3_nut_radius, $fn = 6);
                }
            }
        }
        // screw hole
        translate (-display_tolerance_z) cylinder(h = mobile_finger_size[2] + 2 * display_tolerance, r = m6_screw_radius);  
    }
}
//-----------------------------------------------------------------------------------
module gripper_motor_gear()
{
    difference(){
        gear (number_of_teeth = 19,
					circular_pitch = 250,
					bore_diameter = 6,
					hub_diameter = 21,
					rim_width = 1,
					hub_thickness = gripper_gear_height,
					rim_thickness = gripper_gear_height,
					gear_thickness = gripper_gear_height,
					pressure_angle = 31
        );
        translate (-display_tolerance_z) cylinder(h = 4 + display_tolerance, r = 21/2, $fn = 50);
        // screw holes
        for (i = [0 : 90 : 270])
            translate([7.5 * sin(i), 7.5 * cos(i), 0])
                cylinder(h = gripper_gear_height, r = 1);
    }
}
//-----------------------------------------------------------------------------------
module wrist_pulley_with_gripper()
{
    wrist_pulley();
    // motor
    rotate ([0, 0, gripper_servo_rotation]) translate ([0, arm_shaft_size / 2 + 1501MG_size[1] / 2, -1501MG_screw_support_height + printed_pulley_thick] - display_tolerance_z)
    rotate([0, 0, 180]) {
        // servo
        power_hd_1501MG();
        // gear
        translate (1501MG_shaft_position + [0, 0, 1501MG_shaft_length - 2] + [-1501MG_size[0] / 2, -1501MG_size[1] / 2, -2]) 
        gripper_motor_gear();
    }
    translate([fixed_finger_offset[0], fixed_finger_offset[1], printed_pulley_thick + 2])
                translate([0, 0, mobile_finger_size[2] - 2])
                mobile_finger_gear();

    // fixed finger
    translate([elbow_pulley_holes_dist_x + arm_shaft_size / 2 + 2, 0, printed_pulley_thick - 2]) fixed_finger();
    translate([elbow_pulley_holes_dist_x + arm_shaft_size / 2 + 2, 0, 0]) mirror([0, 0, 1]) fixed_finger();
    // mobile finger
    translate([fixed_finger_offset[0], fixed_finger_offset[1], printed_pulley_thick + 2]) rotate([0, 0, gripper_mobile_finger_position]) mobile_finger();
    translate([fixed_finger_offset[0], fixed_finger_offset[1], -mobile_finger_size[2] - 2]) rotate([0, 0, gripper_mobile_finger_position]) mobile_finger();    
}
//-----------------------------------------------------------------------------------
wrist_pulley_with_gripper();

//wrist_pulley();

//mirror([0, 0, 1]) gripper_motor_gear();

//mobile_finger();

//mirror([0, 0, 1]) mobile_finger_gear();

//fixed_finger();
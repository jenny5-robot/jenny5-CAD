// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// License: MIT  
//--------------------------------------------------------------

include <../../basic_scad/params_screws_nuts_washers.scad>
include <base_platform_params.scad>

include <../../basic_scad/material_colors.scad>

use <../../basic_scad/screws_nuts_washers.scad>

use <../../basic_scad/dc_motors.scad>

include <../../basic_scad/params_dc_motors.scad>

use <../../basic_scad/involute_gears.scad>

include <../../basic_scad/tolerance.scad>

include <../../basic_scad/params_radial_bearings.scad>

//--------------------------------------------------------------------
module platform_wheel_gear()
{    
    difference(){
        rotate ([0, 0, 12]) 
        color(plastic_color)
        gear (number_of_teeth = 28,
					circular_pitch = 500,
					bore_diameter = 0,
					hub_diameter = 0,
					rim_width = 4,
					hub_thickness = 4,
					rim_thickness = wheel_gear_thick,
					gear_thickness = wheel_gear_thick,
					pressure_angle = 31);
        // // middle hole
        translate (-display_tolerance_z) cylinder(h = wheel_gear_thick + 2 * display_tolerance, r = rb_6907_external_radius - 2, $fn = 40);
        // bearing hole
        translate ([0, 0, wheel_gear_thick - rb_6907_thick]) cylinder(h = wheel_gear_thick + display_tolerance, r = rb_6907_external_radius, $fn = 40);
        // screw holes
        for (i = [0 : 7])
            rotate([0, 0, 68])
                translate([(rb_6907_external_radius + 3) * sin(i * 45), (rb_6907_external_radius + 3) * cos(i * 45), 0] - display_tolerance_z) cylinder(h = wheel_gear_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
        // nut holes
        for (i = [0 : 3])
            rotate([0, 0, 68])
                translate([(rb_6907_external_radius + 3) * sin(i * 90), (rb_6907_external_radius + 3) * cos(i * 90), 0] - display_tolerance_z) cylinder(h = 5 + 2 * display_tolerance, r = m4_nut_radius, $fn = 30);
    }
}
//----------------------------------------------------------
module motor_gear()
{
    extra_length =  10;
    
    difference(){
        rotate ([0, 0, 7.5])
        color(plastic_color)
            gear (number_of_teeth = 25,
					circular_pitch = 500,
					bore_diameter = 10,
					hub_diameter = 30,
					rim_width = 4,
					hub_thickness = motor_gear_height + extra_length,
					rim_thickness = motor_gear_height,
					gear_thickness = motor_gear_height,
					pressure_angle = 31);
        // motor shaft hole
        //translate (-display_tolerance_z) cylinder (h = motor_gear_height + extra_length + 2 * display_tolerance, r = 5, $fn = 30);
        
        // 1st screw hole
        translate ([0, 0, motor_gear_height / 2]) rotate ([0, 90, 0]) cylinder(h = 50, r = m4_screw_radius, $fn = 20);
        // 1st nut hole
        hull(){
            translate ([7, 0, motor_gear_height / 2]) rotate ([0, 90, 0]) cylinder(h = 2 * m4_nut_thick, r = m4_nut_radius, $fn = 6);
            translate ([7, 0, 0]) rotate ([0, 90, 0]) cylinder(h = 2 * m4_nut_thick, r = m4_nut_radius, $fn = 6);
        }
        // 2nd screw hole
        translate ([0, 0, motor_gear_height + extra_length / 2]) rotate ([0, 90, 0]) cylinder(h = 50, r = m4_screw_radius, $fn = 20);
        // 2nd nut hole
        hull(){
            translate ([7, 0, motor_gear_height + extra_length / 2]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick, r = m4_nut_radius, $fn = 6);
            translate ([7, 0, motor_gear_height + extra_length]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick, r = m4_nut_radius, $fn = 6);
        }
    }
}
//--------------------------------------------------------------------

platform_wheel_gear();
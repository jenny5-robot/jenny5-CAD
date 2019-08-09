// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// License: MIT
//--------------------------------------------------------------

//include <../../basic_scad/params_radial_bearings.scad>
use <../../basic_scad/radial_bearings.scad>
use <../../basic_scad/radial_bearing_housing.scad>
use <../../basic_scad/screws_nuts_washers.scad>

use <../../basic_scad/stepper_motors.scad>
include <../../basic_scad/params_stepper_motors.scad>

use <../../basic_scad/motor_pulley.scad>

use <body_sheets.scad>
include <body_params.scad>
//--------------------------------------------------------------
module body_sheet_with_bearing()
{
    // sheet
    body_sheet_for_bearing_support_top();
    // bearing
    translate([body_sheet_size[0] / 2, body_sheet_size[1] / 2, body_sheet_size[2]])
    6907rs();
    // bearing housing
    translate([body_sheet_size[0] / 2, body_sheet_size[1] / 2, 0]) translate ([0, 0, rbearing_6907_housing_size[2] + body_sheet_size[2]]) mirror([0, 0, 1]) rbearing_6907_housing();
    
    // screws
    for (i = [1 : 4])
            translate([body_sheet_size[0] / 2, body_sheet_size[1] / 2, 0]) translate(rbearing_6907_housing_holes_position[i]) {
                // screw
                M4x18_sunken();
                //washer
                translate([0, 0, body_sheet_size[2] + rbearing_6907_housing_size[2]]) M4x12_washer();
                // autolock nut
                translate([0, 0, body_sheet_size[2] + rbearing_6907_housing_size[2] + washer_4_thick]) M4_autolock_nut();
            }
}
//---------------------------------------------------------------------------
module body_sheet_with_bearing_and_belt_tensioner()
{
    // sheet
    body_sheet_for_bearing_support_bottom();
    // bearing
    translate([body_sheet_size[0] / 2, body_sheet_size[1] / 2, body_sheet_size_bottom[2]])
    6907rs();
    // bearing housing
    translate([body_sheet_size[0] / 2, body_sheet_size[1] / 2, 0]) translate ([0, 0, rbearing_6907_housing_size[2] + body_sheet_size[2]]) mirror([0, 0, 1]) rbearing_6907_housing();
    
    // screws
    for (i = [1 : 4])
            translate([body_sheet_size[0] / 2, body_sheet_size[1] / 2, 0]) translate(rbearing_6907_housing_holes_position[i]) {
                // screw
                M4x18_sunken();
                //washer
                translate([0, 0, body_sheet_size[2] + rbearing_6907_housing_size[2]]) M4x12_washer();
                // autolock nut
                translate([0, 0, body_sheet_size[2] + rbearing_6907_housing_size[2] + washer_4_thick]) M4_autolock_nut();
            }
// belt tensioner            
  translate ([body_sheet_size_bottom[0] - 4, body_motor_sheet_size[1] / 2 - 15, -rb_624_thick -wall_thick_2]) 624rs();
  translate ([body_sheet_size_bottom[0] - 4, body_motor_sheet_size[1] / 2 + 15, - rb_624_thick- wall_thick_2]) 624rs();
  translate ([body_sheet_size_bottom[0] - 4, body_motor_sheet_size[1] / 2 - 15, - 2 *rb_624_thick - wall_thick_2]) 624rs();
  translate ([body_sheet_size_bottom[0] - 4, body_motor_sheet_size[1] / 2 + 15, - 2 * rb_624_thick - wall_thick_2]) 624rs();
  translate ([body_sheet_size_bottom[0] - 4, body_motor_sheet_size[1] / 2 - 15, - 3 * rb_624_thick - wall_thick_2]) 624rs();
  translate ([body_sheet_size_bottom[0] - 4, body_motor_sheet_size[1] / 2 + 15, - 3 * rb_624_thick - wall_thick_2]) 624rs();
    
  translate ([body_sheet_size_bottom[0] - 4, body_motor_sheet_size[1] / 2 - 15, body_motor_sheet_size[2]]) mirror ([0, 0, 1]) M4x25_hexa();
  translate ([body_sheet_size_bottom[0] - 4, body_motor_sheet_size[1] / 2 + 15, body_motor_sheet_size[2]]) mirror ([0, 0, 1]) M4x25_hexa();
            
}
//---------------------------------------------------------------------------
module body_sheet_with_motor()
{
    body_sheet_for_motor_support();
    
    translate ([body_motor_sheet_size[0] / 2, body_motor_sheet_size[1] / 2, -nema_17_with_19_1_gearbox_height]) rotate ([0, 0, 45]) nema_17_with_19_1_gearbox();
    
    translate ([body_motor_sheet_size[0] / 2, body_motor_sheet_size[1] / 2, body_motor_sheet_size[2] + 5]) motor_pulley_8mm_shaft();
}
//---------------------------------------------------------------------------

body_sheet_with_bearing_and_belt_tensioner();
body_sheet_with_motor();
body_sheet_with_bearing();
// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../../basic_scad/params_sheets.scad>
include <../../basic_scad/params_basic_components.scad>
use <../../basic_scad/basic_components.scad>

include <../../basic_scad/config.scad>

include <body_params.scad>
include <../../basic_scad/params_screws_nuts_washers.scad>
use <../../basic_scad/screws_nuts_washers.scad>

include <../../basic_scad/params_radial_bearings.scad>
use <../../basic_scad/radial_bearings.scad>

use <../../basic_scad/stepper_motors.scad>
include <../../basic_scad/params_stepper_motors.scad>

use <../../basic_scad/radial_bearing_housing.scad>

use <../../basic_scad/belt.scad>
use <../../basic_scad/belt_tensioner.scad>
include <../../basic_scad/params_belt_tensioner.scad>

use <../../basic_scad/thrust_bearing_housing.scad>
include <../../basic_scad/params_thrust_bearing_housing.scad>

include <../../basic_scad/params_thrust_bearings.scad>

use <../../basic_scad/thrust_bearings.scad>

use <../../basic_scad/linear_motors.scad>
include <../../basic_scad/tolerance.scad>

use <../../basic_scad/corners.scad>

use <../../basic_scad/tube_bracket.scad>
include <../../basic_scad/params_tube_bracket.scad>

include <../../basic_scad/params_corners.scad>

use <body_sheets.scad>
use <../../basic_scad/motor_pulley.scad>
use <body_pulleys.scad>

include <../../basic_scad/as5147_params.scad>
use <../../basic_scad/as5147.scad>

use <../arm/arm.scad>
include <../arm/arm_params.scad>

use <body_sensor_support.scad>


//---------------------------------------------------------------------------
module body_arm_bone(bone_length)
{
    echo("body arm bone length = ", bone_length);
    
    cylinder_empty(bone_length, body_shaft_radius, body_shaft_radius - 2);
}
//---------------------------------------------------------------------------

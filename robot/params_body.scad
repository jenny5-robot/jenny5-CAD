// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_basic_components.scad>
include <../basic_scad/params_radial_bearings.scad>
include <../basic_scad/params_radial_bearings_housing.scad>
include <../basic_scad/params_sheets.scad>

body_rotation_linear_motor_position = 0;

dist_edge_to_body_shaft = rbearing_6001_housing_size[0] / 2;

body_height = 440;
body_width = 450;

clavicule_size = [50, 30, body_width];

body_arm_shaft_length = body_height - clavicule_size[1] + 11 + 4;

dist_between_motor_and_axis = 89;
vertebral_column_size = [30, 30, body_height - 2 * 3];
   
motor_housing_tolerance = 10;
motor_housing_tolerance_large = 20;

body_rotation_sheet_size = [60, 200, 10];

dist_to_belt_tensioner = 62;

body_holes_position = [-25, 25];

body_shaft_radius = 6;
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

dist_edge_to_shaft = 14;

chest_height = 380;
chest_length = 450;

body_arm_length = chest_height - 2 * washer_8_thick -  2 * rb_608_thick - 3;

dist_between_motor_and_axis = 89;//radius_roata_reductor + radius_roata_motor_reductor + 10;
vertebral_column_size = [30, 30, chest_height];
   
motor_housing_tolerance = 10;
motor_housing_tolerance_large = 20;

body_rotation_sheet_size = [60, 200, 10];

dist_to_belt_tensioner = 62;

body_holes_position = [-25, 25];
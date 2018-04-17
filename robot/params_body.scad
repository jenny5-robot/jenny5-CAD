// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_basic_components.scad>
include <../basic_scad/params_radial_bearings.scad>
include <../basic_scad/params_radial_bearings_housing.scad>
include <../basic_scad/params_tube_bracket.scad>

angle_body_arm = 90;// 180 (closed - front)...-90 (open-back); // default = -90

body_rotation_linear_motor_position = 0;

bracket_thick = 10;

dist_edge_to_body_shaft = rbearing_6905_housing_size[0] / 2 + bracket_thick;

body_height = 340;
body_width = 450;

clavicule_size = [60, 30, body_width];

dist_to_body_motor = 150;
   
motor_housing_tolerance = 10;
motor_housing_tolerance_large = 20;

body_rotation_sheet_size = [60, 200, 10];

body_shaft_radius = 12.5;

distance_between_body_modules = rbearing_6905_housing_size[0] + 2 * body_shaft_radius + wall_thick_2;

body_sheet_size = [rbearing_6905_housing_size[0] + 2 * bracket_thick + 2 * wall_thick_1, distance_between_body_modules + 2 * body_shaft_radius + 2 * braket_lateral_wall_thick, 3];

body_sheet_size_bottom = body_sheet_size + [10, 0, 0];

body_motor_sheet_size = [40, distance_between_body_modules + 2 * body_shaft_radius + 2 * braket_lateral_wall_thick, 3];

body_intermodule_sheet_size = [40, distance_between_body_modules + 2 * body_shaft_radius + 2 * braket_lateral_wall_thick, 3];


body_arm_shaft_length = body_height + 2 * tube_bracket_base_thick_strong + 2 * body_sheet_size[2] + 4 * body_shaft_radius + rbearing_6905_housing_size[2];

body_shaft_pulley_height = 11;

body_arm_offset = 32;

body_arm_bracket_thick = 12;

offset_body_motor_sheet = 130;

body_intermodule_offset = 90;
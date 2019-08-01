// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../../basic_scad/params_radial_bearings_housing.scad>
include <../../basic_scad/params_sheets.scad>
//--------------------------------------------------------------

leg_angle = 20;

leg_top_base_length = 240;

leg_base_height = 40;

leg_bone_length = 450;
leg_bone_thick = [40, 20];

leg_distance_to_wrist_in_bone = rbearing_6001_housing_size_thicker[0] / 2;//rb_6001_external_radius + 4;

leg_shaft_radius = 6;
leg_motor_shaft_radius = 4;

leg_shaft_distance_to_edge = 12;
leg_distance_to_wrist_in_base = leg_base_height - leg_shaft_distance_to_edge;

crotch_width_front = 80;
crotch_width_back = crotch_width_front + 2 * leg_bone_thick[1] + 2 * (2 + 3) + 2 * alu_sheet_10_thick;

base_spacer_length = crotch_width_front + 2 * leg_bone_thick[1] + 2 * 5.5;

leg_distance_to_first_bone = 60;
leg_distance_to_second_bone = 150;
leg_distance_to_push_motor_hole_in_base = 163;

leg_distance_to_first_spacer = 15;
leg_distance_to_second_spacer = leg_top_base_length - 15;

knee_side_simple_sizes = [leg_distance_to_second_bone - leg_distance_to_first_bone + 2 * leg_shaft_distance_to_edge, alu_sheet_10_thick, 40];

lateral_top_base_size = [leg_top_base_length, alu_sheet_10_thick, 40];

leg_distance_to_pusher = 110;

leg_pusher_tube_length = crotch_width_front + 2 * leg_bone_thick[1];

leg_pusher_bearing_sheet_size = [60, 60, 3];

leg_distance_to_motor_shaft_in_base = 13;
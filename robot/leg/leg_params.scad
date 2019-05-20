// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../../basic_scad/params_basic_components.scad>
include <../../basic_scad/params_radial_bearings_housing.scad>
include <../../basic_scad/params_sheets.scad>
include <../../basic_scad/params_alu_profiles.scad>

leg_angle = 70;

leg_top_base_length = 250;

leg_base_height = 40;

leg_bone_length = 350;
leg_bone_thick = [40, 20];


dist_to_wrist_in_bone = rbearing_6001_housing_size_thicker[0] / 2;//rb_6001_external_radius + 4;

leg_shaft_radius = 6;
leg_motor_shaft_radius = 4;

leg_shaft_distance_to_edge = 12;
dist_to_wrist_in_base = leg_base_height - leg_shaft_distance_to_edge;

max_torque_leg_angle = 70;

distance_to_push_position = 100;//leg_bone_distance_between_bearing_centers;

crotch_width_front = 80;
crotch_width_back = crotch_width_front + 2 * leg_bone_thick[1] + 2 * (2 + 3);

base_spacer_length = crotch_width_back + 2 * leg_bone_thick[1] + 2 * 2;

echo(base_spacer_length=base_spacer_length);

dist_to_first_bone = 60;
dist_to_second_bone = 140;
dist_to_push_motor_hole_in_base = 200;
dist_to_push_motor_hole_in_base_vertical = 11;
dist_to_first_spacer = 15;
dist_to_second_spacer = leg_top_base_length - 15;

knee_side_simple_sizes = [dist_to_second_bone - dist_to_first_bone + 20, alu_sheet_10_thick, 80];

lateral_top_base_size = [leg_top_base_length, alu_sheet_10_thick, 40];

leg_angle_offset = 0;

leg_spacer = 0;

leg_distance_to_pusher = 120;

leg_pusher_tube_length = crotch_width_front - 5;

leg_pusher_bearing_sheet_size = [60, 60, 3];
// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_radial_bearings.scad>
include <../basic_scad/params_basic_components.scad>
include <../basic_scad/params_radial_bearings_housing.scad>
include <../basic_scad/params_sheets.scad>
include <../basic_scad/params_alu_profiles.scad>

leg_motor_position = -80; // 0 ... 50

leg_motor_max_stroke = 150;

leg_base_length = 150;
leg_base_height = 40;

leg_bone_length = 350;
leg_bone_distance_between_bearing_centers = leg_bone_length + 2 * rb_6000_external_radius;
leg_bone_thick = [40, 20];


dist_to_wrist_in_bone = rb_6001_external_radius + 4;
dist_to_wrist_in_base = leg_base_height - 8;

shaft_radius = 4;

max_torque_leg_angle = 70;

distance_to_push_position = 100;//leg_bone_distance_between_bearing_centers;

crotch_width_front = 65;
crotch_width_back = 115;

dist_to_first_bone = 0;
dist_to_second_bone = 80;
dist_to_push_motor_hole_in_base = 200;
dist_to_push_motor_hole_in_base_vertical = 11;

knee_side_simple_sizes = [110, alu_sheet_10_thick, 70];

lateral_base_size = [leg_base_length, alu_sheet_10_thick, 40];

dist_to_foot_spacer_hole = 30;

leg_angle_offset = 0; //13;

leg_spacer = 0;
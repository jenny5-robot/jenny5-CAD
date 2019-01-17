// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_radial_bearings_housing.scad>
include <../basic_scad/params_radial_bearings_u_housing.scad>
include <../basic_scad/params_sheets.scad>
include <../basic_scad/params_stepper_motors.scad>

angle_shoulder = -0; // -180 (up)... 0(down) // default = 0
angle_upper_arm = 90; // -90 ... 90 // default = -90
angle_elbow = -90; // -270 (closed), -180 (front) -90 (full extend) // default = 0
angle_fore_arm = -100; // default = 90

upper_arm_bone_length = 350;
fore_arm_length = 300;

arm_shaft_size = 25;
arm_shaft_radius = 17.5;

shoulder_plate_size = [75, nema_17_with_27_1_gearbox_height, alu_sheet_5_thick];

extra_height_arm_bearing = 14;

rbearing_6907_vertical_housing_size_bounded_half_small_bottom = f_rbearing_6907_vertical_housing_size_bounded_half_small(extra_height_arm_bearing);
rbearing_6907_vertical_housing_size_bounded_half_small_top = f_rbearing_6907_vertical_housing_size_bounded_half_small(0);

plate_body_size = ([80, nema_17_with_50_1_gearbox_height, alu_sheet_5_thick]);
  
distance_to_fore_arm_gear = 16;
      
elbow_gear_wall = 1.5;
elbow_gear_thick = bearing_6_height + 2 * elbow_gear_wall;
   
upper_arm_motor_housing_shift = -10;

upper_arm_shaft_support_length = 200;

upper_arm_gear_thick = 14;

shoulder_bracket_length = 24;

first_bearing_shoulder_offset = 0;

distance_upper_arm_motor_shaft = 21 + 15 + 4;



sheet_upper_arm_motor_base_size = [40,  21 + distance_upper_arm_motor_shaft + rbearing_608_housing_size[0] / 2, 3];

sheet_upper_arm_motor_top_size = [40,  21 + distance_upper_arm_motor_shaft + rbearing_608_housing_size[0] / 2, 3];

elbow_sheet_size = [47, 73, 3];
elbow_sheet_grip_length = 60;

arm_bracket_thick = 10;

offset_shoulder_plate_bracket = 12;

belt_hole_fore_arm_pulley_length = 40;
belt_hole_fore_arm_pulley_width = 14;

fore_arm_z_offset = 15;
fore_arm_x_offset = 41; // distance from elbow gear center to forearm support 

distance_between_elbow_gear_grip_sheets = 17;

fore_arm_pulley_thick = 14;
elbow_pulley_thick = 14;

fore_arm_motor_offset = 15;

body_motor_housing_interior_width = 41;

belt_tensioner_distance_between_holes = (body_motor_housing_interior_width + 4) / 2;


elbow_connector_belt_tensioner_offset = 8;

gripper_motor_sheet_size = [50, 50, 3];

upper_arm_bone_top_shift = 11;

upper_arm_bone_cleft_thick = 14; // where the elbow pulley will enter
upper_arm_bone_cleft_length = 90; // where the elbow pulley will enter

shoulder_left_right_motor_offset = 4;
shoulder_left_right_belt_tensioner_offset = 20;

body_stepper_motor_housing_belt_tensioner_offset = 20;


elbow_rotation_motor_offset = 13;

fore_arm_bone_top_shift = 11;

fore_arm_offset = 48;

elbow_pulley_num_teeth = 50;

elbow_pulley_radius = 39;

wrist_pulley_num_teeth = 40;

wrist_pulley_radius = 31;

fore_arm_bearing_support_size = [95, rb_6907_external_radius + 3, 14];

      elbow_pulley_holes_dist_y = nema_17_L33_with_27_1_gearbox_height / 2 - fore_arm_bearing_support_size[2] / 2;
      elbow_pulley_holes_dist_x = 6;

arm_up_down_motor_sheet_size = [60, 115, 3];
distance_arm_up_down_motor_to_shaft = arm_up_down_motor_sheet_size[1] - nema_17_motor_gearbox_radius - 1;

fore_arm_rotation_motor_support_sheet_size = [60, 109, 3];

distance_fore_arm_rotation_motor_to_shaft = fore_arm_rotation_motor_support_sheet_size[1] -nema_17_motor_gearbox_radius -1;

fore_arm_rotation_motor_support_sheet_distance_between_belt_tensioners = 22;

arm_up_down_motor_top_sheet_distance_between_belt_tensioners = 18;

upper_arm_rotation_motor_support_sheet_size = [60, 109, 3];

distance_upper_arm_rotation_motor_to_shaft = upper_arm_rotation_motor_support_sheet_size[1] -nema_17_motor_gearbox_radius -1;



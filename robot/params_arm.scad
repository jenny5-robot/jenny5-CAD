// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_radial_bearings_housing.scad>
include <../basic_scad/params_sheets.scad>
include <../basic_scad/params_stepper_motors.scad>

angle_shoulder = -0; // -180 (up)... 0(down) // default = 0
angle_upper_arm = -135; // -180 ... 0 // default = -90
angle_elbow = -90; // -180 (back), 0 (front) // default = 0
angle_fore_arm = 45; // default = 90

upper_arm_bone_length = 350;
fore_arm_length = 300;

shoulder_shaft_radius = 12.5;

shoulder_plate_size = [rbearing_6906_enclosed_housing_size[0], 95, alu_sheet_5_thick];

extra_height_arm_bearing = 14;

rbearing_6905_vertical_housing_size_bounded_half_small_bottom = f_rbearing_6905_vertical_housing_size_bounded_half_small(extra_height_arm_bearing);
rbearing_6905_vertical_housing_size_bounded_half_small_top = f_rbearing_6905_vertical_housing_size_bounded_half_small(0);

plate_body_size = ([70, nema_17_with_50_1_gearbox_height + 5, alu_sheet_5_thick]);
  
distance_to_fore_arm_gear = 16;
      
elbow_gear_wall = 1.5;
elbow_gear_thick = bearing_6_height + 2 * elbow_gear_wall;
   
upper_arm_motor_housing_shift = -10;

upper_arm_shaft_support_length = 200;

upper_arm_shaft_radius = 15;
forearm_shaft_radius = 12.5;

upper_arm_gear_thick = 11;

shoulder_bracket_length = 10;

first_bearing_shoulder_offset = 0;

distance_upper_arm_motor_shaft = 21 + 19;

sheet_upper_arm_motor_base_size = [42,  21 + distance_upper_arm_motor_shaft + rbearing_608_housing_size[0] / 2, 3];

sheet_upper_arm_motor_top_size = [42,  21 + distance_upper_arm_motor_shaft + rbearing_608_housing_size[0] / 2, 3];

elbow_sheet_size = [47, 70, 3];
elbow_sheet_grip_length = 40;

elbow_gear_grip_sheet_size = [15, 70, 3];
elbow_gear_grip_sheet_holes = [4, 15, 62];
elbow_gear_grip_sheet_holes_radius = [2, 2, 3];

arm_bracket_thick = 10;

offset_shoulder_plate_bracket = 7;

belt_hole_forearm_pulley = 50;

fore_arm_z_offset = 13;
fore_arm_x_offset = 42; // distance from elbow gear center to forearm support 

distance_between_elbow_gear_grip_sheets = 17;

forearm_pulley_thick = 11;

belt_tensioner_distance_between_holes = 22;
// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_basic_components.scad>
include <../basic_scad/params_radial_bearings.scad>
include <../basic_scad/params_radial_bearings_housing.scad>
include <../basic_scad/params_sheets.scad>


angle_body_arm = -220;// -270...-90; // default = 90
angle_shoulder = -90; // -180... 0 // default = 0
angle_upper_arm = -90; // - 90 ... 90 // default = -90
angle_elbow = -90; // -180, 0 // default = 0
angle_fore_arm = 90; // default = 90


bone_thick = 12;

upper_arm_bone_length = 345;
fore_arm_length = 330;

shoulder_plate_size = [60, 110, alu_sheet_3_thick];

plate_body_size = ([60, 60, 3]);
  
distance_to_fore_arm_gear = 12;
      
elbow_gear_wall = 1.5;
elbow_gear_thick = bearing_6_height + 2 * elbow_gear_wall;
   
upper_arm_motor_housing_shift = 20;

upper_arm_shaft_support_length = 180;

shoulder_shaft_radius = 6;
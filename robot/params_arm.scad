// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_basic_components.scad>
include <../basic_scad/params_radial_bearings.scad>
include <../basic_scad/params_radial_bearings_housing.scad>
include <../basic_scad/params_sheets.scad>


angle_body_arm = 90;// -90...90
angle_shoulder = -0; // -180... 0
angle_upper_arm = 90; // - 180 ... 0
angle_elbow = -180; // -90, 0
angle_fore_arm = 90;


bone_thick = 10;

upper_arm_length = 270;
fore_arm_length = 300;

shoulder_plate_size = [50, 130, alu_sheet_3_thick];

plate_body_size = ([60, 60, 3]);
  
distance_to_fore_arm_gear = 12;
      
elbow_gear_wall = 1.5;
elbow_gear_thick = bearing_6_height + 2 * elbow_gear_wall;
   
upper_arm_motor_housing_shift = 16;
   
body_holes_position = [-15.5, 15.5];
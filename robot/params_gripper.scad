// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_screws_nuts_washers.scad>
include <../basic_scad/params_basic_components.scad>

spacer_between_fingers = 2;


finger_thick = 6;
finger_first_segment_length = 44;
finger_second_second_length = 75;
finger_width = 10;


U_finger_thick = 3;
U_pusher_base_size = [4 * spacer_between_fingers + 3 * finger_thick + 2 * U_finger_thick, 20, m6_nut_thick + 2 * wall_thick_2];
U_pusher_height = 40;

gripper_motor_support_size = [37, 38, 8];//U_pusher_base_size[0] + 2 * spacer_between_fingers, 38, 8];

echo(gripper_motor_support_size);

gripper_lateral_sheet_size = [90, gripper_motor_support_size[1], 4];

finger_angle = 49;
finger_with_button_angle = finger_angle - 15;
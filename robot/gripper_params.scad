// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

gripper_mobile_finger_position = 29; // 10...42

fixed_finger_size = [95, 10, 10];
mobile_finger_size = [25, 10, 14];

gripper_servo_rotation = 30;
mobile_finger_angular_position = 43;
mobile_finger_position_radius = 30;

fixed_finger_offset = [mobile_finger_position_radius * cos(mobile_finger_angular_position), mobile_finger_position_radius * sin(mobile_finger_angular_position), 0];

//fixed_finger_offset = [25, 17, 0];

gripper_gear_height = 6;
gripper_mobile_finger_gear_height = 9;
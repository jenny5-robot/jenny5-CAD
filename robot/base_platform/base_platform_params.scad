// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// License: MIT 
//--------------------------------------------------------------

include <tracks_params.scad>
//--------------------------------------------------------------

platform_shaft_edge_size = 25;

base_platform_size = [380, 310, 16];

platform_shaft_length = base_platform_size[1] + 2 * track_width + 2 * 25;

first_wheel_offset = 25;
second_wheel_offset = 185;
third_wheel_offset = 345;   

lidar_position = 80;

leg_postion_on_platform = 90;

num_tracks_per_circle = 14; // 16
tracks_wheel_radius = 53.34; // 58.8

motor_gear_height = 11;
wheel_gear_thick = 17;

platform_motor_bearing_offset_y = 50;
platform_motor_bearing_offset_x = 2;

base_motor_support_sheet_size = [45, 34 + 20 + 23, 3];

wheel_radius = 54.66 * 0.955;
wheel_tooth_height = 10;
wheel_steps = 20;
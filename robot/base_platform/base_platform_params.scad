// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <tracks_params.scad>

small_tracks_angle = 30;

platform_shaft_edge_size = 25;

base_platform_size = [380, 310, 16];

first_tracks_offset = 25;
distance_between_wheels = 320;   

lidar_position = 80;

leg_postion_on_platform = 70;

num_tracks_per_circle = 14; // 16
tracks_wheel_radius = 53.34; // 58.8

motor_gear_height = 11;
wheel_gear_thick = 17;

platform_motor_bearing_offset_y = 50;
platform_motor_bearing_offset_x = 2;

tracks_offset = 35;

dist_to_tracks_tensioner_support = 150;
dist_to_tracks_support1 = 130;
dist_to_tracks_support2 = 185;

tracks_support_size = [10, base_platform_size[1] + 2 * track_width + 2 * tracks_offset, 10];

base_motor_support_sheet_size = [45, 34 + 20 + 23, 3];

wheel_radius = 54.66 * 0.955;
wheel_tooth_height = 10;
wheel_steps = 20;

small_tracks_sheet_size = [200, 60, 3];
small_tracks_wheel_radius = 64;
small_tracks_wheel_radius_thickness = 20;
small_tracks_wheel_distance_to_wheel = 180;
small_tracks_wheel_distance_to_shaft = 40;


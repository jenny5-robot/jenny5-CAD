// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_tracks.scad>

base_platform_size = [600, 300, 18];

first_tracks_offset = 30;
distance_between_wheels = 230;
    
wheels_bearing_housing_1_offset_y = 22;// must be larger than the reinforcement profile
   
wheels_bearing_housing_2_offset_y = 85;

lidar_position = 80;

leg_postion_on_platform = lidar_position + 30; // nema_17_width / 2 + 10

num_tracks_per_circle = 14; // 16
tracks_wheel_radius = 50.8; // 58.8

motor_gear_height = 11;
wheel_gear_height = 17;
wheel_gear_nut_depth = wheel_gear_height - 2;

base_motor_offset = 56;

tracks_offset = 15;

dist_to_tracks_tensioner_support = 150;
dist_to_tracks_support1 = 130;
dist_to_tracks_support2 = 185;

tracks_tensioner_support_size = [20, base_platform_size[1] + 2 * track_size[0] + 2 * tracks_offset - 2 * 10, 10];

tracks_support_size = [10, base_platform_size[1] + 2 * track_size[0] + 2 * tracks_offset, 10];

tracks_tensioner_size = [tracks_tensioner_support_size[0], 12, 60];
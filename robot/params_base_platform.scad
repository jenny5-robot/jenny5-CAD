// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

base_platform_size = [600, 300, 18];

first_tracks_offset = 30;
distance_between_wheels = 230;
    
wheels_bearing_housing_1_offset_y = 22;// must be larger than the reinforcement profile
   
wheels_bearing_housing_2_offset_y = 85;

tracks_tensioner_size = [60, 20, base_platform_size[2]];

lidar_position = 90;

leg_postion_on_platform = lidar_position + 30; // nema_17_width / 2 + 10

num_tracks_per_circle = 14; // 16
tracks_wheel_radius = 50.8; // 58.8

motor_gear_height = 10;
wheel_gear_height = 15;
wheel_gear_nut_depth = 10;

base_motor_offset = 56;

tracks_offset = 0;
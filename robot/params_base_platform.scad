// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------



include <../basic_scad/params_dc_motor_housing.scad>

front_tracks_angle = 0; // 0 = horizontal, 90 = up, -90 = down
back_tracks_angle = 180;

base_platform_size = [500, 300, 18];

first_tracks_offset = 35;

distance_between_tracks = base_platform_size[0] - 2 * first_tracks_offset;
    
wheels_bearing_housing_1_offset_y = 0;// must be larger than the reinforcement profile
   
wheels_bearing_housing_2_offset_y = 85;

lidar_position = 80;

leg_postion_on_platform = 100; // nema_17_width / 2 + 10



motor_gear_height = 11;



//base_motor_offset = 56;

tracks_offset_y = 30;
tracks_offset_z = 10;

motor_offset_x = motor_gr_ep_45_housing_size[1] + 70;
motor_offset_y = 65;






worm_gear_motor_with_pinion_offset = 20;
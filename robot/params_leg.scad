// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_radial_bearings.scad>
include <../basic_scad/params_basic_components.scad>
include <../basic_scad/params_radial_bearings_housing.scad>


angle_knee = 20;



rectangular_tube_30x30x3_size = [30, 30];
rectangular_tube_30x30x3_wall_thick = 3;

base_length = 260;

leg_bone_length = 400;
dist_to_incheietura = rb_608_external_radius + 3;
dist_to_incheietura_talpa = 32;
dist_to_incheietura_talpa_motor = dist_to_incheietura_talpa;
dist_to_incheietura_talpa_os = 32;//80;

shaft_radius = 4;

grosime_placa_alu = 10;

max_torque_leg_angle = 60;

distance_to_push_nut = 200; 

crotch_width = 46 + 2 * rectangular_tube_30x30x3_size[1] + 2 * 5 + 2 * rb_608_thick;

dist_to_first_spacer = 70;
dist_to_second_spacer = 165;

dist_to_first_bone = 22;
dist_to_second_bone = 110;
dist_to_push_motor_hole = 250;

knee_side_simple_sizes = [dist_to_second_bone + dist_to_first_bone, grosime_placa_alu, 60];

lateral_base_size = [base_length, grosime_placa_alu, 40];

foot_spacer_holes = 
[[dist_to_first_spacer, -50, 0],
[dist_to_first_spacer, 50, 0],
[dist_to_second_spacer, -50, 0],
[dist_to_second_spacer, 50, 0]
];
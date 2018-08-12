// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

nema_17_width = 42.3;
nema_17_motor_height_sparkfun = 36;
nema_17_motor_hole_radius_sparkfun  = 14;
nema_17_motor_hole_radius_camiel  = 12;
nema_17_dist_between_screw_holes = 31;
nema_17_height = 47;
nema_17_shaft_length = 24;

nema_14_width = 39.3;
nema_14_motor_hole_radius  = 11;
nema_14_dist_between_screw_holes = 31;
//nema_14_height = 47;
nema_14_shaft_length = 20;

nema_11_width = 28;
nema_11_motor_hole_radius = 11;
nema_11_dist_between_screw_holes = 23;
nema_11_height = 32;
nema_11_shaft_length = 18;
nema_11_shaft_radius = 3;

nema_11_27_1_gearbox_length = 34;
nema_11_13_1_gearbox_length = 25;
nema_11_gearbox_base_height = 4;
nema_11_motor_gearbox_radius = 14;
nema_11_motor_gearbox_hole_radius = 9;
nema_11_gearbox_dist_between_screw_holes = 22 / sqrt(2);
nema_11_gearbox_shaft_length = 18;

nema_11_with_27_1_gearbox_height = nema_11_height + nema_11_gearbox_base_height + nema_11_27_1_gearbox_length;
nema_11_with_13_1_gearbox_height = nema_11_height + nema_11_gearbox_base_height + nema_11_13_1_gearbox_length;

nema_17_motor_gearbox_radius = 18;
nema_17_gearbox_dist_between_screw_holes = 20;
nema_17_5_1_gearbox_height = 23;
nema_17_13_1_gearbox_height = 30;
nema_17_19_1_gearbox_height = 30;
nema_17_50_1_gearbox_height = 38;

nema_17_gearbox_base_height = 5;
nema_17_gearbox_shaft_length = 18;
nema_17_gearbox_shaft_radius = 4;
nema_17_gearbox_motor_hole_radius = 11;

nema_17_with_5_1_gearbox_height = nema_17_height + nema_17_gearbox_base_height + nema_17_5_1_gearbox_height;
nema_17_with_13_1_gearbox_height = nema_17_height + nema_17_gearbox_base_height + nema_17_13_1_gearbox_height;
nema_17_with_19_1_gearbox_height = nema_17_height + nema_17_gearbox_base_height + nema_17_19_1_gearbox_height;
nema_17_with_50_1_gearbox_height = nema_17_height + nema_17_gearbox_base_height + nema_17_50_1_gearbox_height;
//echo(nema_17_with_50_1_gearbox_height=nema_17_with_50_1_gearbox_height);

nema_17_42BYGHW804_width = 42.3;
nema_17_42BYGHW804_height = 47;
nema_17_42BYGHW804_top_radius = 11;
nema_17_42BYGHW804_top_cylinder_height = 2;
nema_17_42BYGHW804_dist_between_screw_holes = 31;
nema_17_42BYGHW804_shaft_length = 22;
nema_17_42BYGHW804_shaft_radius = 2.5;

nema_23_57BYGH603_width = 56.4;
nema_23_57BYGH603_height = 78;
nema_23_57BYGH603_hole_radius  = 19.1;
nema_23_57BYGH603_dist_between_screw_holes = 47.14;
nema_23_57BYGH603_shaft_length = 21;

nema_14_39BYGL215A_width = 39;
nema_14_39BYGL215A_height = 34;
nema_14_39BYGL215A_top_radius = 11;
nema_14_39BYGL215A_dist_between_screw_holes = 31;
nema_14_39BYGL215A_shaft_length = 50;
nema_14_39BYGL215A_shaft_radius = 2.5;
nema_14_39BYGL215A_top_cylinder_height = 2;

nema_14_33_width = 35;
nema_14_33_height = 34;
nema_14_33_top_radius = 11;
nema_14_33_dist_between_screw_holes = 31;
nema_14_33_shaft_length = 50;
nema_14_33_shaft_radius = 2.5;
nema_14_33_top_cylinder_height = 2;

nema_14_gearbox_base_height = 5;
nema_14_gearbox_dist_between_screw_holes = 10;
nema_14_motor_gearbox_radius = 13;
nema_14_gearbox_shaft_length = 16;
nema_14_gearbox_shaft_radius = 3;
nema_14_gearbox_motor_hole_radius = 11;
nema_14_27_1_gearbox_height = 30.8;

nema_14_33_with_27_1_gearbox_height = nema_14_33_height + nema_14_gearbox_base_height + nema_14_27_1_gearbox_height;


nema_11_sizes = [nema_11_width, nema_11_width, nema_11_height];

nema_17_holes = [
[0, 0, 0], 
[-nema_17_dist_between_screw_holes / 2, -nema_17_dist_between_screw_holes / 2, 0], 
[-nema_17_dist_between_screw_holes / 2, nema_17_dist_between_screw_holes / 2, 0], 
[nema_17_dist_between_screw_holes / 2, -nema_17_dist_between_screw_holes / 2, 0], 
[nema_17_dist_between_screw_holes / 2, nema_17_dist_between_screw_holes / 2, 0]
];

nema_14_39BYGL215A_screw_hole_position = [
[0, 0, 0], 
[-nema_14_39BYGL215A_dist_between_screw_holes / 2, -nema_14_39BYGL215A_dist_between_screw_holes / 2, 0], 
[-nema_14_39BYGL215A_dist_between_screw_holes / 2, nema_14_39BYGL215A_dist_between_screw_holes / 2, 0], 
[nema_14_39BYGL215A_dist_between_screw_holes / 2, -nema_14_39BYGL215A_dist_between_screw_holes / 2, 0], 
[nema_14_39BYGL215A_dist_between_screw_holes / 2, nema_14_39BYGL215A_dist_between_screw_holes / 2, 0]
];


nema_11_holes = [
[0, 0, 0], 
[-nema_11_dist_between_screw_holes / 2, -nema_11_dist_between_screw_holes / 2, 0], 
[-nema_11_dist_between_screw_holes / 2, nema_11_dist_between_screw_holes / 2, 0], 
[nema_11_dist_between_screw_holes / 2, -nema_11_dist_between_screw_holes / 2, 0], 
[nema_11_dist_between_screw_holes / 2, nema_11_dist_between_screw_holes / 2, 0]
];

gearbox_nema_11_holes_position = [
[0, 0, 0], 
[-nema_11_gearbox_dist_between_screw_holes / 2, -nema_11_gearbox_dist_between_screw_holes / 2, 0], 
[-nema_11_gearbox_dist_between_screw_holes / 2, nema_11_gearbox_dist_between_screw_holes / 2, 0], 
[nema_11_gearbox_dist_between_screw_holes / 2, -nema_11_gearbox_dist_between_screw_holes / 2, 0], 
[nema_11_gearbox_dist_between_screw_holes / 2, nema_11_gearbox_dist_between_screw_holes / 2, 0]
];

gearbox_nema_17_holes_position = [
[0, 0, 0], 
[-nema_17_gearbox_dist_between_screw_holes / 2, -nema_17_gearbox_dist_between_screw_holes / 2, 0], 
[-nema_17_gearbox_dist_between_screw_holes / 2, nema_17_gearbox_dist_between_screw_holes / 2, 0], 
[nema_17_gearbox_dist_between_screw_holes / 2, -nema_17_gearbox_dist_between_screw_holes / 2, 0], 
[nema_17_gearbox_dist_between_screw_holes / 2, nema_17_gearbox_dist_between_screw_holes / 2, 0]
];

gearbox_nema_14_holes_position = [
[0, 0, 0], 
[-nema_14_gearbox_dist_between_screw_holes / 2, -nema_14_gearbox_dist_between_screw_holes / 2, 0], 
[-nema_14_gearbox_dist_between_screw_holes / 2, nema_14_gearbox_dist_between_screw_holes / 2, 0], 
[nema_14_gearbox_dist_between_screw_holes / 2, -nema_14_gearbox_dist_between_screw_holes / 2, 0], 
[nema_14_gearbox_dist_between_screw_holes / 2, nema_14_gearbox_dist_between_screw_holes / 2, 0]
];

gearbox_nema_17_holes_radius = [nema_17_gearbox_motor_hole_radius, 1.5, 1.5, 1.5, 1.5];
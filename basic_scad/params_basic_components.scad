// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

spring_length = 20;

smooth_rod_8_radius = 4;
smooth_rod_10_radius = 5;
smooth_rod_12_radius = 6;

tolerance = 0.1;
display_tolerance = 1;

overlap_tolerance = 0.01;

wall_thick_1 = 1;
wall_thick_2 = 2;
wall_thick_3 = 3;
wall_thick_4 = 4;
wall_thick_5 = 5;
wall_thick_5_5 = 5.5;
wall_thick_6 = 6;
wall_thick_7 = 7;
wall_thick_8 = 8;
wall_thick_9 = 9;
wall_thick_10 = 10;
wall_thick_12 = 10;

tolerance_z = [0, 0, tolerance];
tolerance_x = [tolerance, 0, 0];
tolerance_y = [0, tolerance, 0];

display_tolerance_z = [0, 0, display_tolerance];
display_tolerance_x = [display_tolerance, 0, 0];
display_tolerance_y = [0, display_tolerance, 0];

display_tolerance_xz = [display_tolerance, 0, display_tolerance];
display_tolerance_xy = [display_tolerance, display_tolerance, 0];
display_tolerance_yz = [0, display_tolerance, display_tolerance];

display_tolerance_xyz = [display_tolerance, display_tolerance, display_tolerance];
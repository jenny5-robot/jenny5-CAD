// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

tolerance = 0.1;
display_tolerance = 1;

overlap_tolerance = 0.01;

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
// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

hc_sr04_sizes = [45.2, 20.5, 2];
hc_sr04_arm_sizes = [44, 21, 9];

hc_sr04_dist_to_holes = 0.75;

hc_sr04_hole_position = [
[hc_sr04_dist_to_holes, hc_sr04_dist_to_holes, 0], 
[hc_sr04_dist_to_holes + 42.5, hc_sr04_dist_to_holes, 0],
[hc_sr04_dist_to_holes + 42.5, hc_sr04_dist_to_holes + 17.5, 0],
[hc_sr04_dist_to_holes, hc_sr04_dist_to_holes + 17.5, 0]
];
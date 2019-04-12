// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_screws_nuts_washers.scad>


nut_housing_grosime_perete_baza = 2;
nut_housing_grosime_perete_lateral = 3;

offset_screw = 4;

m10_nut_housing_sizes = [2 * m10_nut_radius + 2 * nut_housing_grosime_perete_lateral, 2 * m10_nut_radius + 2 * nut_housing_grosime_perete_lateral, nut_housing_grosime_perete_baza + m10_nut_thick];

m8_nut_housing_sizes = [2 * m8_nut_radius + 2 * nut_housing_grosime_perete_lateral, 2 * m8_nut_radius + 2 * nut_housing_grosime_perete_lateral, nut_housing_grosime_perete_baza + m8_nut_thick];


m10_nut_housing_holes = [[0, 0, 0],
[- (m10_nut_housing_sizes[0] / 2 - offset_screw), - (m10_nut_housing_sizes[0] / 2 - offset_screw), 0],
[ (m10_nut_housing_sizes[0] / 2 - offset_screw), - (m10_nut_housing_sizes[0] / 2 - offset_screw), 0],
[- (m10_nut_housing_sizes[0] / 2 - offset_screw),  (m10_nut_housing_sizes[0] / 2 - offset_screw), 0],
[ (m10_nut_housing_sizes[0] / 2 - offset_screw), (m10_nut_housing_sizes[0] / 2 - offset_screw), 0]

];

m8_nut_housing_holes = [[0, 0, 0],
[- (m8_nut_housing_sizes[0] / 2 - offset_screw), - (m8_nut_housing_sizes[0] / 2 - offset_screw), 0],
[ (m8_nut_housing_sizes[0] / 2 - offset_screw), - (m8_nut_housing_sizes[0] / 2 - offset_screw), 0],
[- (m8_nut_housing_sizes[0] / 2 - offset_screw),  (m8_nut_housing_sizes[0] / 2 - offset_screw), 0],
[ (m8_nut_housing_sizes[0] / 2 - offset_screw), (m8_nut_housing_sizes[0] / 2 - offset_screw), 0]

];

m8_nut_housing_one_side_holes = [
[0, 0, 0],
[- (m8_nut_housing_sizes[0] / 2 - 2), - (m8_nut_housing_sizes[0] / 2 - 7), 0],
[ (m8_nut_housing_sizes[0] / 2 - 2), - (m8_nut_housing_sizes[0] / 2 - 7), 0],
[- (m8_nut_housing_sizes[0] / 2 - 2),  (m8_nut_housing_sizes[0] / 2 - 7), 0],
[ (m8_nut_housing_sizes[0] / 2 - 2), (m8_nut_housing_sizes[0] / 2 - 7), 0]

];


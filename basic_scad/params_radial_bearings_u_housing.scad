// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_radial_bearings.scad>
include <params_screws_nuts_washers.scad>

radial_bearing_housing_base_wall_thickness = 1;
radial_bearing_housing_lateral_wall_thickness = 3;

radial_bearing_vertical_housing_base_wall_thick = 4;
radial_bearing_vertical_housing_wall_thick_external_length = 4;
radial_bearing_vertical_housing_wall_thick_internal_length = 2;
radial_bearing_vertical_housing_wall_thick_width = 2;

radial_bearing_vertical_housing_wall_thick_length_slim = 1.5;
radial_bearing_vertical_housing_wall_thick_width_slim = 1;


rbearing_6002_enclosed_housing_size = ([2 * (rb_6002_external_radius + 2 * radial_bearing_housing_lateral_wall_thickness + 2 * m4_screw_radius), radial_bearing_housing_base_wall_thickness + rb_6002_thick + radial_bearing_housing_base_wall_thickness]);

rbearing_608_enclosed_housing_size = ([2 * (rb_608_external_radius +  radial_bearing_vertical_housing_wall_thick_external_length + radial_bearing_vertical_housing_wall_thick_internal_length + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_wall_thick_width + rb_608_thick, 2 *rb_608_external_radius + radial_bearing_vertical_housing_base_wall_thick]);

rbearing_6201_enclosed_housing_size = ([2 * (rb_6201_external_radius +  radial_bearing_vertical_housing_wall_thick_external_length + radial_bearing_vertical_housing_wall_thick_internal_length + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_wall_thick_width + rb_6201_thick, 2 *rb_6201_external_radius + radial_bearing_vertical_housing_base_wall_thick]);

rbearing_6001_enclosed_housing_size = ([2 * (rb_6001_external_radius +  radial_bearing_vertical_housing_wall_thick_external_length + radial_bearing_vertical_housing_wall_thick_internal_length + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_wall_thick_width + rb_6001_thick, 2 *rb_6001_external_radius + radial_bearing_vertical_housing_base_wall_thick]);

rbearing_6005_enclosed_housing_size = ([2 * (rb_6005_external_radius +  radial_bearing_vertical_housing_wall_thick_external_length + radial_bearing_vertical_housing_wall_thick_internal_length + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_wall_thick_width + rb_6005_thick, 2 *rb_6005_external_radius + radial_bearing_vertical_housing_base_wall_thick]);

rbearing_3205_enclosed_housing_size = ([2 * (rb_3205_external_radius +  radial_bearing_vertical_housing_wall_thick_external_length + radial_bearing_vertical_housing_wall_thick_internal_length + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_wall_thick_width + rb_3205_thick, 2 *rb_3205_external_radius + radial_bearing_vertical_housing_base_wall_thick]);

rbearing_6006_enclosed_housing_size = ([2 * (rb_6006_external_radius +  radial_bearing_vertical_housing_wall_thick_external_length + radial_bearing_vertical_housing_wall_thick_internal_length + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_wall_thick_width + rb_6006_thick, 2 *rb_6006_external_radius + radial_bearing_vertical_housing_base_wall_thick]);

rbearing_6906_enclosed_housing_size = ([2 * (rb_6906_external_radius +  radial_bearing_vertical_housing_wall_thick_external_length + radial_bearing_vertical_housing_wall_thick_internal_length + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_wall_thick_width + rb_6906_thick, 2 *rb_6906_external_radius + radial_bearing_vertical_housing_base_wall_thick]);

rbearing_6907_enclosed_housing_size = ([2 * (rb_6907_external_radius +  radial_bearing_vertical_housing_wall_thick_external_length + radial_bearing_vertical_housing_wall_thick_internal_length + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_wall_thick_width + rb_6907_thick, 2 *rb_6907_external_radius + radial_bearing_vertical_housing_base_wall_thick]);

rbearing_6905_enclosed_housing_size = ([2 * (rb_6905_external_radius +  radial_bearing_vertical_housing_wall_thick_external_length + radial_bearing_vertical_housing_wall_thick_internal_length + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_wall_thick_width + rb_6905_thick, 2 *rb_6905_external_radius + radial_bearing_vertical_housing_base_wall_thick]);

rbearing_6905_enclosed_double_housing_size = ([2 * (rb_6905_external_radius +  radial_bearing_vertical_housing_wall_thick_external_length + radial_bearing_vertical_housing_wall_thick_internal_length + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_wall_thick_width + 2 * rb_6905_thick, 2 *rb_6905_external_radius + radial_bearing_vertical_housing_base_wall_thick]);

rbearing_608_enclosed_housing_slim_size = ([2 * (rb_608_external_radius + 2 * radial_bearing_vertical_housing_wall_thick_length_slim + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_wall_thick_width_slim + rb_608_thick, 2 *rb_608_external_radius + radial_bearing_vertical_housing_base_wall_thick]);

rbearing_6001_enclosed_housing_slim_size = ([2 * (rb_6001_external_radius + 2 * radial_bearing_vertical_housing_wall_thick_length_slim + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_wall_thick_width_slim + rb_6001_thick, 2 *rb_6001_external_radius + radial_bearing_vertical_housing_base_wall_thick]);

rbearing_698_enclosed_housing_touch_size = ([2 * (rb_698_external_radius + radial_bearing_vertical_housing_wall_thick_length_slim + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_wall_thick_width + rb_698_thick, 2 *rb_698_external_radius + radial_bearing_vertical_housing_base_wall_thick]);

rbearing_6002_enclosed_housing_holes_position = [[radial_bearing_housing_lateral_wall_thickness + m4_screw_radius, (radial_bearing_housing_base_wall_thickness + rb_6002_thick + radial_bearing_housing_base_wall_thickness) / 2, 0], [2 * (rb_6002_external_radius + 2 * radial_bearing_housing_lateral_wall_thickness + 2 * m4_screw_radius) - (radial_bearing_housing_lateral_wall_thickness + m4_screw_radius), (radial_bearing_housing_base_wall_thickness + rb_6002_thick + radial_bearing_housing_base_wall_thickness) / 2, 0]];

rbearing_608_enclosed_housing_holes_position = [
[- (rb_608_external_radius + radial_bearing_vertical_housing_wall_thick_internal_length + m4_screw_radius), 
0, 
0], 
[(rb_608_external_radius + radial_bearing_vertical_housing_wall_thick_internal_length + m4_screw_radius), 
0, 
0]
];

rbearing_6201_enclosed_housing_holes_position = [
[radial_bearing_vertical_housing_wall_thick_external_length + m4_screw_radius, 
(radial_bearing_housing_base_wall_thickness + rb_6201_thick + radial_bearing_housing_base_wall_thickness) / 2, 
0], 
[2 * (rb_6201_external_radius + radial_bearing_vertical_housing_wall_thick_external_length + radial_bearing_vertical_housing_wall_thick_internal_length + 2 * m4_screw_radius) - (radial_bearing_vertical_housing_wall_thick_external_length + m4_screw_radius), (radial_bearing_housing_base_wall_thickness + rb_6201_thick + radial_bearing_housing_base_wall_thickness) / 2, 0]
];


rbearing_6001_enclosed_housing_holes_position = [
[radial_bearing_vertical_housing_wall_thick_external_length + m4_screw_radius, 
(radial_bearing_housing_base_wall_thickness + rb_6001_thick + radial_bearing_housing_base_wall_thickness) / 2, 
0], 
[2 * (rb_6001_external_radius + radial_bearing_vertical_housing_wall_thick_external_length + radial_bearing_vertical_housing_wall_thick_internal_length + 2 * m4_screw_radius) - (radial_bearing_vertical_housing_wall_thick_external_length + m4_screw_radius), (radial_bearing_housing_base_wall_thickness + rb_6001_thick + radial_bearing_housing_base_wall_thickness) / 2, 0]
];

rbearing_6005_enclosed_housing_holes_position = [
[- (rb_6005_external_radius + radial_bearing_vertical_housing_wall_thick_internal_length + m4_screw_radius), 
0, 
0], 
[(rb_6005_external_radius + radial_bearing_vertical_housing_wall_thick_internal_length + m4_screw_radius), 
0, 
0]
];

rbearing_6905_enclosed_housing_holes_position = [
[f_rbearing_6905_vertical_housing_size_bounded_half_small(0)[0] / 2 - f_rbearing_6905_vertical_housing_size_bounded_half_small(0)[1] / 2,
0,
0], 
[-f_rbearing_6905_vertical_housing_size_bounded_half_small(0)[0] / 2 + f_rbearing_6905_vertical_housing_size_bounded_half_small(0)[1] / 2, 0, 0]
];

rbearing_6907_enclosed_housing_holes_position = [
[f_rbearing_6907_vertical_housing_size_bounded_half_small(0)[0] / 2 - f_rbearing_6907_vertical_housing_size_bounded_half_small(0)[1] / 2,
0,
0], 
[-f_rbearing_6907_vertical_housing_size_bounded_half_small(0)[0] / 2 + f_rbearing_6907_vertical_housing_size_bounded_half_small(0)[1] / 2, 0, 0]
];

//echo(rbearing_6905_enclosed_housing_holes_position);

rbearing_3205_enclosed_housing_holes_position = [
[radial_bearing_vertical_housing_wall_thick_external_length + m4_screw_radius, 
(radial_bearing_housing_base_wall_thickness + rb_3205_thick + radial_bearing_housing_base_wall_thickness) / 2, 
0], 
[2 * (rb_3205_external_radius + radial_bearing_vertical_housing_wall_thick_external_length + radial_bearing_vertical_housing_wall_thick_internal_length + 2 * m4_screw_radius) - (radial_bearing_vertical_housing_wall_thick_external_length + m4_screw_radius), (radial_bearing_housing_base_wall_thickness + rb_3205_thick + radial_bearing_housing_base_wall_thickness) / 2, 0]
];

rbearing_6006_enclosed_housing_holes_position = [
[radial_bearing_vertical_housing_wall_thick_external_length + m4_screw_radius, 
(radial_bearing_housing_base_wall_thickness + rb_6006_thick + radial_bearing_housing_base_wall_thickness) / 2, 
0], 
[2 * (rb_6006_external_radius + radial_bearing_vertical_housing_wall_thick_external_length + radial_bearing_vertical_housing_wall_thick_internal_length + 2 * m4_screw_radius) - (radial_bearing_vertical_housing_wall_thick_external_length + m4_screw_radius), (radial_bearing_housing_base_wall_thickness + rb_6006_thick + radial_bearing_housing_base_wall_thickness) / 2, 0]
];

rbearing_6906_enclosed_housing_holes_position = [
[- (rb_6906_external_radius + radial_bearing_vertical_housing_wall_thick_internal_length + m4_screw_radius), 
0, 
0], 
[(rb_6906_external_radius + radial_bearing_vertical_housing_wall_thick_internal_length + m4_screw_radius), 
0, 
0]
];

rbearing_6909_enclosed_housing_holes_position = [
[- (rb_6909_external_radius + radial_bearing_vertical_housing_wall_thick_internal_length + m4_screw_radius), 
0, 
0], 
[(rb_6909_external_radius + radial_bearing_vertical_housing_wall_thick_internal_length + m4_screw_radius), 
0, 
0]
];

rbearing_608_enclosed_housing_slim_holes_position = [
[radial_bearing_vertical_housing_wall_thick_length_slim + m4_screw_radius, 
rbearing_608_enclosed_housing_slim_size[1] / 2, 
0], 
[rbearing_608_enclosed_housing_slim_size[0] - (radial_bearing_vertical_housing_wall_thick_length_slim + m4_screw_radius), 
rbearing_608_enclosed_housing_slim_size[1] / 2,
0]
];

rbearing_6001_enclosed_housing_slim_holes_position = [
[radial_bearing_vertical_housing_wall_thick_length_slim + m4_screw_radius, 
rbearing_6001_enclosed_housing_slim_size[1] / 2, 
0], 
[rbearing_6001_enclosed_housing_slim_size[0] - (radial_bearing_vertical_housing_wall_thick_length_slim + m4_screw_radius), 
rbearing_6001_enclosed_housing_slim_size[1] / 2,
0]
];

rbearing_698_enclosed_housing_touch_holes_position = [
[radial_bearing_vertical_housing_wall_thick_length_slim + m4_screw_radius, 
rbearing_608_enclosed_housing_slim_size[1] / 2, 
0], 
[rbearing_608_enclosed_housing_slim_size[0] - (radial_bearing_vertical_housing_wall_thick_length_slim + m4_screw_radius), 
rbearing_608_enclosed_housing_slim_size[1] / 2,
0]
];
rbearing_608_vertical_housing_size_bounded_half_small =[30 + 10, 10, 30]; // distance between holes + 2 * radius
rbearing_608_vertical_housing_size_bounded_half_small_top =[30 + 10, 10, rb_608_external_radius + 4]; // distance between holes + 2 * radius


rbearing_6001_vertical_housing_size_bounded_half_small =[30 + 10, rb_6001_thick + 2, 30]; // distance between holes + 2 * radius

rbearing_6002_vertical_housing_size_bounded_half_small = [2 * rb_6002_external_radius + 20, rb_6002_thick + 4, 30]; 

rbearing_6002_vertical_housing_size_bounded_half_small_top = [2 * rb_6002_external_radius + 20, rb_6002_thick + 4, rb_6002_external_radius + 4];

rbearing_6909_vertical_housing_size_half = [2 * (rb_6909_external_radius + 10), rb_6909_thick + 4, rb_6909_external_radius + 4];


function f_rbearing_6905_vertical_housing_size_bounded_half_small(extra_height) = [2 * rb_6905_external_radius + 2 * (radial_bearing_vertical_housing_wall_thick_external_length + radial_bearing_vertical_housing_wall_thick_internal_length + 2 * m4_screw_radius), rb_6905_thick + 4, rb_6905_external_radius + 4 + extra_height];

function f_rbearing_6906_vertical_housing_size_bounded_half_small(extra_height) = [2 * rb_6906_external_radius + 2 * (radial_bearing_vertical_housing_wall_thick_external_length + radial_bearing_vertical_housing_wall_thick_internal_length + 2 * m4_screw_radius), rb_6906_thick + 4, rb_6906_external_radius + 4 + extra_height];

function f_rbearing_6907_vertical_housing_size_bounded_half_small(extra_height) = [2 * rb_6907_external_radius + 2 * (radial_bearing_vertical_housing_wall_thick_external_length + radial_bearing_vertical_housing_wall_thick_internal_length + 2 * m4_screw_radius), rb_6907_thick + 4, rb_6907_external_radius + 4 + extra_height];

function f_rbearing_6905_vertical_double_housing_size_bounded_half_small(extra_height) = [2 * rb_6905_external_radius + 2 * (radial_bearing_vertical_housing_wall_thick_external_length + radial_bearing_vertical_housing_wall_thick_internal_length + 2 * m4_screw_radius), 2 * rb_6905_thick + 4, rb_6905_external_radius + 4 + extra_height];

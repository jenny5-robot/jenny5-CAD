// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// Robot website (main): jenny5.org
// Robot website (mirror): https://jenny5-robot.github.io
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_radial_bearings.scad>
include <params_screws_nuts_washers.scad>


radial_bearing_housing_base_wall_thickness = 1;
radial_bearing_housing_lateral_wall_thickness = 3;


radial_bearing_vertical_housing_base_wall_thick = 4;
radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior = 4;
radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior = 2;
radial_bearing_vertical_housing_grosime_perete_lateral_latime = 2;

radial_bearing_vertical_housing_grosime_perete_lateral_slim_lungime = 1.5;
radial_bearing_vertical_housing_grosime_perete_lateral_slim_latime = 1;

function f_radial_bearing_housing_size (rb_external_radius, rb_thick) = [2 * (rb_external_radius + radial_bearing_housing_lateral_wall_thickness), 2 * (rb_external_radius + radial_bearing_housing_lateral_wall_thickness), rb_thick + radial_bearing_housing_base_wall_thickness];

rbearing_6000_housing_size = f_radial_bearing_housing_size(rb_6000_external_radius, rb_6000_thick);
rbearing_6001_housing_size = f_radial_bearing_housing_size(rb_6001_external_radius, rb_6001_thick);
rbearing_6005_housing_size = f_radial_bearing_housing_size(rb_6005_external_radius, rb_6005_thick);
rbearing_6905_housing_size = f_radial_bearing_housing_size(rb_6905_external_radius, rb_6905_thick);
rbearing_3205_housing_size = f_radial_bearing_housing_size(rb_3205_external_radius, rb_3205_thick);
rbearing_6002_housing_size = f_radial_bearing_housing_size(rb_6002_external_radius, rb_6002_thick);
rbearing_626_housing_size = f_radial_bearing_housing_size(rb_626_external_radius, rb_626_thick);

rbearing_608_housing_size = f_radial_bearing_housing_size(rb_608_external_radius, rb_608_thick);

//echo(rbearing_608_housing_size=rbearing_608_housing_size);

rbearing_6002_enclosed_housing_size = ([2 * (rb_6002_external_radius + 2 * radial_bearing_housing_lateral_wall_thickness + 2 * m4_screw_radius), radial_bearing_housing_base_wall_thickness + rb_6002_thick + radial_bearing_housing_base_wall_thickness]);

rbearing_608_enclosed_housing_size = ([2 * (rb_608_external_radius +  radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_grosime_perete_lateral_latime + rb_608_thick, 2 *rb_608_external_radius + radial_bearing_vertical_housing_base_wall_thick]);

rbearing_6201_enclosed_housing_size = ([2 * (rb_6201_external_radius +  radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_grosime_perete_lateral_latime + rb_6201_thick, 2 *rb_6201_external_radius + radial_bearing_vertical_housing_base_wall_thick]);

rbearing_6001_enclosed_housing_size = ([2 * (rb_6001_external_radius +  radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_grosime_perete_lateral_latime + rb_6001_thick, 2 *rb_6001_external_radius + radial_bearing_vertical_housing_base_wall_thick]);

rbearing_6005_enclosed_housing_size = ([2 * (rb_6005_external_radius +  radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_grosime_perete_lateral_latime + rb_6005_thick, 2 *rb_6005_external_radius + radial_bearing_vertical_housing_base_wall_thick]);

rbearing_3205_enclosed_housing_size = ([2 * (rb_3205_external_radius +  radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_grosime_perete_lateral_latime + rb_3205_thick, 2 *rb_3205_external_radius + radial_bearing_vertical_housing_base_wall_thick]);

rbearing_6006_enclosed_housing_size = ([2 * (rb_6006_external_radius +  radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_grosime_perete_lateral_latime + rb_6006_thick, 2 *rb_6006_external_radius + radial_bearing_vertical_housing_base_wall_thick]);

rbearing_6906_enclosed_housing_size = ([2 * (rb_6906_external_radius +  radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_grosime_perete_lateral_latime + rb_6906_thick, 2 *rb_6906_external_radius + radial_bearing_vertical_housing_base_wall_thick]);

rbearing_6905_enclosed_double_housing_size = ([2 * (rb_6905_external_radius +  radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_grosime_perete_lateral_latime + 2 * rb_6905_thick, 2 *rb_6905_external_radius + radial_bearing_vertical_housing_base_wall_thick]);

rbearing_608_enclosed_housing_slim_size = ([2 * (rb_608_external_radius + 2 * radial_bearing_vertical_housing_grosime_perete_lateral_slim_lungime + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_grosime_perete_lateral_slim_latime + rb_608_thick, 2 *rb_608_external_radius + radial_bearing_vertical_housing_base_wall_thick]);

rbearing_6001_enclosed_housing_slim_size = ([2 * (rb_6001_external_radius + 2 * radial_bearing_vertical_housing_grosime_perete_lateral_slim_lungime + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_grosime_perete_lateral_slim_latime + rb_6001_thick, 2 *rb_6001_external_radius + radial_bearing_vertical_housing_base_wall_thick]);

rbearing_698_enclosed_housing_touch_size = ([2 * (rb_698_external_radius + radial_bearing_vertical_housing_grosime_perete_lateral_slim_lungime + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_grosime_perete_lateral_latime + rb_698_thick, 2 *rb_698_external_radius + radial_bearing_vertical_housing_base_wall_thick]);


rbearing_626_housing_holes_position = [[0, 0, 0], 
[-(rb_626_external_radius - 1), -(rb_626_external_radius - 1), 0], 
[(rb_626_external_radius - 1), -(rb_626_external_radius - 1), 0],
[-(rb_626_external_radius - 1), (rb_626_external_radius - 1), 0],
[(rb_626_external_radius - 1), (rb_626_external_radius - 1), 0]
];

rbearing_608_housing_holes_position = [[0, 0, 0], 
[-(rb_608_external_radius - 1), -(rb_608_external_radius - 1), 0], 
[(rb_608_external_radius - 1), -(rb_608_external_radius - 1), 0],
[-(rb_608_external_radius - 1), (rb_608_external_radius - 1), 0],
[(rb_608_external_radius - 1), (rb_608_external_radius - 1), 0]
];

rbearing_6000_housing_holes_position = [[0, 0, 0], 
[-(rb_6000_external_radius - 2), -(rb_6000_external_radius - 2), 0], 
[(rb_6000_external_radius - 2), -(rb_6000_external_radius - 2), 0],
[-(rb_6000_external_radius - 2), (rb_6000_external_radius - 2), 0],
[(rb_6000_external_radius - 2), (rb_6000_external_radius - 2), 0]
];

rbearing_6001_housing_holes_position = [[0, 0, 0], 
[-(rb_6001_external_radius - 2), -(rb_6001_external_radius - 2), 0], 
[(rb_6001_external_radius - 2), -(rb_6001_external_radius - 2), 0],
[-(rb_6001_external_radius - 2), (rb_6001_external_radius - 2), 0],
[(rb_6001_external_radius - 2), (rb_6001_external_radius - 2), 0]
];

rbearing_6002_housing_holes_position = [[0, 0, 0], 
[-(rb_6002_external_radius - 2.5), -(rb_6002_external_radius - 2.5), 0], 
[(rb_6002_external_radius - 2.5), -(rb_6002_external_radius - 2.5), 0],
[-(rb_6002_external_radius - 2.5), (rb_6002_external_radius - 2.5), 0],
[(rb_6002_external_radius - 2.5), (rb_6002_external_radius - 2.5), 0]
];

rbearing_6005_housing_holes_position = [[0, 0, 0], 
[-(rb_6005_external_radius - 5), -(rb_6005_external_radius - 5), 0], 
[(rb_6005_external_radius - 5), -(rb_6005_external_radius - 5), 0],
[-(rb_6005_external_radius - 5), (rb_6005_external_radius - 5), 0],
[(rb_6005_external_radius - 5), (rb_6005_external_radius - 5), 0]
];

rbearing_6905_housing_holes_position = [[0, 0, 0], 
[-(rb_6905_external_radius - 4), -(rb_6905_external_radius - 4), 0], 
[(rb_6905_external_radius - 4), -(rb_6905_external_radius - 4), 0],
[-(rb_6905_external_radius - 4), (rb_6905_external_radius - 4), 0],
[(rb_6905_external_radius - 4), (rb_6905_external_radius - 4), 0]
];


//echo(rbearing_6005_housing_holes_position);

rbearing_6002_enclosed_housing_holes_position = [[radial_bearing_housing_lateral_wall_thickness + m4_screw_radius, (radial_bearing_housing_base_wall_thickness + rb_6002_thick + radial_bearing_housing_base_wall_thickness) / 2, 0], [2 * (rb_6002_external_radius + 2 * radial_bearing_housing_lateral_wall_thickness + 2 * m4_screw_radius) - (radial_bearing_housing_lateral_wall_thickness + m4_screw_radius), (radial_bearing_housing_base_wall_thickness + rb_6002_thick + radial_bearing_housing_base_wall_thickness) / 2, 0]];

rbearing_608_enclosed_housing_holes_position = [
[radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + m4_screw_radius, 
(radial_bearing_housing_base_wall_thickness + rb_608_thick + radial_bearing_housing_base_wall_thickness) / 2, 
0], 
[2 * (rb_608_external_radius + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior + 2 * m4_screw_radius) - (radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + m4_screw_radius), (radial_bearing_housing_base_wall_thickness + rb_608_thick + radial_bearing_housing_base_wall_thickness) / 2, 0]
];

rbearing_6201_enclosed_housing_holes_position = [
[radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + m4_screw_radius, 
(radial_bearing_housing_base_wall_thickness + rb_6201_thick + radial_bearing_housing_base_wall_thickness) / 2, 
0], 
[2 * (rb_6201_external_radius + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior + 2 * m4_screw_radius) - (radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + m4_screw_radius), (radial_bearing_housing_base_wall_thickness + rb_6201_thick + radial_bearing_housing_base_wall_thickness) / 2, 0]
];


rbearing_6001_enclosed_housing_holes_position = [
[radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + m4_screw_radius, 
(radial_bearing_housing_base_wall_thickness + rb_6001_thick + radial_bearing_housing_base_wall_thickness) / 2, 
0], 
[2 * (rb_6001_external_radius + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior + 2 * m4_screw_radius) - (radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + m4_screw_radius), (radial_bearing_housing_base_wall_thickness + rb_6001_thick + radial_bearing_housing_base_wall_thickness) / 2, 0]
];

rbearing_6005_enclosed_housing_holes_position = [
[radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + m4_screw_radius, 
(radial_bearing_housing_base_wall_thickness + rb_6005_thick + radial_bearing_housing_base_wall_thickness) / 2, 
0], 
[2 * (rb_6005_external_radius + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior + 2 * m4_screw_radius) - (radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + m4_screw_radius), (radial_bearing_housing_base_wall_thickness + rb_6005_thick + radial_bearing_housing_base_wall_thickness) / 2, 0]
];

rbearing_6905_enclosed_housing_holes_position = [
[f_rbearing_6905_vertical_housing_size_bounded_half_small(0)[0] / 2 - f_rbearing_6905_vertical_housing_size_bounded_half_small(0)[1] / 2,
0,
0], 
[-f_rbearing_6905_vertical_housing_size_bounded_half_small(0)[0] / 2 + f_rbearing_6905_vertical_housing_size_bounded_half_small(0)[1] / 2, 0, 0]
];


//echo(rbearing_6905_enclosed_housing_holes_position);

rbearing_3205_enclosed_housing_holes_position = [
[radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + m4_screw_radius, 
(radial_bearing_housing_base_wall_thickness + rb_3205_thick + radial_bearing_housing_base_wall_thickness) / 2, 
0], 
[2 * (rb_3205_external_radius + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior + 2 * m4_screw_radius) - (radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + m4_screw_radius), (radial_bearing_housing_base_wall_thickness + rb_3205_thick + radial_bearing_housing_base_wall_thickness) / 2, 0]
];

rbearing_6006_enclosed_housing_holes_position = [
[radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + m4_screw_radius, 
(radial_bearing_housing_base_wall_thickness + rb_6006_thick + radial_bearing_housing_base_wall_thickness) / 2, 
0], 
[2 * (rb_6006_external_radius + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior + 2 * m4_screw_radius) - (radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + m4_screw_radius), (radial_bearing_housing_base_wall_thickness + rb_6006_thick + radial_bearing_housing_base_wall_thickness) / 2, 0]
];

rbearing_6906_enclosed_housing_holes_position = [
[- (rb_6906_external_radius + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior + m4_screw_radius), 
0, 
0], 
[(rb_6906_external_radius + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior + m4_screw_radius), 
0, 
0]
];

rbearing_608_enclosed_housing_slim_holes_position = [
[radial_bearing_vertical_housing_grosime_perete_lateral_slim_lungime + m4_screw_radius, 
rbearing_608_enclosed_housing_slim_size[1] / 2, 
0], 
[rbearing_608_enclosed_housing_slim_size[0] - (radial_bearing_vertical_housing_grosime_perete_lateral_slim_lungime + m4_screw_radius), 
rbearing_608_enclosed_housing_slim_size[1] / 2,
0]
];

rbearing_6001_enclosed_housing_slim_holes_position = [
[radial_bearing_vertical_housing_grosime_perete_lateral_slim_lungime + m4_screw_radius, 
rbearing_6001_enclosed_housing_slim_size[1] / 2, 
0], 
[rbearing_6001_enclosed_housing_slim_size[0] - (radial_bearing_vertical_housing_grosime_perete_lateral_slim_lungime + m4_screw_radius), 
rbearing_6001_enclosed_housing_slim_size[1] / 2,
0]
];

rbearing_698_enclosed_housing_touch_holes_position = [
[radial_bearing_vertical_housing_grosime_perete_lateral_slim_lungime + m4_screw_radius, 
rbearing_608_enclosed_housing_slim_size[1] / 2, 
0], 
[rbearing_608_enclosed_housing_slim_size[0] - (radial_bearing_vertical_housing_grosime_perete_lateral_slim_lungime + m4_screw_radius), 
rbearing_608_enclosed_housing_slim_size[1] / 2,
0]
];

//rbearing_608_vertical_housing_size_bounded_half = [60 + 10, 10, 30]; // distance between holes + 2 * radius
rbearing_608_vertical_housing_size_bounded_half_small =[30 + 10, 10, 30]; // distance between holes + 2 * radius
rbearing_608_vertical_housing_size_bounded_half_small_top =[30 + 10, 10, rb_608_external_radius + 4]; // distance between holes + 2 * radius


rbearing_6001_vertical_housing_size_bounded_half_small =[30 + 10, rb_6001_thick + 2, 30]; // distance between holes + 2 * radius

//rbearing_6002_vertical_housing_size_bounded_half = [60 + 10, 10, 30]; // distance between holes + 2 * radius
rbearing_6002_vertical_housing_size_bounded_half_small = [2 * rb_6002_external_radius + 20, rb_6002_thick + 4, 30]; 
//rbearing_6005_vertical_housing_size_bounded_half_small = [2 * rb_6005_external_radius + 20, rb_6005_thick + 4, 39]; 
//rbearing_6905_vertical_housing_size_bounded_half_small = [2 * rb_6905_external_radius + 20, rb_6905_thick + 4, 43]; 

rbearing_6002_vertical_housing_size_bounded_half_small_top = [2 * rb_6002_external_radius + 20, rb_6002_thick + 4, rb_6002_external_radius + 4];
//rbearing_6005_vertical_housing_size_bounded_half_small_top = [2 * rb_6005_external_radius + 20, rb_6005_thick + 4, rb_6005_external_radius + 4];
//rbearing_6905_vertical_housing_size_bounded_half_small_top = [2 * rb_6905_external_radius + 20, rb_6905_thick + 4, rb_6905_external_radius + 4];

function f_rbearing_6905_vertical_housing_size_bounded_half_small(extra_height) = [2 * rb_6905_external_radius + 2 * (radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior + 2 * m4_screw_radius), rb_6905_thick + 4, rb_6905_external_radius + 4 + extra_height];

// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_radial_bearings.scad>
include <params_screws_nuts_washers.scad>


radial_bearing_housing_grosime_perete_baza = 2;
radial_bearing_housing_grosime_perete_lateral = 3;


radial_bearing_vertical_housing_grosime_perete_baza = 4;
radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior = 4;
radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior = 2;
radial_bearing_vertical_housing_grosime_perete_lateral_latime = 2;

radial_bearing_vertical_housing_grosime_perete_lateral_slim_lungime = 1.5;
radial_bearing_vertical_housing_grosime_perete_lateral_slim_latime = 1;

function f_radial_bearing_housing_size (rb_external_radius, rb_thick) = [2 * (rb_external_radius + radial_bearing_housing_grosime_perete_lateral), 2 * (rb_external_radius + radial_bearing_housing_grosime_perete_lateral), rb_thick + radial_bearing_housing_grosime_perete_baza];

rbearing_6002_housing_size = f_radial_bearing_housing_size(rb_6002_external_radius, rb_6002_thick);
rbearing_626_housing_size = f_radial_bearing_housing_size(rb_626_external_radius, rb_626_thick);

rbearing_608_housing_size = f_radial_bearing_housing_size(rb_608_external_radius, rb_608_thick);

//echo(rbearing_608_housing_size=rbearing_608_housing_size);

rbearing_6002_enclosed_housing_size = ([2 * (rb_6002_external_radius + 2 * radial_bearing_housing_grosime_perete_lateral + 2 * m4_screw_radius), radial_bearing_housing_grosime_perete_baza + rb_6002_thick + radial_bearing_housing_grosime_perete_baza]);

rbearing_608_enclosed_housing_size = ([2 * (rb_608_external_radius +  radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_grosime_perete_lateral_latime + rb_608_thick, 2 *rb_608_external_radius + radial_bearing_vertical_housing_grosime_perete_baza]);

rbearing_6201_enclosed_housing_size = ([2 * (rb_6201_external_radius +  radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_grosime_perete_lateral_latime + rb_6201_thick, 2 *rb_6201_external_radius + radial_bearing_vertical_housing_grosime_perete_baza]);

rbearing_608_enclosed_housing_slim_size = ([2 * (rb_608_external_radius + 2 * radial_bearing_vertical_housing_grosime_perete_lateral_slim_lungime + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_grosime_perete_lateral_slim_latime + rb_608_thick, 2 *rb_608_external_radius + radial_bearing_vertical_housing_grosime_perete_baza]);

rbearing_698_enclosed_housing_touch_size = ([2 * (rb_698_external_radius + radial_bearing_vertical_housing_grosime_perete_lateral_slim_lungime + 2 * m4_screw_radius), 2 * radial_bearing_vertical_housing_grosime_perete_lateral_latime + rb_698_thick, 2 *rb_698_external_radius + radial_bearing_vertical_housing_grosime_perete_baza]);

/*
function f_radial_bearing_housing_holes_position (rb_external_radius, rb_thick, screw_radius = m4_screw_radius) = [
[0, 0, 0], 
[-(rb_external_radius + 1 + screw_radius) / sqrt(2), -(rb_external_radius + 1 + screw_radius) / sqrt(2), 0], 
[(rb_external_radius + 1 + screw_radius) / sqrt(2), -(rb_external_radius + 1 + screw_radius) / sqrt(2), 0],
[-(rb_external_radius + 1 + screw_radius) / sqrt(2), (rb_external_radius + 1 + screw_radius) / sqrt(2), 0],
[(rb_external_radius + 1 + screw_radius) / sqrt(2), (rb_external_radius + 1 + screw_radius) / sqrt(2), 0]
];
*/

//rbearing_6002_housing_holes_position = f_radial_bearing_housing_holes_position(rb_6002_external_radius, rb_6002_thick);

//rbearing_626_housing_holes_position = f_radial_bearing_housing_holes_position(rb_626_external_radius, rb_626_thick, m4_screw_radius);

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

rbearing_6002_housing_holes_position = [[0, 0, 0], 
[-(rb_6002_external_radius - 2.5), -(rb_6002_external_radius - 2.5), 0], 
[(rb_6002_external_radius - 2.5), -(rb_6002_external_radius - 2.5), 0],
[-(rb_6002_external_radius - 2.5), (rb_6002_external_radius - 2.5), 0],
[(rb_6002_external_radius - 2.5), (rb_6002_external_radius - 2.5), 0]
];

rbearing_6002_enclosed_housing_holes_position = [[radial_bearing_housing_grosime_perete_lateral + m4_screw_radius, (radial_bearing_housing_grosime_perete_baza + rb_6002_thick + radial_bearing_housing_grosime_perete_baza) / 2, 0], [2 * (rb_6002_external_radius + 2 * radial_bearing_housing_grosime_perete_lateral + 2 * m4_screw_radius) - (radial_bearing_housing_grosime_perete_lateral + m4_screw_radius), (radial_bearing_housing_grosime_perete_baza + rb_6002_thick + radial_bearing_housing_grosime_perete_baza) / 2, 0]];

rbearing_608_enclosed_housing_holes_position = [
[radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + m4_screw_radius, 
(radial_bearing_housing_grosime_perete_baza + rb_608_thick + radial_bearing_housing_grosime_perete_baza) / 2, 
0], 
[2 * (rb_608_external_radius + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior + 2 * m4_screw_radius) - (radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + m4_screw_radius), (radial_bearing_housing_grosime_perete_baza + rb_608_thick + radial_bearing_housing_grosime_perete_baza) / 2, 0]
];

rbearing_6201_enclosed_housing_holes_position = [
[radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + m4_screw_radius, 
(radial_bearing_housing_grosime_perete_baza + rb_6201_thick + radial_bearing_housing_grosime_perete_baza) / 2, 
0], 
[2 * (rb_6201_external_radius + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior + 2 * m4_screw_radius) - (radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior + m4_screw_radius), (radial_bearing_housing_grosime_perete_baza + rb_6201_thick + radial_bearing_housing_grosime_perete_baza) / 2, 0]
];

rbearing_608_enclosed_housing_slim_holes_position = [
[radial_bearing_vertical_housing_grosime_perete_lateral_slim_lungime + m4_screw_radius, 
rbearing_608_enclosed_housing_slim_size[1] / 2, 
0], 
[rbearing_608_enclosed_housing_slim_size[0] - (radial_bearing_vertical_housing_grosime_perete_lateral_slim_lungime + m4_screw_radius), 
rbearing_608_enclosed_housing_slim_size[1] / 2,
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

rbearing_608_vertical_housing_size_bounded_half = [60 + 10, 10, 30]; // distance between holes + 2 * radius
rbearing_608_vertical_housing_size_bounded_half_small =[30 + 10, 10, 30]; // distance between holes + 2 * radius
rbearing_608_vertical_housing_size_bounded_half_small_top =[30 + 10, 10, rb_608_external_radius + 4]; // distance between holes + 2 * radius

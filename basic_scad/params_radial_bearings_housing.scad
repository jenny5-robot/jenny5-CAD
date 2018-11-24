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
rbearing_6906_housing_size = f_radial_bearing_housing_size(rb_6906_external_radius, rb_6906_thick);
rbearing_3205_housing_size = f_radial_bearing_housing_size(rb_3205_external_radius, rb_3205_thick);
rbearing_6002_housing_size = f_radial_bearing_housing_size(rb_6002_external_radius, rb_6002_thick);
rbearing_626_housing_size = f_radial_bearing_housing_size(rb_626_external_radius, rb_626_thick);

rbearing_608_housing_size = f_radial_bearing_housing_size(rb_608_external_radius, rb_608_thick);

rbearing_688_housing_size = f_radial_bearing_housing_size(rb_688_external_radius, rb_688_thick);

//echo(rbearing_608_housing_size=rbearing_608_housing_size);



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

rbearing_6906_housing_holes_position = [[0, 0, 0], 
[-(rb_6906_external_radius - 4), -(rb_6906_external_radius - 4), 0], 
[(rb_6906_external_radius - 4), -(rb_6906_external_radius - 4), 0],
[-(rb_6906_external_radius - 4), (rb_6906_external_radius - 4), 0],
[(rb_6906_external_radius - 4), (rb_6906_external_radius - 4), 0]
];


//echo(rbearing_6005_housing_holes_position);



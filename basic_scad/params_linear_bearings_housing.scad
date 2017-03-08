// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_basic_components.scad>
include <func_3d.scad>
use <basic_components.scad>
include <params_linear_bearings.scad>
include <params_alu_profiles.scad>
include <params_screws_nuts_washers.scad>
include <params_pulleys.scad>
use <pulleys.scad>


dist_to_screw_linear_bearing_housing_lm10uu = f_dist_to_screw_linear_bearing_housing(lm10uu_external_radius);
dist_to_screw_linear_bearing_housing_lm12uu = f_dist_to_screw_linear_bearing_housing(lm12uu_external_radius);


distantor_x_thick = 3;
distantor_y_sus_thick = 0;
distantor_z_interior_thick = 5.5;
distantor_z_interior_thick_corcitura = 5.5;
distantor_old_z_interior_thick = 4.5;

latime_linear_bearing_housing_y = f_latime_linear_bearing_housing(lm10uu_height);
lungime_linear_bearing_housing_y = f_lungime_linear_bearing_housing(lm10uu_external_radius);
inaltime_linear_bearing_housing_y = f_inaltime_linear_bearing_housing(lm10uu_external_radius);


linear_bearing_housing_lm10uu_sizes = [f_latime_linear_bearing_housing(lm10uu_height), f_lungime_linear_bearing_housing(lm10uu_external_radius), f_inaltime_linear_bearing_housing(lm10uu_external_radius)];

shaft_fixer_8mm_sizes = [12, wall_thick_4 + 2 * m4_screw_radius + wall_thick_2 + 8 + wall_thick_2 + 2 * m4_screw_radius + wall_thick_4, 8 + wall_thick_3];
shaft_fixer_10mm_sizes = [12, wall_thick_4 + 2 * m4_screw_radius + wall_thick_2 + 10 + wall_thick_2 + 2 * m4_screw_radius + wall_thick_4, 10 + wall_thick_3];

//inaltime_linear_bearing_housing_sus_y = f_inaltime_linear_bearing_housing_extra(lm10uu_external_radius, distantor_y_sus_thick);

latime_linear_bearing_housing_x = f_latime_linear_bearing_housing(lm8luu_height);
lungime_linear_bearing_housing_x = f_lungime_linear_bearing_housing(lm8luu_external_radius);
inaltime_linear_bearing_housing_x = f_inaltime_linear_bearing_housing(lm8luu_external_radius);

nut_housing_z_axis_length = 34;
nut_housing_z_axis_width = 24;

nut_housing_z_axis_height_interior = 18;
nut_housing_z_axis_height_exterior = m8_nut_radius + wall_thick_3;

nut_housing_z_axis_height_interior_new = 13; // pentru profilele de 20 mm
nut_housing_z_axis_height_exterior = m8_nut_radius + wall_thick_3;

washer_thick = washer_8_thick;
z_screw_support_length = washer_4_12_radius  + wall_thick_5 +  wall_thick_2 + 2 * roata_dintata_t2_5_30_dinti_raza_flansa + wall_thick_2 + wall_thick_5 + washer_4_12_radius;
z_screw_support_width = 2 * lm8uu_external_radius + 2 * wall_thick_3;


//echo ("z_screw_support_length", z_screw_support_length);

inaltime_baza_up_screw_support = wall_thick_3 + lm8uu_height;
z_screw_support_up_height = inaltime_baza_up_screw_support  + 5 * washer_thick + roata_dintata_t2_5_30_dinti_height ;

inaltime_baza_down_screw_support = wall_thick_3 + lm8uu_height + 0.5;
z_screw_support_down_height = inaltime_baza_down_screw_support;// + 4 * washer_thick + roata_dintata_t2_5_30_dinti_height / 2 ;

picioruse_dist_to_margin = 4;
picioruse_length = 2;
picioruse_radius = 2.1;

toleranta_lungime_picioruse = 0.1;

grosime_perete_sustinere_surub_opto = 12;

linear_bearing_housing_cu_3_urechi_sizes = [    ];

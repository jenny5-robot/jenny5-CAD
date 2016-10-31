// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_basic_components.scad>
include <../basic_scad/params_radial_bearings.scad>
include <../basic_scad/params_radial_bearings_housing.scad>



latura_L = 40;
latura_U = 40;

dist_edge_to_shaft = 14; //radius_roata_reductor;

chest_height = 250;
chest_length = 430;

latime_coloana_vertebrala = 50;

body_arm_length = chest_height - 2 * wall_thick_3 - 2 * washer_8_thick -  2 * rb_608_thick;

dist_between_motor_and_axis = 89;//radius_roata_reductor + radius_roata_motor_reductor + 10;
   coloana_vertebrala_size = [30, 30, chest_height - 2 * grosime_perete_L];



   motor_housing_tolerance = 10;
   motor_housing_tolerance_large = 20;

   //motor_housing_width_with_tolerance = motor_housing_width + 2 * motor_housing_tolerance;
// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_radial_bearings.scad>
include <params_screws_nuts_washers.scad>
include <params_basic_components.scad>
include <config.scad>
include <params_radial_bearings_housing.scad>
include <params_stepper_motors.scad>
use <radial_bearings.scad>
use <basic_components.scad>
use <potentiometer_support.scad>
include <radial_bearing_housing.scad>



//---------------------------------------------------------------------------
module radial_bearing_housing_with_potentiometer_support(rbearing_housing_size, rbearing_housing_holes_position, rb_external_radius, rb_thick, housing_height, screw_radius = m4_screw_radius, extension_length = 25)
{
    color(plastic_color){
      radial_bearing_housing(rbearing_housing_size, rbearing_housing_holes_position, rb_external_radius, rb_thick, housing_height, screw_radius);
        
        pot_support_width = 28;
      translate ([rbearing_housing_size[0] / 2 - 2, -pot_support_width / 2, 0]) potentiometer_support_squared(length = 27, width = pot_support_width, height = 5, dist_to_hole = 10, hole_tolerance = 15, wall_thick = 3, pot_width = 16, stopper_shift = 0.0);
    }
}
//---------------------------------------------------------------------------
module radial_bearing_double_housing_with_potentiometer_support(rbearing_housing_size, rbearing_housing_holes_position, rb_external_radius, rb_thick, housing_height, screw_radius = m4_screw_radius, extension_length = 25)
{
    color(plastic_color){
      radial_bearing_housing(rbearing_housing_size, rbearing_housing_holes_position, rb_external_radius, 2 * rb_thick, housing_height, screw_radius);
        
        pot_support_width = 28;
      translate ([rbearing_housing_size[0] / 2 - 2, -pot_support_width / 2, 0]) potentiometer_support_squared(length = 27, width = pot_support_width, height = 7, dist_to_hole = 10, hole_tolerance = 15, wall_thick = 3, pot_width = 16, stopper_shift = 0.0);
    }
}
//---------------------------------------------------------------------------
module rbearing_608_housing_with_potentiometer_support()
{
    radial_bearing_housing_with_potentiometer_support(rbearing_608_housing_size, rbearing_608_housing_holes_position, rb_608_external_radius, rb_608_thick, rbearing_608_housing_size[2] + 7, m4_screw_radius, 25);
}
//---------------------------------------------------------------------------
module rbearing_6001_housing_with_potentiometer_support()
{
    radial_bearing_housing_with_potentiometer_support(rbearing_6001_housing_size, rbearing_6001_housing_holes_position, rb_6001_external_radius, rb_6001_thick, rbearing_6001_housing_size[2], m4_screw_radius, 25);
}
//---------------------------------------------------------------------------
module rbearing_6001_double_housing_with_potentiometer_support()
{
    radial_bearing_double_housing_with_potentiometer_support(rbearing_6001_housing_size, rbearing_6001_housing_holes_position, rb_6001_external_radius, rb_6001_thick, rbearing_6001_housing_size[2] + rb_6001_thick, m4_screw_radius, 25);
}
//---------------------------------------------------------------------------
// rbearing_608_housing_with_potentiometer_support();
 rbearing_6001_double_housing_with_potentiometer_support();
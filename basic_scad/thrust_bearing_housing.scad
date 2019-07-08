// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_thrust_bearing_housing.scad>
include <params_thrust_bearings.scad>
include <params_basic_components.scad>
include <material_colors.scad>
include <params_screws_nuts_washers.scad>

use <basic_components.scad>
include <tolerance.scad>

//--------------------------------------------------
module thrust_bearing_housing(housing_size, bearing_external_radius, bearing_internal_radius)
{
    difference(){
        color (plastic_color)
            translate ([-housing_size[0] / 2, -housing_size[1] / 2, 0])
                my_cube_rounded2(housing_size);
        
        // bearing
        translate([0, 0, housing_size[2] - thrust_bearing_depth])
            difference(){
                cylinder(h = thrust_bearing_depth + 1, r = bearing_external_radius, $fn = 100);
                translate (-display_tolerance_z) cylinder(h = thrust_bearing_depth + 1 + 2 * display_tolerance, r = bearing_internal_radius, $fn = 100);
            }
        // central shaft
        translate (-display_tolerance_z) cylinder(h = housing_size[2] + 2 * display_tolerance, r = 9.5, $fn = 100); // for 928 bearing
            
            // screw holes
        for (i = [0 : 3]){
          translate(thrust_bearing_housing_51105_holes[i] - display_tolerance_z) cylinder (h = housing_size[2] + 2 * display_tolerance, r = 2, $fn = 20);
          translate(thrust_bearing_housing_51105_holes[i] + [0, 0, housing_size[2] - m4_nut_thick]) cylinder (h = m4_nut_thick, r2 = m4_nut_radius, r1 = m4_screw_radius, $fn = 20);
        }
    }
}
//--------------------------------------------------
module thrust_bearing_housing_51105()
{
    thrust_bearing_housing(thrust_bearing_housing_51105_size, tb_51105_external_radius, tb_51105_internal_radius);
}
//--------------------------------------------------
module thrust_bearing_housing_51105_small()
{
    thrust_bearing_housing(thrust_bearing_housing_51105_thin_size, tb_51105_external_radius, tb_51105_internal_radius);
}
//--------------------------------------------------

//thrust_bearing_housing_51105();

thrust_bearing_housing_51105_small();
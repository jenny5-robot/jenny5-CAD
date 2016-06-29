include <../basic_scad/params_sensor_array.scad>
use <../basic_scad/basic_components.scad>
include <../basic_scad/config.scad>
include <../basic_scad/params_stepper_motors.scad>
include <../basic_scad/params_radial_bearings.scad>
include <../basic_scad/params_basic_components.scad>
include <../basic_scad/params_screws_nuts_washers.scad>
include <../basic_scad/params_radial_bearings_housing.scad>

//----------------------------------------------------------
module qtr_a1_support(inaltime)
{
    difference(){
        union(){
          color (plastic_color) cylinder(h = inaltime, r = 30, $fn = 200);
        }
 // canal pt blocat lumina
        translate ([0, 0, inaltime - 3]) cylinder_empty(5, 28, 25.2, 100);
        // gauri bearing
        translate (rbearing_608_housing_holes_position[0] - display_tolerance_z) cylinder (h = inaltime + 2 * display_tolerance, r = rb_608_external_radius - 0.5, $fn = 50);
        for (i=[1:4])
         rotate ([0, 0, 0]) translate (rbearing_608_housing_holes_position[i]) cylinder (h = inaltime + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);

        // QTR-1A sensor holes
        
            // screw
            translate ([0, -QTR_1A_hole_position[0] - rb_608_external_radius, 0] - display_tolerance_z) cylinder (h = inaltime + 2 * display_tolerance, r = 1, $fn = 20);
            // nuts
            translate ([0, -QTR_1A_hole_position[0] - rb_608_external_radius, 0]) cylinder (h = 2, r = m2_nut_radius + 0.3, $fn = 6);
         // QTR-1A connectors hole
            translate ([- QTR_1A_size[1] / 2 - 0.75, - rb_608_external_radius, 0] + [0, -QTR_1A_size[0], 0] - display_tolerance_z) cube([QTR_1A_size[1] + 1, 3.5, inaltime] + 2 * display_tolerance_z);
    }
}
//----------------------------------------------------------


qtr_a1_support(7);
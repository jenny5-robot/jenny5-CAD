// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

use <../basic_scad/basic_components.scad>
include <../basic_scad/params_stepper_motors.scad>
include <../basic_scad/params_radial_bearings.scad>
include <../basic_scad/params_basic_components.scad>
include <../basic_scad/params_screws_nuts_washers.scad>
include <../basic_scad/params_radial_bearings_housing.scad>
include <../basic_scad/params_sensor_array.scad>
include <../basic_scad/params_webcam.scad>


use <../basic_scad/pulleys.scad>
use <../basic_scad/radial_bearing_housing.scad>
use <../basic_scad/spacer.scad>
use <../basic_scad/potentiometers.scad>
use <../basic_scad/screws_nuts_washers.scad>
use <../basic_scad/radial_bearing_housing.scad>
use <../basic_scad/radial_bearings.scad>
use <../basic_scad/stepper_motors.scad>
use <../basic_scad/webcam.scad>
use <../basic_scad/ultrasonic_support.scad>
use <../basic_scad/ultrasonic.scad>


//include <params_robot.scad>
include <params_head.scad>

//----------------------------------------------------------
module qtr_a1_support(inaltime)
{
    difference(){
        union(){
          cylinder(h = inaltime, r = 30, $fn = 200);
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
module qtr_a1_support_with_motor_support()
{
    inaltime = 7;
    difference(){
        union(){
     rotate ([0, 0, 180]) qtr_a1_support(inaltime);
 // motor support
          translate ([35 / 2, 30 - 5.8, inaltime]) mirror ([0, 0, 1]) rotate([0, 0, 90]) 
           
            difference(){
            potentiometer_support(50, 35, inaltime, 36, 0, 3, 0);
                // gauri motor nema11
        translate ([36, 35 / 2, 0] + gearbox_nema_11_holes_position[0] - display_tolerance_z) cylinder (h = head_base_sizes2[2] + 2 + 2 * display_tolerance, r = nema_11_motor_gearbox_hole_radius, $fn = 50);
        for (i=[1:4])
         translate ([36, 35 / 2, 0] - display_tolerance_z) rotate ([0, 0, 0]) translate (gearbox_nema_11_holes_position[i]) cylinder (h = head_base_sizes2[2] + 2 + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);

// belt tensioner
        hull(){
        translate ([14, 35/2 - 8, 0] + gearbox_nema_11_holes_position[0] - display_tolerance_z) cylinder (h = head_base_sizes2[2] + 2 + 2 * display_tolerance, r = 2, $fn = 50);
        translate ([14, 35/2 + 8, 0] + gearbox_nema_11_holes_position[0] - display_tolerance_z) cylinder (h = head_base_sizes2[2] + 2 + 2 * display_tolerance, r = 2, $fn = 50);
        }
        }
    }
         translate ([0, 0, inaltime - 3]) cylinder_empty(4, 28, 25.2, 100);
    }
           
}
//----------------------------------------------------------
module head_pulley()
{
    my_pulley(60, 33, 0, 18, 8, 8, 20, 0, 1);// motor head

}
//---------------------------------------------------------------------------
module gradient_support()
{
    retainer_ht = 1.5;
    
    difference(){
        union(){
          cylinder (h = retainer_ht, r2 = 27.3, r1 = 26, $fn = 100);
          translate ([0, 0, retainer_ht]) cylinder (h = 7.5, r = 27.3, $fn = 100);
        }
        translate ([0, 0, retainer_ht]) cylinder (h = 11, r = 26, $fn = 100);
        // screw hole
        translate (-display_tolerance_z) cylinder (h = retainer_ht + 2 * display_tolerance, r = 4, $fn = 20);
    }
}
//---------------------------------------------------------------------------
module bearing_housing_on_axis()
{
    rbearing_608_housing_double();
    translate([-rbearing_608_housing_size[0] / 2, rbearing_608_housing_size[0] / 2 - 2, 0])rectangular_axis_slider(rbearing_608_housing_size[0], 3);
}
//---------------------------------------------------------------------------
module head_base()
{
  qtr_a1_support_with_motor_support();
    
  translate ([30, -37 / 2, 7]) rotate ([0, 90, 0]) spacer_with_1_hole(7, 37, 10);
    difference(){
        translate ([23, -37 / 2, 0]) cube([10, 37, 7]);
        cylinder (h = 7, r = 30);
    }
  translate ([-30 - 10, -37 / 2, 7]) rotate ([0, 90, 0]) spacer_with_1_hole(7, 37, 10);
    difference(){
  translate ([-30, -37 / 2, 0]) cube([7, 37, 7]);  
        cylinder (h = 7, r = 30);
    }
}
//---------------------------------------------------------------------------
module nema_11_with_gearbox_and_pulley()
{
    nema_11_with_gearbox();
    translate ([0, 0, nema_11_with_gearbox_height + 12]) my_pulley(57, 12, 0, 18, 6, 0, 0, 0);
}
//---------------------------------------------------------------------------
module hc_sr04_and_c920_with_support()
{
    hc_sr04_and_c920_support();
    translate ([1, -3, 8]) hc_sr04();
    translate ([c920_length - c920_length / 2 + c920_dist_between_holder_holes / 2 - c920_depth / 2 + 2, -c920_height - 7, c920_depth]) mirror ([1, 0, 0]) rotate ([-90, 0, 0]) c920();
}
//---------------------------------------------------------------------------
module eye_support()
{
    qtr_a1_support_with_motor_support();
    translate ([0, 60, -52]) nema_11_with_gearbox_and_pulley();
    translate ([0, 0, 25]) mirror ([0, 0, 1]) head_pulley();
    
    mirror ([0, 0, 1]) bearing_housing_on_axis();
    translate ([0, 0, -rb_608_thick]) 608rs();
    translate ([0, 0, -2 * rb_608_thick]) 608rs();
    // long screw
    cylinder (h = 100, r = 4, $fn = 30, center = true);
    // bones
    translate ([0, 0, 25]) cube_empty(6, 10, 100);
    translate ([0, 0, -114]) cube_empty(6, 10, 100);
    // cameras
    
    // ultrasonic
    translate ([-7, -32, 36]) rotate ([0, 90, -90]) hc_sr04_and_c920_with_support();
    
}
//---------------------------------------------------------------------------
module head()
{
    mirror ([0, 0, 1]) head_base();
    translate ([0, 0, -25]) head_pulley();
    translate ([0, 0, -25]) M8x80_hexa();
    translate ([0, 0, 16]) mirror([0, 0, 1]) rbearing_608_housing_double();
    translate ([0, 0, 0]) 608rs();
    translate ([0, 0, rb_608_thick]) 608rs();
    translate ([0, 0, 2 * rb_608_thick]) M8_nut();
    
    translate ([0, 0, 36]) M8_nut();
    translate ([0, 0, 42]) cube_empty(6, 10, 100);
    
    translate ([0, 60, 52]) mirror ([0, 0, 1]) nema_11_with_gearbox_and_pulley();
    
    translate ([8, -20, 128]) rotate ([0, 90, 0]) eye_support();
}
//---------------------------------------------------------------------------

qtr_a1_support(7);
//hc_sr04_and_c920_with_support();

//head();
//eye_support();

//gradient_support();

//head_pulley();

//head_base();

//bearing_housing_on_axis();
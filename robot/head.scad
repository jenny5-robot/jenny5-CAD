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

use <../basic_scad/pulleys.scad>
use <../basic_scad/radial_bearing_housing.scad>
use <../basic_scad/spacer.scad>
use <../basic_scad/potentiometers.scad>


include <params_robot.scad>



include <params_head.scad>

//----------------------------------------------------------
module neck_coupler()
{
    h = 20;
    latura = 22;
    difference(){
        union(){
          translate ([0, 0, 10]) cylinder (h = h, r = latura / 2, $fn = 60);
          
          pot_gear(num_teeth = 12, angle = 15, internal_radius = 2.5, height = 10);
        }
        // ax motor
        translate (-display_tolerance_z) cylinder (h = h + 2 * display_tolerance, r = m6_screw_radius + 0.1, $fn = 20);
        // os
        translate ([- bone_thick / 2, - bone_thick / 2,  11]) cube([bone_thick,  bone_thick, h  + 1]);
        // gaura m3 fixare bone
        translate ([0, -latura / 2, h - m3_nut_radius - 1 + 10] - display_tolerance_y) rotate([-90, 0, 0]) cylinder (h = latura / 2, r = m3_screw_radius, $fn = 20);
        translate ([0, -latura / 2 + 3, h - m3_nut_radius - 1 + 10]) rotate([-90, 30, 0]) cylinder (h = m3_nut_height + 1, r = m3_nut_radius, $fn = 6);
    }
}
//---------------------------------------------------------------------------
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
module eye_support3()
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
module head_vertical_pulley()
{
    difference(){
      my_pulley(60, 33, 0, 18, 6, 0, 0, 0, angle = 0);
      translate ([-5.2, -5.2, 0]) cube([10.4, 10.4, 15]);
        // screw
        translate ([0, 0, 5.5]) rotate ([0, 90, 0]) cylinder (h = 30, r = m4_screw_radius, $fn = 20); 
        // nut
hull(){
        translate ([10, 0, 5.5]) rotate ([0, 90, 0]) cylinder (h = m4_nut_thick, r = m4_nut_radius, $fn = 6); 
        translate ([10, 0, 0]) rotate ([0, 90, 0]) cylinder (h = m4_nut_thick, r = m4_nut_radius, $fn = 6); 
} 
    }
    difference(){
        color("red") translate ([0, 0, 11]) cylinder (h = 9, r = 27.2, $fn = 100);
        translate ([0, 0, 10]) cylinder (h = 11, r = 26, $fn = 100);
    }
   
}
//---------------------------------------------------------------------------
module head_pulley()
{
    my_pulley(60, 33, 0, 18, 8, 0, screw_head_radius = 8, 1, angle = 20);// motor head
    difference(){
        color("red") translate ([0, 0, 11]) cylinder (h = 9, r = 27.3, $fn = 100);
        translate ([0, 0, 10]) cylinder (h = 11, r = 26, $fn = 100);
    }
    // margine
}
//---------------------------------------------------------------------------
module bearing_housing_on_axis()
{
    rbearing_608_housing_double();
    translate([-rbearing_608_housing_size[0] / 2, rbearing_608_housing_size[0] / 2 - 2, 0])rectangular_axis_slider(rbearing_608_housing_size[0], 3);
}
//---------------------------------------------------------------------------
module bearing_housing_on_axis2()
{
    rbearing_608_housing_double();
}
//---------------------------------------------------------------------------
module head_base()
{
  eye_support3();
    
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
module head()
{
head_base();

}
//---------------------------------------------------------------------------

head();

//head_pulley();

//neck_coupler();

//head_base();

//eye_support3();
//bearing_housing_on_axis();
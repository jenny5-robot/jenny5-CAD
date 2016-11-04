// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------



use <../basic_scad/basic_components.scad>
include <../basic_scad/config.scad>
include <../basic_scad/params_stepper_motors.scad>
include <../basic_scad/params_radial_bearings.scad>
include <../basic_scad/params_basic_components.scad>
include <../basic_scad/params_screws_nuts_washers.scad>
include <../basic_scad/params_radial_bearings_housing.scad>
include <../basic_scad/params_sensor_array.scad>
include <../basic_scad/params_webcam.scad>
include <../basic_scad/params_potentiometers.scad>

use <../basic_scad/pulleys.scad>
use <../basic_scad/radial_bearing_housing.scad>
use <../basic_scad/spacer.scad>
use <../basic_scad/potentiometer_support.scad>
use <../basic_scad/screws_nuts_washers.scad>
use <../basic_scad/radial_bearing_housing.scad>
use <../basic_scad/radial_bearings.scad>
use <../basic_scad/stepper_motors.scad>
use <../basic_scad/webcam.scad>
use <../basic_scad/ultrasonic_support.scad>
use <../basic_scad/ultrasonic.scad>
use <../basic_scad/basic_components.scad>


use <potentiometer_gears.scad>
use <../basic_scad/potentiometers.scad>

include <params_head.scad>

//----------------------------------------------------------
module motor_support()
{
    inaltime = 7;
    difference(){
        union(){
     rotate ([0, 0, 180]) cylinder (h = 7, r = 30);
 // motor support
          translate ([35 / 2, 30 - 5.8, inaltime]) mirror ([0, 0, 1]) rotate([0, 0, 90]) 
           
            difference(){
            color(plastic_color) potentiometer_support(50, 35, inaltime, 36, 0, 3, 0);
                // nema 11 middle hole
        translate ([36, 35 / 2, 0] + gearbox_nema_11_holes_position[0] - display_tolerance_z) cylinder (h = head_base_sizes2[2] + 2 + 2 * display_tolerance, r = nema_11_motor_gearbox_hole_radius, $fn = 50);
                // nema 11 screw hole
        for (i=[1:4])
         translate ([36, 35 / 2, 0] - display_tolerance_z) rotate ([0, 0, 0]) translate (gearbox_nema_11_holes_position[i]) cylinder (h = head_base_sizes2[2] + 2 + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);

// belt tensioner
        hull(){
        translate ([14, 35/2 - 8, 0] + gearbox_nema_11_holes_position[0] - display_tolerance_z) cylinder (h = head_base_sizes2[2] + 2 + 2 * display_tolerance, r = 2, $fn = 50);
        translate ([14, 35/2 + 8, 0] + gearbox_nema_11_holes_position[0] - display_tolerance_z) cylinder (h = head_base_sizes2[2] + 2 + 2 * display_tolerance, r = 2, $fn = 50);
        }
        }
    }
    }
           
}
//----------------------------------------------------------
module bearing_housing_on_axis()
{
    // bearing housing
    rbearing_608_housing_double();
    // axis support
    translate([-rbearing_608_housing_size[0] / 2, rbearing_608_housing_size[0] / 2 - 2, 0])rectangular_axis_slider(rbearing_608_housing_size[0], 3);
    // potentiometer support
    translate ([rbearing_608_housing_size[0] / 2 - 2, -14, 0]) 
    //rotate ([0, 0, 180]) 
    potentiometer_support(27, 28, 5, 10, 5, 3, 0);
}
//---------------------------------------------------------------------------
module bearing_housing_with_breadboard_support()
{
    length = 45;
    dist_between_screws = 36;
  
  // bearing housing  
  rbearing_608_housing_double();
    
    // electronics support
    translate ([rbearing_608_housing_size[0] / 2 + 1, -length / 2, 0]) 
    rotate ([0, -90, 0])
  difference(){      
      my_cube_rounded(rbearing_608_housing_size[2] + rb_608_thick, length, 3);
      // holes for screws
      translate ([4, (length - dist_between_screws) / 2, 0] - display_tolerance_z) cylinder (h = 3 + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);

      translate ([4 , length - (length - dist_between_screws) / 2, 0] - display_tolerance_z) cylinder (h = 3 + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);
  }
  
  // potentiometer support
  translate ([-rbearing_608_housing_size[0] / 2 + 2, 14, 0]) rotate ([0, 0, 180]) potentiometer_support(27, 28, 5, 10, 5, 3, 0);
}
//---------------------------------------------------------------------------
module bearing_housing_with_breadboard_support_and_potentiometer()
{
    // plastic part
    bearing_housing_with_breadboard_support();
    // potentiometer
    translate ([-rbearing_608_housing_size[1] / 2 - pot_92R1A_J22_L15L_base_length / 2, 0, pot_92R1A_J22_L15L_base_height + 2]) mirror([0, 0, 1]) potentiometer_92R1A_J22_L15L();
    // gear for potentiometer
    translate ([-rbearing_608_housing_size[1] / 2 - pot_92R1A_J22_L15L_base_length / 2, 0, -pot_92R1A_J22_L15L_base_height - 2]) pot_gear(num_teeth = 12, screw_angle = 10, height = 8);
}
//---------------------------------------------------------------------------
module head_base()
{
  motor_support();
    
  color(plastic_color) translate ([30, -37 / 2, 7]) rotate ([0, 90, 0]) spacer_with_1_hole(7, 37, 10);
    difference(){
        translate ([23, -37 / 2, 0]) cube([10, 37, 7]);
        cylinder (h = 7, r = 30);
    }
  color(plastic_color) translate ([-30 - 10, -37 / 2, 7]) rotate ([0, 90, 0]) spacer_with_1_hole(7, 37, 10);
    difference(){
  translate ([-30, -37 / 2, 0]) cube([7, 37, 7]);  
        cylinder (h = 7, r = 30);
    }
}
//---------------------------------------------------------------------------
module nema_11_with_gearbox_and_pulley()
{
    nema_11_with_13_1_gearbox();
    translate ([0, 0, nema_11_with_13_1_gearbox_height + 12]) pulley_with_shaft(57, 12, 0, 0, 8, 3, 0, 0);
}
//---------------------------------------------------------------------------
module hc_sr04_and_c920_with_support()
{
    // plastic support
    hc_sr04_and_c920_support();
    // ultrasonic sensor
    translate ([1, -3, 8]) hc_sr04();
    // c920 camera
    translate ([c920_length - c920_length / 2 + c920_dist_between_holder_holes / 2 - c920_depth / 2 + 2, -c920_height - 7, c920_depth]) mirror ([1, 0, 0]) rotate ([-90, 0, 0]) c920();
}
//---------------------------------------------------------------------------
module eye_support()
{
    motor_support();
    translate ([0, 60, -52]) nema_11_with_gearbox_and_pulley();
    translate ([0, 0, 25]) mirror ([0, 0, 1]) pulley_with_shaft(60, 33, 0, 0, 8, 4, m8_nut_radius, m8_nut_height);
    
    mirror ([0, 0, 1]) bearing_housing_on_axis();
    translate ([0, 0, -rb_608_thick]) 608rs();
    translate ([0, 0, -2 * rb_608_thick]) 608rs();
    // long screw
    cylinder (h = 100, r = 4, $fn = 30, center = true);
    // bones
    color(aluminium_color) translate ([0, 0, 25]) cube_empty(6, 10, 100);
    color(aluminium_color) translate ([0, 0, -114]) cube_empty(6, 10, 100);
    // cameras
    
    // ultrasonic
    translate ([-7, -32, 36]) rotate ([0, 90, -90]) hc_sr04_and_c920_with_support();
    
}
//---------------------------------------------------------------------------
module head()
{
    mirror ([0, 0, 1]) head_base();
    translate ([0, 0, -25]) pulley_with_shaft(60, 33, 0, 0, 8, 4, m8_nut_radius, m8_nut_height);
    translate ([0, 0, -25]) M8x80_hexa();
    
    translate ([0, 0, 16]) rotate([0, 0, 90]) mirror([0, 0, 1]) bearing_housing_with_breadboard_support_and_potentiometer();
    
    translate ([0, 0, 0]) 608rs();
    translate ([0, 0, rb_608_thick]) 608rs();
    translate ([0, 0, 2 * rb_608_thick]) M8_autolock_nut();
    
    translate ([0, 0, 2 * rb_608_thick + m8_autolock_nut_thick]) bone_gear(num_teeth = 12, screw_angle = 10, height = 10);// 2x cot, inainte de cot

    // vertical bone
    color(aluminium_color) translate ([0, 0, 2 * rb_608_thick + m8_autolock_nut_thick]) cube_empty(6, 10, 120);
    // motor
    translate ([0, 60, 52]) mirror ([0, 0, 1]) nema_11_with_gearbox_and_pulley();
    // eye support
    translate ([8, -20, 128]) rotate ([0, 90, 0]) eye_support();
}
//---------------------------------------------------------------------------

head();

//pot_gear(num_teeth = 12, screw_angle = 14, height = 8);

//qtr_a1_support(7);
//hc_sr04_and_c920_with_support();


//bearing_housing_with_breadboard_support_and_potentiometer();

//eye_support();

//gradient_support();

//head_base();

//bearing_housing_on_axis();

//bearing_housing_with_breadboard_support();
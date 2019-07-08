// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------



use <../../basic_scad/basic_components.scad>
include <../../basic_scad/material_colors.scad>
include <../../basic_scad/params_stepper_motors.scad>
include <../../basic_scad/params_radial_bearings.scad>
include <../../basic_scad/params_basic_components.scad>
include <../../basic_scad/params_screws_nuts_washers.scad>
include <../../basic_scad/params_radial_bearings_housing.scad>
include <../../basic_scad/params_sensor_array.scad>
include <../../basic_scad/params_webcam.scad>

use <../../basic_scad/pulleys.scad>
use <../../basic_scad/radial_bearing_housing.scad>
use <../../basic_scad/spacer.scad>
use <../../basic_scad/screws_nuts_washers.scad>
use <../../basic_scad/radial_bearing_housing.scad>
use <../../basic_scad/radial_bearings.scad>
use <../../basic_scad/stepper_motors.scad>
use <../../basic_scad/webcam.scad>
use <../../basic_scad/ultrasonic_support.scad>
use <../../basic_scad/ultrasonic.scad>
use <../../basic_scad/basic_components.scad>


include <head_params.scad>
include <../../basic_scad/params_alu_profiles.scad>
include <../../basic_scad/tolerance.scad>

//----------------------------------------------------------
module head_motor_support()
{
    difference(){
        union(){
            rotate ([0, 0, 180]) color (plastic_color)  cylinder (h = head_motor_support_height, r = 30);
 // motor support
            translate ([35 / 2, 30 - 5.8, head_motor_support_height]) mirror ([0, 0, 1]) rotate([0, 0, 90]) 
            difference(){
                color(plastic_color) potentiometer_support(50, 35, head_motor_support_height, 36, 0, 3, 0);
                // nema 11 middle hole
                translate ([36, 35 / 2, 0] + gearbox_nema_11_holes_position[0] - display_tolerance_z) cylinder (h = head_base_sizes2[2] + 2 + 2 * display_tolerance, r = nema_11_motor_gearbox_hole_radius, $fn = 50);
                // nema 11 screw hole
                for (i = [1 : 4])
                    translate ([36, 35 / 2, 0] - display_tolerance_z) rotate ([0, 0, 0]) translate (gearbox_nema_11_holes_position[i]) cylinder (h = head_base_sizes2[2] + 2 + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);

// belt tensioner
                hull(){
                    translate ([14, 35/2 - 8, 0] + gearbox_nema_11_holes_position[0] - display_tolerance_z) cylinder (h = head_base_sizes2[2] + 2 + 2 * display_tolerance, r = 2, $fn = 50);
                    translate ([14, 35/2 + 8, 0] + gearbox_nema_11_holes_position[0] - display_tolerance_z) cylinder (h = head_base_sizes2[2] + 2 + 2 * display_tolerance, r = 2, $fn = 50);
                }
            }
        }
        // shaft hole
        translate (-display_tolerance_z) cylinder(h = head_motor_support_height + 2 * display_tolerance, r = rb_6001_external_radius - 2);
        // holes for fixing the bearing support
        for (i = [1 : 4])
            translate (rbearing_6001_housing_holes_position[i]-display_tolerance_z) cylinder(h = head_motor_support_height + 2 * display_tolerance, r = 2, $fn = 10);
    }       
}
//----------------------------------------------------------
module bearing_housing_on_axis()
{
    // bearing housing
    rbearing_6001_double_housing();
    // axis support
    translate([rbearing_6001_housing_size[0] / 2, rbearing_6001_housing_size[0] / 2 - 2, 0]) color (plastic_color)
    rotate([0, -90, 0])
    rectangular_tube_with_rounded_hole_and_screw_fixers(length = rbearing_6001_housing_size[2] + rb_6001_thick, width = rbearing_6001_housing_size[2] + rb_6001_thick, hole_radius = 6, height = rbearing_6001_housing_size[0] + 10);
    // potentiometer support
    translate ([rbearing_6001_housing_size[0] / 2 - 2, -rbearing_6001_housing_size[0] / 2, 0])
    color (plastic_color) potentiometer_support(27, rbearing_6001_housing_size[0], 8, 10, 8, 3, 0);
}
//---------------------------------------------------------------------------
module bearing_housing_with_breadboard_support()
{
    length = 80;
    dist_between_screws = 72;
  
  // bearing housing  
  rbearing_6001_double_housing();
    
    // electronics support
    translate ([rbearing_6001_housing_size[0] / 2 + 2, -length / 2, 0]) 
    rotate ([0, -90, 0])
  difference(){      
      color (plastic_color) my_cube_rounded(rbearing_6001_housing_size[2] + rb_6001_thick, length, 4);
      // holes for screws
      translate ([4, (length - dist_between_screws) / 2, 0] - display_tolerance_z) cylinder (h = 3 + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);

      translate ([4 , length - (length - dist_between_screws) / 2, 0] - display_tolerance_z) cylinder (h = 3 + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);
  }
  
  // potentiometer support
  translate ([-rbearing_6001_housing_size[0] / 2 + 2, 14, 0]) rotate ([0, 0, 180]) potentiometer_support(27, 28, 5, 10, 5, 3, 0);
}
//---------------------------------------------------------------------------
module bearing_housing_with_breadboard_support_and_potentiometer()
{
    // plastic part
    bearing_housing_with_breadboard_support();
    // potentiometer
    translate ([-rbearing_6001_housing_size[1] / 2 - pot_92R1A_J22_L15L_base_length / 2 - 1, 0, pot_92R1A_J22_L15L_base_height + 2]) mirror([0, 0, 1]) potentiometer_92R1A_J22_L15L();
    // gear for potentiometer
    translate ([-rbearing_6001_housing_size[1] / 2 - pot_92R1A_J22_L15L_base_length / 2, 0, -pot_92R1A_J22_L15L_base_height - 2]) pot_gear(num_teeth = 12, screw_angle = 10, height = 8);
}
//---------------------------------------------------------------------------
module head_base()
{
  head_motor_support();
    
  color(plastic_color) translate ([30, -37 / 2, head_motor_support_height]) rotate ([0, 90, 0]) spacer_with_1_hole([head_motor_support_height, 37, 10]);
  difference(){
        translate ([23, -37 / 2, 0]) cube([10, 37, head_motor_support_height]);
        color (plastic_color) cylinder (h = head_motor_support_height, r = 30);
  }
  color(plastic_color) translate ([-30 - 10, -37 / 2, head_motor_support_height]) rotate ([0, 90, 0]) spacer_with_1_hole([head_motor_support_height, 37, 10]);
  difference(){
        translate ([-30, -37 / 2, 0]) color (plastic_color) cube([head_motor_support_height, 37, head_motor_support_height]);  
        cylinder (h = head_motor_support_height, r = 30);
  }
}
//---------------------------------------------------------------------------
module nema_11_with_gearbox_and_pulley()
{
    nema_11_with_27_1_gearbox();
    translate ([0, 0, nema_11_with_27_1_gearbox_height + 3]) pulley_with_shaft("T5mm_pulley", 12, 0, 0, 8, 3, 0, 0);
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
module head_traction_pulley()
{
    difference(){
        rotate ([0, 0, 2.8]) pulley(profile = "T5mm_pulley", num_teeth = 33, pulley_b_ht = 0, pulley_b_dia = 0, pulley_t_ht = 8);
        
        translate(- display_tolerance_z) cylinder(h = 11 + 2 * display_tolerance, r = 6, $fn = 30);
        
        // screw hole
        translate ([-30, 0, 5.5]) rotate ([0, 90, 0]) cylinder(h = 60, r = m4_screw_radius, $fn = 20);
        // nut hole
        hull(){
            translate ([9, 0, 5.5]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
            translate ([9, 0, 11]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
        }
        // nut hole
        hull(){
            translate ([-9 - m4_nut_thick, 0, 5.5]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
            translate ([-9 - m4_nut_thick, 0, 11]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
        }
        
        translate([0, -15, 0]- display_tolerance_z) cylinder(h = 11 + 2 * display_tolerance, r = 2, $fn = 30);
    }
}
//---------------------------------------------------------------------------
module eye_support()
{
    head_motor_support();
    translate ([0, 60, -(nema_11_with_27_1_gearbox_height - head_motor_support_height + 2)]) nema_11_with_gearbox_and_pulley();
    translate ([0, 0, 13]) head_traction_pulley();
    
    translate ([0, 0, -(rbearing_6001_housing_size[2] + rb_6001_thick)]) bearing_housing_on_axis();
    translate ([0, 0, -rb_6001_thick]) 6001rs();
    translate ([0, 0, -2 * rb_6001_thick]) 6001rs();
    // long screw
    color ("black") cylinder (h = 200, r = 6, $fn = 30, center = true);
    // cameras
    
    // ultrasonic
    translate ([-10, -34, 36]) rotate ([0, 90, -90]) hc_sr04_and_c920_with_support();
}
//---------------------------------------------------------------------------
module neck_base()
{
    rotate ([0, 90, 0]) spacer_with_1_hole(head_support_size);
    translate ([-69, 0, 0]) rotate ([0, 90, 0]) spacer_with_1_hole(head_support_size);
    
    translate ([-69, 0, -20]) 
mirror([0, 0, 1])    
    difference(){
            color (plastic_color) cube([80, 37, 10]);
            // 6001 bearing hole support
            translate ([40, 37/2, 0] - display_tolerance_z) cylinder(h = 10 + 2 * display_tolerance, r = rb_6001_external_radius - 1);
            // 6001 bearing hole
            translate ([40, 37/2, 0] - display_tolerance_z) cylinder(h = rb_6001_thick + display_tolerance, r = rb_6001_external_radius);
            
            // screw hole
            translate ([5.5, 37/2, 0] - display_tolerance_z) cylinder(h = 10 + 2 * display_tolerance, r = 2);
            translate ([80 - 5.5, 37/2, 0] - display_tolerance_z) cylinder(h = 10 + 2 * display_tolerance, r = 2);
        }
}
//---------------------------------------------------------------------------
module head_bone_gear()
{
    bone_gear(num_teeth = 13, screw_angle = 14);
}
//---------------------------------------------------------------------------
module head()
{
    mirror ([0, 0, 1]) head_base();
    translate ([0, 0, -25]) head_traction_pulley();
    
    translate ([0, 0, rbearing_6001_housing_size[2] + rb_6001_thick]) rotate([0, 0, 90]) mirror([0, 0, 1]) bearing_housing_with_breadboard_support_and_potentiometer();
    
    translate ([0, 0, 0]) 6001rs();
    translate ([0, 0, rb_6001_thick]) 6001rs();
    
    color (plastic_color)
    translate ([0, 0, rbearing_6001_housing_size[2] + rb_6001_thick + 6]) head_bone_gear();

    // vertical bone
    color("black") translate ([0, 0, -head_support_size[0] - head_motor_support_height]) cylinder(r = 6, h = 190, $fn = 20);
    // motor
    translate ([0, 60, nema_11_with_27_1_gearbox_height - head_motor_support_height + 2]) mirror ([0, 0, 1]) nema_11_with_gearbox_and_pulley();
    // eye support
    translate ([6, -23, 128]) rotate ([0, 90, 0]) eye_support();
    
    // electronics breadboard
    translate([-WBU_502_breadboard_size[0] / 2, rbearing_6001_housing_size[0] / 2 + WBU_502_breadboard_size[2] + 2, 0]) rotate ([90, 0, 0]) WBU_502_breadboard();
    
    // spacers for linking head with body
    translate ([29, (-L_profile_40x20_long_size + 3) / 2, -head_motor_support_height])  neck_base();
}
//---------------------------------------------------------------------------

head();

//head_traction_pulley(); // 2x

//head_motor_support(); // 1x

//head_base();

//pot_gear(num_teeth = 12, screw_angle = 14, height = 8); // 2x


//hc_sr04_and_c920_with_support();


//bearing_housing_with_breadboard_support_and_potentiometer();

//eye_support();



//mirror ([0, 0, 1]) neck_base();

//bearing_housing_on_axis();

//bearing_housing_with_breadboard_support();

//head_bone_gear(); // 2x

//hc_sr04_and_c920_support_plate(); // 1x
//hc_sr04_arm(); // 1x
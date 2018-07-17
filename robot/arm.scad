// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------


include <params_arm.scad>

include <../basic_scad/params_basic_components.scad>
use <../basic_scad/basic_components.scad>
use <../basic_scad/stepper_motors.scad>
include <../basic_scad/params_screws_nuts_washers.scad>
use <../basic_scad/screws_nuts_washers.scad>
use <../basic_scad/radial_bearing_housing.scad>
include <../basic_scad/config.scad>
use <../basic_scad/point_transformations_3d.scad>

include <../basic_scad/params_pulleys.scad>
use <../basic_scad/pulleys.scad>
use <../basic_scad/radial_bearings.scad>

include <params_gripper.scad>
use <gripper.scad>
use <../basic_scad/belt.scad>

include <../basic_scad/params_webcam.scad>

use <../basic_scad/tube_bracket.scad>
include <../basic_scad/params_tube_bracket.scad>

use <motor_pulley.scad>
use <arm_pulleys.scad>
use <arm_motor_housings.scad>

//use <../basic_scad/stepper_motor_sheets.scad>
include <../basic_scad/params_stepper_motor_gearbox.scad>

include <../basic_scad/tolerance.scad>
include <params_body.scad>

use <arm_sheets.scad>

use <arm_potentiometer_support.scad>

include <../basic_scad/params_motor_housing.scad>

use <../basic_scad/stepper_motor_sheets.scad>

use <../basic_scad/potentiometers.scad>
include <../basic_scad/params_potentiometers.scad>

use <../basic_scad/as5147.scad>


//---------------------------------------------------------------------------
module rbearing_608_housing_thicker(extra_thick = 0)
{
radial_bearing_housing(rbearing_608_housing_size, rbearing_608_housing_holes_position, rb_608_external_radius, rb_608_thick, rbearing_608_housing_size[2] + extra_thick, m4_screw_radius);
}
//---------------------------------------------------------------------------
module upper_arm_motor_with_components()
{
    nema_17_with_19_1_gearbox();
    
    // screw for rotation
    translate([0, - distance_upper_arm_motor_shaft, nema_17_with_19_1_gearbox_height + 11 + 3 + 2]) mirror ([0, 0, 1]) M8_hexa (nema_17_with_19_1_gearbox_height + 20); 
    
    // base sheet
    translate ([-sheet_upper_arm_motor_base_size[0] / 2, -sheet_upper_arm_motor_base_size[1] + nema_17_width / 2, -sheet_upper_arm_motor_base_size[2]]) sheet_upper_arm_motor_base();
    
    // top sheet
    translate ([-sheet_upper_arm_motor_top_size[0] / 2, -sheet_upper_arm_motor_top_size[1] + nema_17_width / 2, nema_17_with_19_1_gearbox_height]) sheet_upper_arm_motor_top();
    
    //screw pulley
    translate ([0, -distance_upper_arm_motor_shaft, nema_17_with_19_1_gearbox_height + 5 + 11]) mirror([0, 0, 1])
    upper_arm_screw_rotation_pulley();
  
  // shaft pulley at motor 
    translate ([0, 0, nema_17_with_19_1_gearbox_height + 5]) upper_arm_motor_pulley();
    
// belt
    rotate ([0, 0, -90])
    translate ([0, 0, nema_17_with_19_1_gearbox_height + 7]) belt_on_2_pulleys(11.6, 11.6, distance_upper_arm_motor_shaft, 6);
// belt length    
    //echo (length_belt_on_2_pulleys(r1 = 14, r2 = 14, distance_between_pulleys = distance_upper_arm_motor_shaft));

    translate ([0, -distance_upper_arm_motor_shaft, nema_17_with_19_1_gearbox_height / 2 - 3])
    pulley(profile = "HTD_5mm_pulley", num_teeth = 13, pulley_b_ht = 0, pulley_b_dia = 17, pulley_t_ht = 9);
    
    // bearing housing
// base
    translate ([0, -distance_upper_arm_motor_shaft, rbearing_608_housing_size[2] + 6]) mirror([0, 0, 1]) rbearing_608_housing_thicker(6);
    // top
    translate ([0, -distance_upper_arm_motor_shaft, nema_17_with_19_1_gearbox_height - rbearing_608_housing_size[2] - 6]) rbearing_608_housing_thicker(6);
}
//---------------------------------------------------------------------------
module foreram_motor()
{
    nema_11_with_27_1_gearbox();
}
//---------------------------------------------------------------------------
module elbow_pulley_with_components()
{
    // pulley 
    elbow_pulley();
    
    // belt tensioner bearings
   // translate ([distance_to_fore_arm_gear - 3, -belt_hole_forearm_pulley / 2 - 2, 3]) rotate ([0, 90, 0]) {
    //    translate ([12, belt_hole_forearm_pulley / 2 + wall_thick_lateral_motor_housing - 15, -5]) belt_tensioner_slider();
    //    translate ([12, belt_hole_forearm_pulley / 2 + wall_thick_lateral_motor_housing + 15, -5]) belt_tensioner_slider();
   // }
    
    // M6 screw
    translate([0, 0, 11 / 2.0 + upper_arm_shaft_radius + 3]) mirror([0, 0, 1]) M6_hexa_screw(35);
    // bearing
    translate ([0, 0, elbow_pulley_thick / 2 - rb_626_thick - 3]) 626rs();
    //bearing
    translate([0, 0, elbow_pulley_thick / 2 + 3]) 626rs();
    // nut
    translate([0, 0, - upper_arm_shaft_radius]) M6_autolock_nut();
    for (i = [0 : 1]){ // 2 washers on both sizes
      translate([0, 0, 2 * rb_626_thick + i * washer_6_thick]) washer_6_12();
      translate([0, 0, -(i + 1) * washer_6_thick]) washer_6_12();
    }
    
    
    // potentiometer support
    //translate ([54.5, 24, 0]) rotate ([0, 90, 180]) forearm_potentiometer_support();
    
    // potentiometer
    //translate ([55 - 7 - 2 - 5, 0, -10]) rotate ([0, 90, 0]) potentiometer_BOURNS_3852A_282_103AL();
    
        // bearing housing
    //translate ([fore_arm_x_offset, 0, 0]) 
        //rotate ([0, 0, 90]) {
           // translate ([0, 0, pulley_T5_6mm_thick])rbearing_6905_vertical_double_housing_bounded_half_small_extra_height(fore_arm_z_offset);
        //    mirror([0, 0, 1])
      //          translate ([0, 0, -(pulley_T5_6mm_thick + f_rbearing_6905_vertical_double_housing_size_bounded_half_small(fore_arm_z_offset)[2] + f_rbearing_6905_vertical_double_housing_size_bounded_half_small(0)[2])]) rbearing_6905_vertical_double_housing_bounded_half_small_extra_height(0);
    //}
    ;
}
//---------------------------------------------------------------------------
module forearm_bone()
{
    color ("black") cylinder_empty(fore_arm_length, forearm_shaft_radius, forearm_shaft_radius - 2);
}
//---------------------------------------------------------------------------
module forearm_bearing_support()
{
    translate ([-21 - (2 * m4_screw_radius + 2 * wall_thick_2), -25, -2]) cube([68, 50, 13]);
}
//---------------------------------------------------------------------------
module fore_arm()
{
// shaft
    forearm_bone();
    // pulley
    translate ([0, 0, 0]) forearm_pulley();
    
    // gripper stepper motor
   // translate([0, 0, -nema_14_39BYGL215A_height - gripper_motor_sheet_size[2]]) nema_14_39BYGL215A(290, -0 + 5);
    //rotate ([0, 0, 45]) translate([-gripper_motor_sheet_size[0] / 2, -gripper_motor_sheet_size[1] / 2, - gripper_motor_sheet_size[2]]) gripper_motor_sheet();

// 6905 bearing
    translate ([0, 0, forearm_pulley_thick + 2 + 2 + 5]) 6905rs();    
    
    translate ([0, 0, forearm_pulley_thick + 2 + 40 + 2 + 5]) 6905rs();
    // gripper
    translate([0, 0, fore_arm_length - gripper_motor_support_size[2]])
        rotate([0, 90, 0])
            translate ([-gripper_lateral_sheet_size[0], -gripper_lateral_sheet_size[1] / 2, -gripper_motor_support_size[0] / 2 - gripper_lateral_sheet_size[2]]) 
    //                        gripper()
    ;
    
// camera support
    translate ([-forearm_shaft_radius, c920_depth / 2 + c920_dist_between_holder_holes / 2, fore_arm_length - 24]) rotate([0, 0, -90])  gripper_c920_support_with_camera();
}
//---------------------------------------------------------------------------
module fore_arm_with_elbow_pulley()
{
  translate ([-45, forearm_shaft_radius + 38, 13 / 2])
   rotate([angle_fore_arm, 0, 0]) 
    rotate ([0, 90, 0]) 
        rotate([0, 0, 90]) 
            fore_arm()
    ;
    
    // support
  translate ([-45, forearm_shaft_radius + 38, 13 / 2])
    rotate ([0, 90, 0]) 
        rotate([0, 0, -90]) {
            translate ([0, 0, forearm_pulley_thick + 2 + 2 + 5]) forearm_bearing_support();
            translate ([0, 0, forearm_pulley_thick + 2 + 40 + 2 + 5]) forearm_bearing_support();
        }
        
    // stepper motor
  translate ([ nema_11_with_27_1_gearbox_height - 27, forearm_shaft_radius + 38 + 21 + 8 + nema_11_width / 2, 13 / 2]) 
    rotate ([0, -90, 0])
        foreram_motor();
    
    // motor pulley
    translate ([-27 - 13 - 5, forearm_shaft_radius + 38 + 21 + 8 + nema_11_width / 2, 13 / 2]) rotate ([0, 90, 0]) 
    motor_pulley_6mm_shaft();
    
    // belt
    translate ([-27 - 8, forearm_shaft_radius + 38 + 21 + 8 + nema_11_width / 2, 13 / 2]) 
        rotate ([90, 0, 0]) rotate ([0, -90, 0]) 
    belt_on_2_pulleys(9, 28, 43, 6);
        
    
    // elbow pulley
    elbow_pulley_with_components();
}
//---------------------------------------------------------------------------
module upper_arm_bone()
{
    difference(){
        color ("black") 
            cylinder(h = upper_arm_bone_length, r = upper_arm_shaft_radius);
        translate (-display_tolerance_z) cylinder(h = upper_arm_bone_length + 2 * display_tolerance, r = upper_arm_shaft_radius - 1);
        translate ([-upper_arm_shaft_radius, -upper_arm_bone_cleft_thick / 2, upper_arm_bone_length - upper_arm_bone_cleft_length]) cube([2 * upper_arm_shaft_radius, upper_arm_bone_cleft_thick, upper_arm_bone_cleft_length] + display_tolerance_z);
    }
}
//---------------------------------------------------------------------------
module tube_interior_cover(height)
{
    difference(){
        color (plastic_color) 
        cylinder(h = height, r = upper_arm_shaft_radius - 1);
        // cleft
        translate ([-upper_arm_shaft_radius, -upper_arm_bone_cleft_thick / 2, 0] - display_tolerance_z) cube([2 * upper_arm_shaft_radius, upper_arm_bone_cleft_thick, height + 2 * display_tolerance]);
        // screw hole
       translate ([0, -upper_arm_shaft_radius, height / 2]) rotate ([-90, 0, 0]) cylinder (h =  2 * upper_arm_shaft_radius, r = 3);
        // bearings hole
       translate ([0, 0, height / 2]) rotate ([-90, 0, 0]) translate ([0, 0, 3]) cylinder (h = rb_626_thick, r = rb_626_external_radius);
       translate ([0, 0, height / 2]) rotate ([-90, 0, 0]) translate ([0, 0, -3-rb_626_thick]) cylinder (h = rb_626_thick, r = rb_626_external_radius);
        
    }
}
//---------------------------------------------------------------------------
module upper_arm()
{
    // bone
   translate([0, upper_arm_bone_top_shift, 0]) rotate ([90, 0, 0]) upper_arm_bone();
    // support for elbow pulley bearings
    translate ([0, - upper_arm_bone_length + upper_arm_bone_top_shift + 2 * rb_626_external_radius , 0]) rotate ([90, 0, 0]) tube_interior_cover(2 * rb_626_external_radius);
         
    // pulley for left-right rotation
    translate ([0, 0, 0]) rotate([0, 90, 0]) rotate ([-90, 0, 0]) upper_arm_pulley(); 
    
    // stepper motor 
    translate ([0, rbearing_608_housing_size[0] / 2 + upper_arm_bone_top_shift + elbow_rotation_motor_offset, -nema_17_with_19_1_gearbox_height / 2]) 
    rotate([0, 0, 0])
    translate ([0, distance_upper_arm_motor_shaft, 0])
    upper_arm_motor_with_components()
    ;
    
    // forearm
    translate ([0, - upper_arm_bone_length + upper_arm_bone_top_shift + rb_626_external_radius, -elbow_pulley_thick / 2])  
        rotate([0, 0, angle_elbow]) 
               fore_arm_with_elbow_pulley()
    ;
    
    // belt
    translate ([0, rbearing_608_housing_size[0] / 2 + upper_arm_bone_top_shift, upper_arm_motor_housing_shift + elbow_pulley_thick / 2 + 3]) rotate([0, 0, -90]) belt_on_2_pulleys(10, 30, upper_arm_bone_length + rbearing_608_housing_size[0] / 2 - rb_626_external_radius, 6);
}
//---------------------------------------------------------------------------
module shoulder()
{
    //plate
    shoulder_plate();
    
    // motor
    translate ([shoulder_plate_size[0] / 2, shoulder_plate_size[1] - nema_17_with_19_1_gearbox_height - wall_thick_base_motor_housing - 3, -nema_17_width / 2 - 3 - shoulder_left_right_motor_offset - shoulder_left_right_belt_tensioner_offset]) 
        rotate ([-90, 0, 0]) 
            body_arm_motor_with_sheet();
    ;
// motor gear for forearm  rotation
    translate ([shoulder_plate_size[0] / 2, (shoulder_plate_size[1] + 17), -nema_17_width / 2 - 3 - shoulder_left_right_motor_offset - shoulder_left_right_belt_tensioner_offset]) 
    rotate ([90, 0, 0]) 
    motor_pulley_8mm_shaft()
    ;
    
    // motor housing
    translate ([shoulder_plate_size[0] / 2 + 43 / 2 + 2, shoulder_plate_size[1] , 0]) 
    mirror([0, 0, 1])
    rotate ([0, -90, 90])
    shoulder_left_right_motor_housing_with_belt_tensioner()
    ;
        
    
    // screws for fixing motor housing to alu sheet
    
      for (i = [[-1, -1], [-1, 1], [1, -1], [1, 1]]){
            translate ([shoulder_plate_size[0] / 2, shoulder_plate_size[1] - 18 - 3, -wall_thick_base_motor_housing]) translate([i[0] * 35 / 2, i[1] * 28 / 2, 0])  M4_sunken(8);
            translate ([shoulder_plate_size[0] / 2, shoulder_plate_size[1] - 18 - 3, shoulder_plate_size[2]]) translate([i[0] * 35 / 2, i[1] * 28 / 2, 0])  rotate ([0, 0, 30]) M4_autolock_nut();
          
      }    
    // bone support 1
    translate ([shoulder_plate_size[0] / 2, first_bearing_shoulder_offset + rbearing_6906_enclosed_housing_size[1] / 2, shoulder_plate_size[2] + rbearing_6906_enclosed_housing_size[2]])
      mirror([0, 0, 1])
        radial_bearing_6906_vertical_housing()
        ;      
        // potentiometer
        translate ([42 / 2 + shoulder_plate_size[0] / 2, 0, 0]) rotate([0, 90, 90]) shoulder_potentiometer_support();
        
// bearing 1        
    translate ([shoulder_plate_size[0] / 2, rbearing_6906_enclosed_housing_size[1] / 2 + rb_6906_thick / 2 + first_bearing_shoulder_offset, shoulder_plate_size[2] + rb_6906_external_radius])
rotate([90, 0, 0])
        6906rs();
    
    // bone support 2
    translate ([shoulder_plate_size[0] / 2, shoulder_plate_size[1] - rbearing_6906_enclosed_housing_size[1] / 2, shoulder_plate_size[2] + rbearing_6906_enclosed_housing_size[2]])
      mirror([0, 0, 1])
        radial_bearing_6906_vertical_housing();
        
        // bearing 2
    translate ([shoulder_plate_size[0] / 2, -rbearing_6906_enclosed_housing_size[1] / 2 + rb_6906_thick / 2 + shoulder_plate_size[1], shoulder_plate_size[2] + rb_6906_external_radius])
rotate([90, 0, 0])
        6906rs();
        
    // continuation with upper arm
    translate ([shoulder_plate_size[0]/ 2, shoulder_plate_size[1] + 3, rb_6906_external_radius + shoulder_plate_size[2]]) rotate ([0, angle_upper_arm, 0]) 
    upper_arm()
    ; 
    
// brackets for shoulder shaft
    translate ([(shoulder_plate_size[0] - ceil(nema_17_width)) / 2 - shoulder_bracket_length, 0, -f_bracket_height_strong(shoulder_shaft_radius)]) tube_bracket_long_one_hole(bracket_length = shoulder_bracket_length, tube_radius = shoulder_shaft_radius);
    translate ([shoulder_plate_size[0] - (shoulder_plate_size[0] - ceil(nema_17_width)) / 2, 0, -f_bracket_height_strong(shoulder_shaft_radius)]) tube_bracket_long_one_hole(bracket_length = shoulder_bracket_length, tube_radius = shoulder_shaft_radius);
}
//---------------------------------------------------------------------------
module pot_gear_with_screw_hole_14t()
{
    _height = 8;
    
    _internal_radius = 3.3;
    
    difference(){
        rotate([0, 0, 13])
            pot_gear(num_teeth = 14, internal_radius = _internal_radius, height = _height); 
            
          // m3 screw hole
        translate ([0, 0, _height / 2]) rotate([0, 90, 0]) cylinder (h = 22, r = 1.4, $fn = 30);  
          // m3 nut hole
        hull(){
            translate ([_internal_radius + 2, 0, 0]) rotate([0, 90, 0]) cylinder (h = 2.5, r = m3_nut_radius, $fn = 6);  
            translate ([_internal_radius + 2, 0, _height]) rotate([0, 90, 0]) cylinder (h = 2.5, r = m3_nut_radius, $fn = 6);  
        }
    }
}
//---------------------------------------------------------------------------
module body_arm_motor_with_sheet()
{
    nema_17_with_19_1_gearbox();
    
    translate ([0, 0, nema_17_with_19_1_gearbox_height]) 
        stepper_gearbox_motor_alu_sheet(nema_17_gearbox_alu_sheet_size, gearbox_nema_17_holes_position, nema17_gearbox_tensioner_sheet_screw_hole_position, nema_17_gearbox_motor_hole_radius);
    
    // screws
    for (i = [1: 4])
        translate(nema17_gearbox_tensioner_sheet_screw_hole_position[i] + [0, 0, nema_17_with_19_1_gearbox_height]){
            translate([0, 0, -m4_nut_thick]) M4_hexa(12);
            translate([0, 0, 6]) washer_4_12();
        }
    
}
//---------------------------------------------------------------------------
module rbearing_6905_vertical_housing_bounded_half_small_bottom()
{
    difference(){
        rbearing_6905_vertical_housing_bounded_half_small_extra_height(extra_height_arm_bearing);
    }
}
//---------------------------------------------------------------------------
module body_articulation()
{
    // plate
    
    plate_body_articulation();
    // motor
    translate ([plate_body_size[0] / 2, -nema_17_with_19_1_gearbox_height + plate_body_size[1] - wall_thick_motor_housing - nema_17_gearbox_alu_sheet_size[2], -nema_17_width / 2 - wall_thick_base_motor_housing - 4 - 19]) rotate ([-90, 0, 0]) body_arm_motor_with_sheet();
    
    // motor gear
    translate ([plate_body_size[0] / 2, plate_body_size[1] + 4, -nema_17_width / 2 - wall_thick_base_motor_housing - 3 - 20]) rotate ([-90, 0, 0]) motor_pulley_8mm_shaft();

// motor housing
    translate ([plate_body_size[0] / 2 - 41 / 2 - 2, plate_body_size[1]]) 
      rotate ([90, 0, 0]) 
        rotate ([0, 0, -90])
          body_stepper_motor_housing_with_belt_tensioner()
    ;
    
    
    // screws for fixing motor housing to alu sheet
    
      for (i = [[-1, -1], [-1, 1], [1, -1], [1, 1]]){
            translate ([plate_body_size[0] / 2, plate_body_size[1] - 18 - 3, -wall_thick_base_motor_housing]) translate([i[0] * 33 / 2, i[1] * 28 / 2, 0])  M4_sunken(8);
            translate ([plate_body_size[0] / 2, plate_body_size[1] - 18 - 3, plate_body_size[2]]) translate([i[0] * 33 / 2, i[1] * 28 / 2, 0])  rotate ([0, 0, 30]) M4_autolock_nut();
          
      }
    
  translate ([plate_body_size[0] / 2, plate_body_size[1], plate_body_size[2] + 3])
    rotate([-90, 0, 0])  
        potentiometer_support_motor1();
    
    //support upper arm
    // first bearing housing
    
   translate ([plate_body_size[0] / 2, rbearing_6905_vertical_housing_size_bounded_half_small_bottom[1] / 2, rbearing_6905_enclosed_housing_size[2] + plate_body_size[2]])  
   mirror ([0, 0, 1]) 
    radial_bearing_6905_vertical_housing();
    ;
    
    // bearing
    translate ([plate_body_size[0] / 2, +rbearing_6905_vertical_housing_size_bounded_half_small_bottom[1] / 2 + rb_6905_thick / 2, plate_body_size[2] + rb_6905_external_radius])
        rotate([90, 0, 0]) 6905rs();
    
// second bearing housing
    
   translate ([plate_body_size[0] / 2, plate_body_size[1] - rbearing_6905_vertical_housing_size_bounded_half_small_bottom[1] / 2, rbearing_6905_enclosed_housing_size[2] + plate_body_size[2]])  
   mirror ([0, 0, 1]) 
    radial_bearing_6905_vertical_housing();

    // bearing
    translate ([plate_body_size[0] / 2, plate_body_size[1]  - rbearing_6905_vertical_housing_size_bounded_half_small_bottom[1] / 2 + rb_6905_thick / 2, plate_body_size[2] + rb_6905_external_radius])
        rotate([90, 0, 0]) 6905rs();
    
    // shaft
    translate ([plate_body_size[0] / 2, plate_body_size[1] + pulley_HTD_5m_thick + 2, rb_6905_external_radius + plate_body_size[2]]) 
      rotate ([0, angle_shoulder, 0]) 
        rotate ([90, 0, 0]) 
            color ("black") 
              cylinder_empty(upper_arm_shaft_support_length, shoulder_shaft_radius, shoulder_shaft_radius - 1.5)
              ;
    // magnet holder
     translate ([plate_body_size[0] / 2, plate_body_size[1] + pulley_HTD_5m_thick + 2 - 10, rb_6905_external_radius + plate_body_size[2]]) 
      rotate ([0, angle_shoulder, 0]) 
        rotate ([-90, 0, 0]) 
            magnet_holder2_with_magnet(holder_height = 10, magnet_radius = 4, magnet_thick = 2.5, tube_internal_radius = 11,  tower_height = 10, tower_external_radius = 6)
            ;
    
    // pulley 
    translate ([plate_body_size[0] / 2, plate_body_size[1] + pulley_T5_6mm_thick + 4, rb_6905_external_radius + plate_body_size[2]])
      rotate ([90, 0, 0])
        rotate ([0, 0, -angle_shoulder])
          shoulder_traction_pulley();

    // upper arm
    translate ([0, -upper_arm_shaft_support_length + plate_body_size[1] + pulley_T5_6mm_thick + 4, rb_6905_external_radius])
      rotate ([0, angle_shoulder, 0])
        translate([offset_shoulder_plate_bracket, 0, body_shaft_radius + plate_body_size[2]])
          rotate ([0, 0, 90])
          shoulder() 
            ;
}
//---------------------------------------------------------------------------
module arm()
{    
    body_articulation();
}
//---------------------------------------------------------------------------
//arm();

body_articulation();

//shoulder();
//upper_arm();
//forearm_bearing_support();

//fore_arm_with_elbow_pulley();

//upper_arm_bone();

//fore_arm();

//potentiometer_support_shoulder_vertical();

//motor_pulley_8mm_shaft(); //6x

//upper_arm_motor_with_components();

//nema_17_housing_with_belt_tensioner_bearing_based_x_and_base_holes(20, 5);

//nema_11_housing_with_belt_tensioner_bearing_based_x_and_base_holes(15, 0);

//forearm_pulley();
//motor_pulley_6mm_shaft(); // 2x

//fore_arm_with_elbow_pulley();

//forearm_motor_housing();

//elbow_pulley();

//elbow_pulley_with_components();

//upper_arm_pulley();
//upper_arm_motor_housing();


//plate_body_articulation();

//shoulder_plate();

//forearm_potentiometer_support();

//elbow_gear();

//radial_bearing_6905_vertical_housing_slim_double();

//rbearing_6905_vertical_housing_bounded_half_small();
//rbearing_6905_vertical_housing_bounded_half_small_top();

//body_arm_motor_with_sheet();

//body_stepper_motor_housing();

//body_stepper_motor_housing_with_belt_tensioner();

//pot_gear_with_screw_hole_14t();

//shoulder_traction_pulley(); // 1x

//elbow_potentiometer_support();

//gripper_c920_support_with_camera();

//body_arm_traction_pulley();

//radial_bearing_6905_vertical_housing(); // 2x

//radial_bearing_6906_vertical_housing(); // 2x

//upper_arm_motor_corners();

//tube_bracket_long_one_hole(bracket_length = shoulder_bracket_length, tube_radius = shoulder_shaft_radius);

//belt_tensioner_spacer(belt_tensioner_distance_between_holes);// 2x

//tube_interior_cover(2 * rb_626_external_radius);

//upper_arm_screw_rotation_pulley();

//upper_arm_motor_pulley();
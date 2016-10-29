// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_arm.scad>

include <../basic_scad/params_stepper_motors.scad>

include <../basic_scad/params_basic_components.scad>
use <../basic_scad/basic_components.scad>
use <../basic_scad/stepper_motors.scad>
include <../basic_scad/params_screws_nuts_washers.scad>
use <../basic_scad/screws_nuts_washers.scad>
include <../basic_scad/params_radial_bearings.scad>
include <../basic_scad/params_dc_motors.scad>
use <../basic_scad/dc_motors.scad>
use <../basic_scad/stepper_motors_housing.scad>
include <../basic_scad/params_motor_housing.scad>
use <../basic_scad/radial_bearing_housing.scad>
include <../basic_scad/config.scad>
include <../basic_scad/params_radial_bearings_housing.scad>
use <motor_plate.scad>
include <params_motor_plate.scad>
use <../basic_scad/functions_3d.scad>
use <../basic_scad/masa.scad>
use <../basic_scad/pulleys.scad>
use <../basic_scad/radial_bearings.scad>
use <../basic_scad/rings.scad>
use <../basic_scad/spacer.scad>
include <../basic_scad/params_sensor_array.scad>

use <gripper.scad>
use <../basic_scad/belt.scad>
use <../basic_scad/belt_tensioner.scad>

use <../basic_scad/potentiometer_support.scad>
use <../basic_scad/potentiometers.scad>
use <../basic_scad/params_potentiometers.scad>

use <potentiometer_gears.scad>

//---------------------------------------------------------------------------
module motor_pulley()
{
  pulley_t_ht = 8;	// length of toothed part of pulley
  pulley_base_height = 1.5;
  difference(){      
    //rotate ([0, 0, 10.8]) pulley_with_shaft(52, 14, 0, 0, 8, 4, 0, 0);
    pulley_with_shaft(52, 14, 0, 0, 8, 4, 0, 0);
        
    // M3 screws
    translate ([0, 0, pulley_t_ht / 2 + pulley_base_height]) rotate ([-90, 0, 0]) cylinder (h = 40, r = m3_screw_radius, $fn = 25);
        
    // M3 nut
    hull(){
            translate ([0, 5, pulley_t_ht / 2 + pulley_base_height]) rotate ([-90, 30, 0]) cylinder (h = m3_nut_thick + 0.2, r = m3_nut_radius + 0.1, $fn = 6);
           translate ([0, 5, 9 + pulley_base_height]) rotate ([-90, 30, 0]) cylinder (h = m3_nut_thick + 0.2, r = m3_nut_radius + 0.1, $fn = 6);
    }

  }
}
//---------------------------------------------------------------------------
module upper_arm_pulley()
{
  difference(){
    pulley_with_shaft(64, 29, 0, 0, 4, m8_nut_radius, m8_nut_thick);
      // screw hole
      cylinder (h = 6, r = m8_nut_radius, $fn = 6);
      // motor housing fixer holes
      
      for (i=[0:3]){
          translate (nema_17_housing_small_base_holes_position[i] + [0, -0, 0] - display_tolerance_z) cylinder (h = 9 + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
          translate (nema_17_housing_small_base_holes_position[i] + [0, -0, 4] - display_tolerance_z) cylinder (h = 9 + 2 * display_tolerance, r = m4_nut_radius, $fn = 6);
      }
  }
    
}
//---------------------------------------------------------------------------
module upper_arm_motor_housing()
{
    nema_motor_housing_with_base_holes(0, 0, nema_17_width, nema_17_height, 40, nema_17_gearbox_motor_hole_radius, gearbox_nema_17_holes_position, 3, 13, nema_17_housing_small_base_holes_position);    
}
//---------------------------------------------------------------------------
module upper_arm_pulley_with_components()
{
   upper_arm_pulley(); 
    // motor housing
    translate ([-motor_housing_width / 2, upper_arm_motor_housing_shift, 0]) rotate ([0, 90, -90]) 
    upper_arm_motor_housing();
}
//---------------------------------------------------------------------------
module shoulder_pulley()
{
    pulley_with_shaft(64, 29, 0, 0, 4, m8_nut_radius, m8_nut_thick);
}
//---------------------------------------------------------------------------
module elbow_pulley()
{
  difference(){
        pulley(65, 66, 0, 0, 8, 0);
     
        // bearing hole    
        translate ([0, 0, 0] - display_tolerance_z) cylinder( h = rb_626_thick + display_tolerance + 0.5, r = rb_626_external_radius, $fn = 50);
        // bearing border
        translate ([0, 0, 0]) cylinder( h = rb_626_thick + 90, r = rb_626_external_radius - 1, $fn = 50);
        // cut hole for belt
        translate ([dist_to_rotita_fore_arm + m8_nut_thick + rbearing_608_enclosed_housing_slim_size[1] -1, -23, -1]) cube([13, 46, 20]);
        // holes for fixing the forearm
        // first bearing
        for (i= [0:1]){
            translate ([dist_to_rotita_fore_arm + 14.5, (rbearing_608_enclosed_housing_slim_holes_position[0][0] - rbearing_608_enclosed_housing_slim_holes_position[1][0]) / 2 - rbearing_608_enclosed_housing_slim_holes_position[0][0], 0] - display_tolerance_z) rotate ([0, 0, 90]) translate(rbearing_608_enclosed_housing_slim_holes_position[i]) cylinder (h = 30, r = 2, $fn = 30);
        // holes for fixing the forearm
        // second bearing
            translate ([dist_to_rotita_fore_arm + 37, (rbearing_608_enclosed_housing_slim_holes_position[0][0] - rbearing_608_enclosed_housing_slim_holes_position[1][0]) / 2 - rbearing_608_enclosed_housing_slim_holes_position[0][0], 0] - display_tolerance_z) rotate ([0, 0, 90]) translate(rbearing_608_enclosed_housing_slim_holes_position[i]) cylinder (h = 30, r = 2, $fn = 20);
        }
        // holes for fixing the motor housing
        for (i= [0:3]){
            translate (nema_11_housing_base_holes[i] - display_tolerance_z)  cylinder (h = 30, r = m4_screw_radius, $fn = 20);      
            translate (nema_11_housing_base_holes[i] + [0, 0, 5])  cylinder (h = 40, r = m4_nut_radius, $fn = 6);      
        }
  }
    
}
//---------------------------------------------------------------------------
module forearm_motor_housing()
{
    difference(){
      nema_11_housing_with_belt_tensioner_bearing_based_x_and_base_holes(15, 0);
        translate ([0, nema_11_width / 2 + 2, 23] - display_tolerance_x) rotate ([0, 90, 0]) cylinder (h = 5, r = 8);
    }
}
//---------------------------------------------------------------------------
module forearm_motor_housing_with_components()
{
    forearm_motor_housing();
    translate ([3 + 7.5, 16, 3 + 5]) mirror([0, 0, 1]) belt_tensioner_slider();
}
//---------------------------------------------------------------------------
module forearm_potentiometer_support()
{
    potentiometer_support_with_screw_holes(25, 48, 13, 29, 8);
}
//---------------------------------------------------------------------------
module elbow_gear()
{// partial gear
    pot_gear(13, 13, rb_626_external_radius, 10); 
}
//---------------------------------------------------------------------------
module elbow_pulley_with_components()
{
    // pulley 
    elbow_pulley();
    
    // M6 screw
    translate([0, 0, -m6_nut_thick]) M6x50_hexa_screw();
    
    626rs();
    
    translate([0, 0, 11]) 626rs();
    translate([0, 0, 11 + rb_626_thick]) M6_nut();
    
    translate([0, 0, 12]) elbow_gear();
    
    // motor housing
 // translate ([20 + 3, -nema_11_width / 2 - 2, 0]) rotate ([0, 90, 0]) mirror ([0, 0, 1]) 
   // forearm_motor_housing_with_components();
    
    // stepper motor
 // translate ([-10 - 2 - nema_11_27_1_gearbox_length, 0, -nema_11_width / 2 - 3 - 15]) rotate ([0, 90, 0]) 
   // nema_11_with_27_1_gearbox();
    
    // motor pulley
  translate ([20 + 3 + 3, 0, -nema_11_width / 2 - 3 - 15]) rotate ([0, 90, 0]) 
    motor_pulley();
    
    // belt
  translate ([20 + 3 + 12, 0, -nema_11_width / 2 - 3 - 15]) rotate ([0, -90, 0]) 
    belt_on_2_pulleys(8, 18, 52, 6);
    
    // potentiometer support
    translate ([54.5, 24, 0]) rotate ([0, 90, 180]) forearm_potentiometer_support();
    
    // potentiometer
    translate ([55 - 7 - 2 - 2, 0, -10]) rotate ([0, 90, 0]) potentiometer_BOURNS_3852A_282_103AL();

}
//---------------------------------------------------------------------------
module forearm_bone()
{
    color (aluminium_color) cube([bone_thick, bone_thick, fore_arm_length]);
}
//---------------------------------------------------------------------------
module forearm_pulley()
{
    difference(){
        pulley_base_height = 1.5;
        pulley_with_shaft(66, 20, 0, 0, 8, 4, 0, 0);
        // M3 screw hole
        
        translate ([0, 0, 4 + pulley_base_height]) rotate ([-90, 0, 0]) cylinder (h = 40, r = 2, $fn = 20);
        
        //  M3 nut hole
        hull(){
            translate ([0, 8, 0]) rotate ([-90, 30, 0]) cylinder (h = m4_nut_thick, r = m4_nut_radius, $fn = 6);
            translate ([0, 8, 4 + pulley_base_height]) rotate ([-90, 30, 0]) cylinder (h = m4_nut_thick, r = m4_nut_radius, $fn = 6);
        }
    }
}
//---------------------------------------------------------------------------
module fore_arm()
{
// shaft
    translate ([-bone_thick / 2, -bone_thick / 2, m8_nut_thick + rb_608_thick + washer_8_thick + 9 + 2 + 2 * washer_8_thick + rb_608_thick + washer_8_thick]) forearm_bone();
// M8 screw
    translate ([0, 0, 0]) M8x50_hexa();
// 608 bearing
    translate ([0, 0, m8_nut_thick]) 608rs();
    // pulley
    translate ([0, 0, m8_nut_thick + rb_608_thick + washer_8_thick]) forearm_pulley();
    // 608 bearing
    translate ([0, 0, m8_nut_thick + rb_608_thick + washer_8_thick + 9 + 2 + 2 * washer_8_thick]) 608rs();
   // first bearing housing 
    translate ([rbearing_608_enclosed_housing_slim_size[2] - rb_608_external_radius, rbearing_608_enclosed_housing_slim_size[0]/2, m8_nut_thick - radial_bearing_vertical_housing_grosime_perete_lateral_slim_latime]) rotate ([90, 0, 0])rotate ([0, -90, 0]) radial_bearing_608_vertical_housing_slim();
// second bearing housing
    translate ([rbearing_608_enclosed_housing_slim_size[2] - rb_608_external_radius, rbearing_608_enclosed_housing_slim_size[0]/2, m8_nut_thick + rb_608_thick + washer_8_thick + 9 + 2 + 2 * washer_8_thick - radial_bearing_vertical_housing_grosime_perete_lateral_slim_latime]) rotate ([90, 0, 0])rotate ([0, -90, 0]) radial_bearing_608_vertical_housing_slim();
// elbow pulley
translate ([-rb_608_external_radius - 11, 0, -12]) rotate ([0, 90,0]) rotate([0, 0, 180]) elbow_pulley_with_components();
    
    // gripper
    translate ([0, 0, fore_arm_length + bone_thick + inaltime_roata_reductor_cot + 3]) gripper();
}
//---------------------------------------------------------------------------
module upper_arm_bone()
{
    difference(){
        color (aluminium_color) cube([bone_thick, bone_thick, upper_arm_length]);
    }
}
//---------------------------------------------------------------------------
module upper_arm()
{
    // bone
   translate ([- bone_thick / 2, -150, -bone_thick / 2]) rotate ([90, 0, 0]) upper_arm_bone();
    
    // M8 screw
   translate ([0, 9, 0]) rotate ([90, 0, 0]) M8_hexa_screw(150);
    
    // gear with components
    translate ([0, 9, 0]) rotate ([90, 0, 0]) upper_arm_pulley_with_components(); 
    
    // stepper motor 
    translate ([0, nema_17_width / 2 + 9 + 3, -nema_17_with_5_1_gearbox_height + upper_arm_motor_housing_shift - 3]) nema_17_with_5_1_gearbox();
    
    // motor pulley
    // translate ([0, nema_17_width / 2 + 9 + 3, 33]) mirror([0, 0, 1])motor_pulley();
    
    // forearm
    translate ([0, -160 - upper_arm_length + 3 / 2 * bone_thick -10, -bone_thick / 2 + 15])  rotate([0, 0, angle_elbow]) rotate([0, 90, 0]) fore_arm();
    
    // belt
    translate ([0, 9 + 3 + nema_17_width / 2, upper_arm_motor_housing_shift + nema_17_gearbox_shaft_length - 10]) rotate([0, 0, -90]) belt_on_2_pulleys(10, 52, upper_arm_length + 177, 5);
    
}
//---------------------------------------------------------------------------
module shoulder_plate()
{
    difference(){
        echo("shoulder plate");
        echo(shoulder_plate_size=shoulder_plate_size);

        color (aluminium_color) cube(shoulder_plate_size);
        echo("motor housing holes:");
        for (i=[0:3]){
            echo([shoulder_plate_size[0] / 2, shoulder_plate_size[1] - 22 - perete_motor_motor_housing, 0] - nema_17_housing_base_holes[i]);
        translate ([shoulder_plate_size[0] / 2, shoulder_plate_size[1] - 22 - perete_motor_motor_housing, 0] - nema_17_housing_base_holes[i] - display_tolerance_z) cylinder (h = 3 + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
        }
        echo("bearing housing holes:");
        for (i=[0:1]){
            echo(rbearing_608_enclosed_housing_holes_position[i] + [shoulder_plate_size[0] / 2 - (rbearing_608_enclosed_housing_holes_position[0][0] + rbearing_608_enclosed_housing_holes_position[1][0]) / 2, bone_thick, 0]);
            translate (rbearing_608_enclosed_housing_holes_position[i] + [shoulder_plate_size[0] / 2 - (rbearing_608_enclosed_housing_holes_position[0][0] + rbearing_608_enclosed_housing_holes_position[1][0]) / 2, bone_thick, 0] - display_tolerance_z) cylinder (h = 3 + 2 * display_tolerance, r = m4_screw_radius);
        }
        for (i=[0:1])
            translate (rbearing_608_enclosed_housing_holes_position[i] + [shoulder_plate_size[0] / 2 - (rbearing_608_enclosed_housing_holes_position[0][0] + rbearing_608_enclosed_housing_holes_position[1][0]) / 2, bone_thick + 40, 0] - display_tolerance_z) cylinder (h = 3 + 2 * display_tolerance, r = m4_screw_radius);
    }
}
//---------------------------------------------------------------------------
module shoulder()
{
    //plate
    shoulder_plate();
    
    // motor
    translate ([shoulder_plate_size[0] / 2, shoulder_plate_size[1] - nema_17_with_13_1_gearbox_height - perete_baza_motor_housing, -(nema_17_width / 2 + 3 + perete_baza_motor_housing +32)]) 
    rotate ([-90, 0, 0]) 
    nema_17_with_13_1_gearbox();
// motor gear for forearm  rotation
    translate ([shoulder_plate_size[0] / 2, (shoulder_plate_size[1] + 17), -(nema_17_width / 2 + 3 + perete_baza_motor_housing + 32)]) 
    rotate ([90, 0, 0]) 
    motor_pulley();
    
    // motor housing
    translate ([shoulder_plate_size[0] / 2 + motor_housing_width / 2, latime_tabla_umar , 0]) 
    mirror([0, 0, 1])
    rotate ([0, -90, 90]) 
    nema_17_housing_with_belt_tensioner_bearing_based_x_and_base_holes(15, 20);
    
    // bone support 1
    translate ([-rbearing_608_enclosed_housing_size[0] / 2 + shoulder_plate_size[0] / 2, 0, grosime_tabla_alu + 25]) 
    mirror([0, 0, 1])
    radial_bearing_608_vertical_housing();
    
    // bone support 2
    translate ([-rbearing_608_enclosed_housing_size[0] / 2 + shoulder_plate_size[0] / 2, shoulder_plate_size[1] - rbearing_608_enclosed_housing_size[1], grosime_tabla_alu + 25]) 
mirror([0, 0, 1])    
    radial_bearing_608_vertical_housing();
        
    // continuation with upper arm
    translate ([shoulder_plate_size[0]/ 2, shoulder_plate_size[1] + 7, rb_608_external_radius + grosime_tabla_alu]) rotate ([0, angle_fore_arm, 0]) upper_arm();    

}
//---------------------------------------------------------------------------
module plate_body_articulation()
{
  difference(){
        echo("Body plate size: ", plate_body_size);
        color (aluminium_color) cube(plate_body_size);
        // screws holes for body bone connection
        // rest of arms screws
        
        // motor housing screws
        for (i = [0:3]){
            translate ([plate_body_size[0] / 2, plate_body_size[1] - 18 - 3, 0] - display_tolerance_z) rotate ([0, 0, 90]) translate(nema_17_housing_base_holes[i])  cylinder ( h = wall_thick_3 + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        }
  }
}
//---------------------------------------------------------------------------
module traction_pulley()
{
    pulley_with_shaft(60, 33, 0, 0, 8, 4, m8_nut_radius, m8_nut_height);
}
//---------------------------------------------------------------------------
module body_articulation()
{
    // plate
    plate_body_articulation();
    // motor
    translate ([plate_body_size[0] / 2, -nema_17_with_13_1_gearbox_height + plate_body_size[1] - 3, -nema_17_width / 2 - 3 - 25]) rotate ([-90, 0, 0]) nema_17_with_13_1_gearbox();
// motor housing
    translate ([plate_body_size[0] / 2 - nema_17_width / 2 - 2 , plate_body_size[1], 0]) 
      rotate ([90, 0, 0]) 
        rotate ([0, 0, -90])
          nema_17_housing_with_belt_tensioner_bearing_based_x_and_base_holes(20, 5);

    // motor pulley
    
    translate ([plate_body_size[0] / 2, plate_body_size[1], -nema_17_width / 2 - 25 - 3]) rotate ([-90, 0, 0]) motor_pulley();
      
    //support upper arm
    // first bearing housing
   translate ([-rbearing_608_vertical_housing_size_bounded_half_small[0] / 2 + 5 + plate_body_size[0] / 2, 5, 3])  rbearing_608_vertical_housing_bounded_half_small();
    
   translate ([-rbearing_608_vertical_housing_size_bounded_half_small_top[0] / 2 + 5 + plate_body_size[0] / 2, 5, rbearing_608_vertical_housing_size_bounded_half_small[2] + rbearing_608_vertical_housing_size_bounded_half_small_top[2] + 3])  
   mirror ([0, 0, 1]) 
    rbearing_608_vertical_housing_bounded_half_small_top();
    
// second bearing housing
   translate ([-rbearing_608_vertical_housing_size_bounded_half_small[0] / 2 + 5 + plate_body_size[0] / 2, plate_body_size[1] - 5, 3])  rbearing_608_vertical_housing_bounded_half_small();
    
   translate ([-rbearing_608_vertical_housing_size_bounded_half_small_top[0] / 2 + 5 + plate_body_size[0] / 2, plate_body_size[1] - 5, rbearing_608_vertical_housing_size_bounded_half_small[2] + rbearing_608_vertical_housing_size_bounded_half_small_top[2] + 3])  
   mirror ([0, 0, 1]) 
    rbearing_608_vertical_housing_bounded_half_small_top();
    
    // screw for upper arm
    translate ([40, 73, 33 + 5]) 
    rotate ([90, 0, 0]) 
    rotate ([0, 0, angle_shoulder]) 
    translate ([- bone_thick / 2, - bone_thick / 2, 0])
    color (aluminium_color) 
    M8_hexa_screw(100);
    ;  

    // shaft
    translate ([35, -10, 30 + 3]) 
    rotate ([90, 0, 0]) 
    rotate ([0, 0, angle_shoulder]) 
    translate ([- bone_thick / 2, - bone_thick / 2, 0])
    color (aluminium_color) 
    cube([bone_thick, bone_thick, 80])
    ;  
    // pulley 
    translate ([35, 73, 30 + 3]) 
      rotate ([90, 0, 0]) 
        rotate ([0, 0, angle_shoulder]) 
          traction_pulley();

    // upper arm
    translate ([35 + 10, -90, 30 + plate_body_size[2]]) 
      rotate ([0, angle_shoulder, 0]) 
        translate([bone_thick / 2, 0, + bone_thick / 2]) 
          rotate ([0, 0, 90]) 
    shoulder()
 ;
    
}
//---------------------------------------------------------------------------
module body_arm_bone(bone_length)
{
    echo("body bone holes");
    difference(){
        cube_empty(6, 10, bone_length);
        for (i=[0:1]){
            //echo(chest_height / 2 + rotate_y (90, pozitie_gauri_trunchi[i])[2]);
            
            translate ([-bone_thick / 2, 0, bone_length / 2 + pozitie_gauri_trunchi[i][0]] - display_tolerance_x) rotate ([0, 90, 0]) cylinder (h = bone_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
        }
    }
}
//---------------------------------------------------------------------------
module arm(bone_length)
{
// vertical axis
    translate ([0, 0, wall_thick_3 + washer_8_thick + rb_608_thick]) rotate ([0, 0, angle_body_arm])  
    color (aluminium_color) body_arm_bone(bone_length);
        
    // reduction gear
    translate ([0, 0, 0]) rotate([0, 0, angle_body_arm]) mirror ([0, 0, 1]) shoulder_pulley();
    
    // continuation
    translate ([0, 0, bone_length / 2 + plate_body_size[0] / 2 + 1.5]) rotate ([0, 0, angle_body_arm]) translate ([bone_thick / 2, -3 / 2 * bone_thick, 0]) rotate ([0, 90, 0]) body_articulation();
}
//---------------------------------------------------------------------------
arm(200);

//motor_pulley();

//body_arm_bone(300);

//body_articulation();

//nema_17_housing_with_belt_tensioner_bearing_based_x_and_base_holes(20, 5);

//nema_11_housing_with_belt_tensioner_bearing_based_x_and_base_holes(15, 0);

//shoulder_pulley();

//plate_body_articulation();


//shoulder();
//upper_arm();

//forearm_pulley();

//fore_arm();

//forearm_motor_housing();

//forearm_motor_housing_with_components();


//elbow_pulley();

//elbow_pulley_with_components();

//upper_arm_pulley();
//upper_arm_motor_housing();
//upper_arm_pulley_with_components();

//plate_body_articulation();

//shoulder_plate();

//forearm_potentiometer_support();

//elbow_gear();
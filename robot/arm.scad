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

include <params_gripper.scad>
use <gripper.scad>
use <../basic_scad/belt.scad>
use <../basic_scad/belt_tensioner.scad>

use <../basic_scad/potentiometer_support.scad>
use <../basic_scad/potentiometers.scad>
use <../basic_scad/params_potentiometers.scad>

use <potentiometer_gears.scad>
include <../basic_scad/params_webcam.scad>

use <../basic_scad/webcam.scad>

//---------------------------------------------------------------------------
module motor_pulley()
{
  pulley_t_ht = 8;	// length of toothed part of pulley
  pulley_base_height = 1.5;
  difference(){      
      rotate ([0, 0, 12]) 
    pulley_with_shaft(62, 15, 0, 0, 8, 4, 0, 0);
        
    // M3 screws
    translate ([0, 0, pulley_t_ht / 2 + pulley_base_height]) rotate ([-90, 0, 0]) cylinder (h = 40, r = m3_screw_radius, $fn = 25);
        
      dist_to_nut = 5.7;
    // M3 nut
    hull(){
            translate ([0, dist_to_nut, pulley_t_ht / 2 + pulley_base_height]) rotate ([-90, 30, 0]) cylinder (h = m3_nut_thick + 0.2, r = m3_nut_radius + 0.1, $fn = 6);
           translate ([0, dist_to_nut, 9 + pulley_base_height]) rotate ([-90, 30, 0]) cylinder (h = m3_nut_thick + 0.2, r = m3_nut_radius + 0.1, $fn = 6);
    }

  }
}
//---------------------------------------------------------------------------
module forearm_motor_pulley()
{
  pulley_t_ht = 8;	// length of toothed part of pulley
  pulley_base_height = 1.5;
  difference(){      
    //rotate ([0, 0, 10.8]) pulley_with_shaft(52, 14, 0, 0, 8, 4, 0, 0);
    pulley_with_shaft(52, 14, 0, 0, 8, 3, 0, 0);
        
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
    pulley_with_shaft(64, 29, 0, 0, 8, 4, m8_nut_radius, m8_nut_thick);
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
    pulley_with_shaft(64, 29, 0, 0, 8, 4, m8_nut_radius, m8_nut_thick);
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

        // top bearing hole    
        translate ([0, 0, 9]) cylinder( h = rb_626_thick + display_tolerance + 0.5, r = rb_626_external_radius, $fn = 50);

        // cut hole for belt
        translate ([distance_to_fore_arm_gear + 4, -25, 0] - display_tolerance_z) cube([15, 50, 20]);
        // holes for fixing the forearm
        // first bearing holes
        for (i= [0:1]){
            translate ([distance_to_fore_arm_gear + 37 - 7 - 2, (rbearing_608_enclosed_housing_slim_holes_position[0][0] - rbearing_608_enclosed_housing_slim_holes_position[1][0]) / 2 - rbearing_608_enclosed_housing_slim_holes_position[0][0], 0] - display_tolerance_z) rotate ([0, 0, 90]) translate(rbearing_608_enclosed_housing_slim_holes_position[i]) cylinder (h = 30, r = 2, $fn = 30);
        // holes for fixing the forearm
        // second bearing holes
            translate ([distance_to_fore_arm_gear + 37, (rbearing_608_enclosed_housing_slim_holes_position[0][0] - rbearing_608_enclosed_housing_slim_holes_position[1][0]) / 2 - rbearing_608_enclosed_housing_slim_holes_position[0][0], 0] - display_tolerance_z) rotate ([0, 0, 90]) translate(rbearing_608_enclosed_housing_slim_holes_position[i]) cylinder (h = 30, r = 2, $fn = 20);
        }
        // holes for fixing the motor housing
        for (i= [0:3]){
            translate (nema_11_housing_base_holes[i] - display_tolerance_z)  cylinder (h = 30, r = m4_screw_radius, $fn = 20);      
            translate (nema_11_housing_base_holes[i] + [0, 0, 5])  cylinder (h = 40, r = m4_nut_radius, $fn = 6);      
        }
        
        translate ([38, 25, 0] - display_tolerance_z) cylinder( h = 11 + 2 * display_tolerance, r = 3, $fn = 50);
        translate ([38, -25, 0] - display_tolerance_z) cylinder( h = 11 + 2 * display_tolerance, r = 3, $fn = 50);

  }
    
}
//---------------------------------------------------------------------------
module forearm_motor_housing()
{
    difference(){
        nema_motor_housing_with_belt_tensioner_bearing_based_x(15, 0, nema_11_width, nema_11_height, base_height = 40, nema_center_hole_radius = nema_11_motor_gearbox_hole_radius, nema_holes_position = gearbox_nema_11_holes_position, base_thick = 3, dist_to_first_hole_z = 14, nema_housing_base_holes = nema_11_housing_base_holes, motor_screw_holes_rotation_angle = 45);
        
      translate ([0, nema_11_width / 2 + 2, 17] - display_tolerance_x) rotate ([0, 90, 0]) cylinder (h = 5, r = 8);
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
module elbow_potentiometer_support()
{
    potentiometer_support_on_rectangular_axis(length = 25, width = 23.3, potentiometer_height = 4, box_height = 15, vertical_distance_to_potentiometer = 7, _stopper_shift = -0.9);
}
//---------------------------------------------------------------------------
module elbow_gear()
{// partial gear
    pot_gear(13, rb_626_external_radius, 10); 
}
//---------------------------------------------------------------------------
module elbow_pulley_with_components()
{
    // pulley 
    elbow_pulley();
    
    // M6 screw
    translate([0, 0, -m6_nut_thick]) M6_hexa_screw(45);
    // bearing
    626rs();
    //bearing
    translate([0, 0, 11]) 626rs();
    // nut
    translate([0, 0, 11 + rb_626_thick]) M6_nut();
    for (i=[0:2]) // 3 washers
      translate([0, 0, 11 + rb_626_thick + m6_nut_thick + i * washer_6_thick]) washer_6_12();
    
    translate([0, 0, 12]) elbow_gear();
    
    // motor housing
    translate ([14 + 3, -nema_11_width / 2 - 2, 0]) rotate ([0, 90, 0]) mirror ([0, 0, 1]) 
      forearm_motor_housing_with_components();
    
    // stepper motor
  translate ([-10 - 2 - nema_11_27_1_gearbox_length, 0, -nema_11_width / 2 - 3 - 15]) rotate ([0, 90, 0]) 
    nema_11_with_27_1_gearbox();
    
    // motor pulley
  translate ([20 + 3 + 3, 0, -nema_11_width / 2 - 3 - 15]) rotate ([0, 90, 0]) 
    forearm_motor_pulley();
    
    // belt
  translate ([20 + 3 + 3, 0, -nema_11_width / 2 - 3 - 15]) rotate ([0, -90, 0]) 
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
        pulley_with_shaft(66, 20, 0, 0, 8, 4, m8_nut_radius, m8_nut_height);
    }
}
//---------------------------------------------------------------------------
module gripper_c920_support_with_camera()
{
    gripper_c920_support();
    translate ([0, 0, c920_depth]) rotate ([90, 0, 0]) mirror ([0, 1, 0]) c920();
}
//---------------------------------------------------------------------------
module fore_arm()
{
// shaft
    translate ([-bone_thick / 2, -bone_thick / 2, m8_nut_thick + rb_608_thick + washer_8_thick + 9 + 2 + 2 * washer_8_thick + rb_608_thick + washer_8_thick]) forearm_bone();
// M8 screw
    translate ([0, 0, 0]) M8x50_hexa();
    // pulley
    forearm_pulley();
    forearm_pulley_thick = 11;
    
// 608 bearing
    translate ([0, 0, forearm_pulley_thick + 2 * washer_8_thick]) 608rs();
    // second 608 bearing
    translate ([0, 0, forearm_pulley_thick + 2 * washer_8_thick + rb_608_thick  + 2]) 608rs();
   // double bearing housing 
    translate ([rbearing_608_enclosed_housing_slim_size[2] - rb_608_external_radius, rbearing_608_enclosed_housing_slim_size[0] / 2, forearm_pulley_thick + 2 * washer_8_thick - 1]) rotate ([90, 0, 0])rotate ([0, -90, 0]) radial_bearing_608_vertical_housing_slim_double();

    // gripper
    translate ([bone_thick / 2, -gripper_motor_support_size [1] / 2, fore_arm_length + bone_thick + elbow_gear_thick + 3 + 60]) rotate([0, 90, 0]) gripper();
// camera support
    translate ([- bone_thick / 2 - 3, c920_depth / 2 + c920_dist_between_holder_holes / 2, fore_arm_length + bone_thick + elbow_gear_thick + 3]) rotate([0, 0, -90])  gripper_c920_support_with_camera();
}
//---------------------------------------------------------------------------
module fore_arm_with_elbow_pulley()
{
  translate ([18, 0, 22]) 
    rotate ([0, 90,0]) rotate([0, 0, 180]) 
    fore_arm();
// elbow pulley
    elbow_pulley_with_components();
}
//---------------------------------------------------------------------------
module upper_arm_bone()
{
    difference(){
        color (aluminium_color) cube([bone_thick, bone_thick, upper_arm_length]);
    }
}
//---------------------------------------------------------------------------
module belt_tensioner_elbow_pulley()
{
  belt_tensioner_with_branch(32);
}
//---------------------------------------------------------------------------
module upper_arm()
{
    // bone
   translate ([- bone_thick / 2, -105, -bone_thick / 2]) rotate ([90, 0, 0]) upper_arm_bone();
    
    // belt tensioner
    translate ([-wall_thick_3 - bone_thick / 2, -200, - bone_thick / 2- wall_thick_3 - m4_nut_height - 2]) rotate ([-90, 0, 0]) rotate ([0, 0, -90]) belt_tensioner_elbow_pulley();
    
    // elbow potentiometer support
    translate ([+ bone_thick / 2, -300, + bone_thick / 2 + 3]) mirror([0, 0, 1])     elbow_potentiometer_support();
    
    // M8 screw
   translate ([0, 9, 0]) rotate ([90, 0, 0]) M8_hexa_screw(150);
    
    // gear with components
    translate ([0, 9, 0]) rotate ([90, 0, 0]) upper_arm_pulley_with_components(); 
    
    // stepper motor 
    translate ([0, nema_17_width / 2 + 9 + 3, -nema_17_with_5_1_gearbox_height + upper_arm_motor_housing_shift - 3]) nema_17_with_5_1_gearbox();
    
    // motor pulley
    translate ([0, nema_17_width / 2 + 9 + 3, 33]) mirror([0, 0, 1])motor_pulley();
    
    // forearm
    translate ([0, -110 - upper_arm_length + 3 / 2 * bone_thick, -bone_thick / 2 + 37])  
    rotate([0, 0, angle_elbow]) 
    mirror([0, 0, 1])
    fore_arm_with_elbow_pulley();
    
    // belt
    translate ([0, 9 + 3 + nema_17_width / 2, upper_arm_motor_housing_shift + nema_17_gearbox_shaft_length - 10]) rotate([0, 0, -90]) belt_on_2_pulleys(10, 52, upper_arm_length + 128, 5);
    
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
module shoulder_motor_housing()
{
    nema_motor_housing_with_belt_tensioner_bearing_based_x(10, 12, nema_17_width, nema_17_height, base_height = 40, nema_center_hole_radius = nema_17_gearbox_motor_hole_radius, nema_holes_position = gearbox_nema_17_holes_position, base_thick = 3, dist_to_first_hole_z = 18, nema_housing_base_holes = nema_17_housing_base_holes, sunken_base_holes = 0);
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
    translate ([shoulder_plate_size[0] / 2 + motor_housing_width / 2, shoulder_plate_size[1] , 0]) 
    mirror([0, 0, 1])
    rotate ([0, -90, 90]) 
    shoulder_motor_housing();
    
    // bone support 1
    translate ([-rbearing_608_enclosed_housing_size[0] / 2 + shoulder_plate_size[0] / 2, 30, alu_sheet_3_thick + 25]) 
    mirror([0, 0, 1])
    radial_bearing_608_vertical_housing();
    
    // bone support 2
    translate ([-rbearing_608_enclosed_housing_size[0] / 2 + shoulder_plate_size[0] / 2, shoulder_plate_size[1] - rbearing_608_enclosed_housing_size[1], alu_sheet_3_thick + 25]) 
mirror([0, 0, 1])    
    radial_bearing_608_vertical_housing();
        
    // continuation with upper arm
    translate ([shoulder_plate_size[0]/ 2, shoulder_plate_size[1] + 7, rb_608_external_radius + alu_sheet_3_thick]) rotate ([0, angle_fore_arm, 0]) upper_arm();    

}
//---------------------------------------------------------------------------
module plate_body_articulation()
{
  difference(){
        echo("Body-arm plate size: ", plate_body_size);
        color (aluminium_color) cube(plate_body_size);
        // screws holes for body bone connection
        // rest of arms screws
        // first bearing housing support holes
      for (i = [0:1]){
      echo([plate_body_size[0] / 2 - (rbearing_608_enclosed_housing_holes_position[1][0] - rbearing_608_enclosed_housing_holes_position[0][0]) / 2 - rbearing_608_enclosed_housing_holes_position[0][0], 0, 0] + rbearing_608_enclosed_housing_holes_position[i]);
          translate ([plate_body_size[0] / 2 - (rbearing_608_enclosed_housing_holes_position[1][0] - rbearing_608_enclosed_housing_holes_position[0][0]) / 2 - rbearing_608_enclosed_housing_holes_position[0][0], 0, 0] - display_tolerance_z) translate(rbearing_608_enclosed_housing_holes_position[i])  cylinder ( h = wall_thick_3 + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
      }
        // motor housing base screw holes
      echo("motor holes position:");
        for (i = [0:3]){
            echo([plate_body_size[0] / 2, plate_body_size[1] - 18 - 3, 0] + rotate_z(90, nema_17_housing_base_holes[i]));
            translate ([plate_body_size[0] / 2, plate_body_size[1] - 18 - 3, 0] - display_tolerance_z) rotate ([0, 0, 90]) translate(nema_17_housing_base_holes[i])  cylinder ( h = wall_thick_3 + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        }
        // holes for the other bearing housing     
  }
}
//---------------------------------------------------------------------------
module traction_pulley()
{
    difference(){
        pulley_with_shaft(60, 33, 0, 0, 8, 4, m8_nut_radius, m8_nut_height);
        cylinder (h = 6, r = m8_nut_radius, $fn = 6);
    }
}
//---------------------------------------------------------------------------
module potentiometer_support_shoulder_vertical()
{
    potentiometer_support_squared_with_screw_holes(length = 25, width = 48, height = 14, dist_between_support_holes = 30, dist_to_support_holes = 6);
}
//---------------------------------------------------------------------------
module body_stepper_motor_housing()
{
      nema_motor_housing_with_belt_tensioner_bearing_based_x(20, 5, nema_17_width, nema_17_height, base_height = 40, nema_center_hole_radius = nema_17_gearbox_motor_hole_radius, nema_holes_position = gearbox_nema_17_holes_position, base_thick = 3, dist_to_first_hole_z = 18, nema_housing_base_holes = nema_17_housing_base_holes, sunken_base_holes = 0);
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
          body_stepper_motor_housing()

    // motor pulley
    
    translate ([plate_body_size[0] / 2, plate_body_size[1], -nema_17_width / 2 - 25 - 3]) rotate ([-90, 0, 0]) motor_pulley();
      
    //support upper arm
    // first bearing housing
   translate ([-rbearing_608_vertical_housing_size_bounded_half_small[0] / 2 + 5 + plate_body_size[0] / 2, 5, 3])  rbearing_608_vertical_housing_bounded_half_small();
    
   translate ([-rbearing_608_vertical_housing_size_bounded_half_small_top[0] / 2 + 5 + plate_body_size[0] / 2, 5, rbearing_608_vertical_housing_size_bounded_half_small[2] + rbearing_608_vertical_housing_size_bounded_half_small_top[2] + 3])  
   mirror ([0, 0, 1]) 
    rbearing_608_vertical_housing_bounded_half_small_top();
    
// second bearing housing
   translate ([-rbearing_608_vertical_housing_size_bounded_half_small[0] / 2 + 5 + plate_body_size[0] / 2, plate_body_size[1] - 9, 3])  rbearing_608_vertical_housing_bounded_half_small();
    
   translate ([-rbearing_608_vertical_housing_size_bounded_half_small_top[0] / 2 + 5 + plate_body_size[0] / 2, plate_body_size[1] - 9, rbearing_608_vertical_housing_size_bounded_half_small[2] + rbearing_608_vertical_housing_size_bounded_half_small_top[2] + 3])  
   mirror ([0, 0, 1]) 
    rbearing_608_vertical_housing_bounded_half_small_top();
    
    // potentiometer support
   translate ([-48 / 2 + plate_body_size[0] / 2, plate_body_size[1] - 9 - 6 - 2, rbearing_608_vertical_housing_size_bounded_half_small[2] + wall_thick_3 + rbearing_608_vertical_housing_size_bounded_half_small_top[2]])  
    rotate ([-90, 0, 0]) 
    rotate ([0, 0, -90]) potentiometer_support_shoulder_vertical();
    
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
            translate ([-bone_thick / 2, 0, bone_length / 2 + body_holes_position[i]] - display_tolerance_x) rotate ([0, 90, 0]) cylinder (h = bone_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
        }
    }
}
//---------------------------------------------------------------------------
module arm(bone_length)
{
// vertical axis
    translate ([0, 0, wall_thick_3 + washer_8_thick + rb_608_thick]) rotate ([0, 0, angle_body_arm])  
    color (aluminium_color) body_arm_bone(bone_length);
        
    // reduction pulley
    translate ([0, 0, 0]) rotate([0, 0, angle_body_arm]) mirror ([0, 0, 1]) traction_pulley();
    
    // continuation
    translate ([0, 0, bone_length / 2 + plate_body_size[0] / 2 + 1.5]) rotate ([0, 0, angle_body_arm]) translate ([bone_thick / 2, -3 / 2 * bone_thick, 0]) rotate ([0, 90, 0]) body_articulation();
}
//---------------------------------------------------------------------------

arm(200);

//potentiometer_support_shoulder_vertical();

//motor_pulley();

//body_arm_bone(300);

//body_articulation();

//nema_17_housing_with_belt_tensioner_bearing_based_x_and_base_holes(20, 5);

//nema_11_housing_with_belt_tensioner_bearing_based_x_and_base_holes(15, 0);

//sholder_pulley();

//plate_body_articulation();

//shoulder_motor_housing();

//shoulder();
//upper_arm();

//forearm_pulley();
//forearm_motor_pulley();

//fore_arm();

//fore_arm_with_elbow_pulley();

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

//radial_bearing_608_vertical_housing_slim_double();

//rbearing_608_vertical_housing_bounded_half_small();
//rbearing_608_vertical_housing_bounded_half_small_top();

//body_stepper_motor_housing();

//pot_gear_with_screw_hole_14t();

//traction_pulley();

//elbow_potentiometer_support();

//gripper_c920_support_with_camera();
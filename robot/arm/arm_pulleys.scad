// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// License: MIT
//--------------------------------------------------------------

include <../../basic_scad/params_basic_components.scad>
include <../../basic_scad/params_pulleys.scad>
include <../../basic_scad/params_screws_nuts_washers.scad>

use <../../basic_scad/basic_components.scad>

include <../../basic_scad/material_colors.scad>

include <arm_params.scad>

use <../../basic_scad/pulleys.scad>
include <../../basic_scad/tolerance.scad>
use <../../basic_scad/point_transformations_3d.scad>


use <../../basic_scad/radial_bearings.scad>
use <../../basic_scad/screws_nuts_washers.scad>

use <arm_sensor_support.scad>
include <../../basic_scad/servos_params.scad>
include <gripper_params.scad>

//---------------------------------------------------------------------------
module upper_arm_rotation_pulley()
{
    shoulder_traction_pulley();
}
//---------------------------------------------------------------------------

module shoulder_traction_pulley()
{
    difference(){
               
        color (plastic_color) {
            union(){
                pulley(profile = "T5mm_pulley", num_teeth = 47, pulley_b_ht = 0, pulley_b_dia = 17, pulley_t_ht = printed_pulley_thick - 3);
                translate([0, 0, printed_pulley_thick]) cylinder (h = pulley_spacer_length, r = 19, $fn = 80);
            }
        }
        
        // wire holes
        translate (-display_tolerance_z) cylinder(h = printed_pulley_thick + pulley_spacer_length + 2 * display_tolerance, r = 14.5, $fn = 70);

        // shaft hole 
        translate ([-arm_shaft_size / 2 - 0.1, -arm_shaft_size / 2 - 0.1, 0] -display_tolerance_z) 
        cube([arm_shaft_size + 0.2, arm_shaft_size + 0.2, printed_pulley_thick + pulley_spacer_length + 2 * display_tolerance]);

        dist_to_nut = 17;

        // 1st screw hole
        for (i = [-1 : 2 : 1]){
            dist_to_1st_screw = i * 9;
            
            for (angle = [0: 90: 270])
            rotate([0, 0, angle]){
                translate ([-37, dist_to_1st_screw, printed_pulley_thick / 2]) rotate ([0, 90, 0]) cylinder(h = 30, r = m4_screw_radius, $fn = 20);
            // nut hole
                hull(){
                    translate ([-dist_to_nut - m4_nut_thick, dist_to_1st_screw, printed_pulley_thick / 2]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
                    translate ([-dist_to_nut - m4_nut_thick, dist_to_1st_screw, printed_pulley_thick + 6]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
                }
            }
        }        
  }
}
//---------------------------------------------------------------------------

module fore_arm_rotation_pulley()
{
    shoulder_traction_pulley();
}
//---------------------------------------------------------------------------
module shoulder_pulley()
{
    pulley_with_shaft("T5mm_pulley", 29, 0, 0, 8, 4, M8_nut_radius, M8_nut_thick);
}
//---------------------------------------------------------------------------

module elbow_pulley()
{
  difference(){
      union(){
         color (plastic_color) {
             pulley(profile = "T5mm_pulley", num_teeth = elbow_pulley_num_teeth, pulley_b_ht = 0, pulley_b_dia = 0, pulley_t_ht = elbow_pulley_thick - 3);
          
         }
      }
     
        // shaft hole
      translate ( -display_tolerance_z) cylinder( h = printed_pulley_thick + 2 * display_tolerance, r = rb_608_external_radius - 1, $fn = 50);

        // bearing hole  bottom  
      translate ([0, 0, printed_pulley_thick / 2 - 0.5 - rb_608_thick]) cylinder( h = rb_608_thick, r = rb_608_external_radius, $fn = 50);

        // bearing hole  top
      translate ([0, 0, printed_pulley_thick / 2 + 0.5]) cylinder( h = rb_608_thick, r = rb_608_external_radius, $fn = 50);
      

        for (i = [[-1, -1],  [-1, 1]]){//,  [-1, 0], [1, 0]
          //echo([i[0] * elbow_pulley_holes_dist_x + 6 + elbow_pulley_holes_dist_x + 12.5, i[1] * elbow_pulley_holes_dist_y, 0]);
          translate ([i[0] * elbow_pulley_holes_dist_x + 6 + elbow_pulley_holes_dist_x + 12.5, i[1] * elbow_pulley_holes_dist_y, 0] - display_tolerance_z) cylinder (h = printed_pulley_thick + 2 * display_tolerance, r = 2, $fn = 15);
          }
          
      for (i = [[-1, 0], [1, 0]]){  
      //    echo([i[0] * elbow_pulley_holes_dist_x + 6 + elbow_pulley_holes_dist_x + 12.5, i[1] * elbow_pulley_holes_dist_y, 0]);
          translate ([i[0] * elbow_pulley_holes_dist_x + 6 + elbow_pulley_holes_dist_x + 12.5, i[1] * elbow_pulley_holes_dist_y, 0] - display_tolerance_z) cylinder (h = printed_pulley_thick + 2 * display_tolerance, r = 1.5, $fn = 15);
      }
  }
}
//---------------------------------------------------------------------------
module elbow_pulley_with_magnet_support()
{
    elbow_pulley();
    translate ([elbow_pulley_holes_dist_x + 6 + elbow_pulley_holes_dist_x + 10, 0, 30 + 14]) mirror ([0, 0, 1]) rotate ([0, 0, 90]) magnet_support_elbow();
}
//---------------------------------------------------------------------------
module wrist_pulley()
{
  difference(){
    color (plastic_color)
             pulley(profile = "T5mm_pulley", num_teeth = wrist_pulley_num_teeth, pulley_b_ht = 0, pulley_b_dia = 0, pulley_t_ht = printed_pulley_thick - 3);
     
        // shaft hole
      translate ( -display_tolerance_z) cylinder( h = printed_pulley_thick + 2 * display_tolerance, r = rb_608_external_radius - 1, $fn = 50);

        // bearing hole  bottom  
      translate ([0, 0, printed_pulley_thick / 2 - 1 - rb_608_thick]) cylinder( h = rb_608_thick, r = rb_608_external_radius, $fn = 50);

        // bearing hole  top
      translate ([0, 0, printed_pulley_thick / 2 + 1]) cylinder( h = rb_608_thick, r = rb_608_external_radius, $fn = 50);
      
      // magnet support
      for (i = [[-1, 0], [1, 0]]){  
      //    echo([i[0] * elbow_pulley_holes_dist_x + 6 + elbow_pulley_holes_dist_x + 12.5, i[1] * elbow_pulley_holes_dist_y, 0]);
          // screw hole
          translate ([i[0] * elbow_pulley_holes_dist_x + 6 + elbow_pulley_holes_dist_x + arm_shaft_size / 2, i[1] * wrist_pulley_holes_dist_y, 0] - display_tolerance_z) cylinder (h = printed_pulley_thick + 2 * display_tolerance, r = m3_screw_radius, $fn = 15);
          }
          
          // servo hole
          rotate ([0, 0, gripper_servo_rotation]) translate ([0, distance_to_gripper_motor, 0] - display_tolerance_z) 
          translate([-1501MG_size[0] / 2, -1501MG_size[1] / 2, 0]) cube(1501MG_size);
          // servos screw holes
          for (i = [0 : 3]){
                rotate ([0, 0, gripper_servo_rotation]) translate (1501MG_screw_holes_position[i] + [0, distance_to_gripper_motor, 0]- display_tolerance_z)
                cylinder(h = printed_pulley_thick + 2 * display_tolerance, r = 1.5, $fn = 10);
            } 
            // servo wires hole
            rotate ([0, 0, gripper_servo_rotation]) 
          translate ([1501MG_size[0] / 2 - 0.1,  distance_to_gripper_motor - 2.5, 0] - display_tolerance_z) cube([7.5, 5, printed_pulley_thick] + 2 * display_tolerance_z);
            
       // hole for bearing supporting mobile fingers
            
          translate (fixed_finger_offset - display_tolerance_z) cylinder (h = printed_pulley_thick + 2 * display_tolerance, r = rb_626_external_radius - 1);
            
               // bearing hole bottom  
      translate (fixed_finger_offset - display_tolerance_z) cylinder( h = rb_626_thick + display_tolerance, r = rb_626_external_radius, $fn = 50);

        // bearing hole  top
      translate (fixed_finger_offset + [0, 0, printed_pulley_thick - rb_626_thick]) cylinder( h = rb_626_thick + display_tolerance, r = rb_626_external_radius, $fn = 50);
            
            // finger hole
             translate([6 + arm_shaft_size / 2 + 2, 0, printed_pulley_thick - 2]) hull(){
                cylinder(h = 2, r = mobile_finger_size[1] / 2);
                translate ([fixed_finger_size[0], 0, 0]) cylinder(h = 2, r = mobile_finger_size[1] / 2);
            }
  }
}
//---------------------------------------------------------------------------
module upper_arm_motor_pulley()
{
    pulley_with_shaft(profile = "T5mm_pulley", num_teeth = 15, pulley_b_ht = 0, pulley_b_dia = 0, pulley_t_ht = 11, shaft_radius = M8_screw_radius, nut_radius = 0, nut_height = 0);
    translate([-4, 3, 0]) cube([8, 2, 14]);
}
//---------------------------------------------------------------------------
module upper_arm_screw_rotation_pulley()
{
    difference(){
        color (plastic_color) 
        pulley_with_shaft(profile = "T5mm_pulley", num_teeth = 16, pulley_b_ht = 0, pulley_b_dia = 0, pulley_t_ht = 11, shaft_radius = M8_screw_radius, nut_radius = 0, nut_height = 0);
        
        translate ([0, 0, 11 + 3 - M8_nut_thick]) cylinder (h = M8_nut_thick, r = M8_nut_radius, $fn = 6) ;
    }
}
//---------------------------------------------------------------------------
module pulley_upper_arm_bone_for_sensor()
{
    difference(){
        color (plastic_color) 
        pulley(profile = "T2_5mm_pulley", num_teeth = 49, pulley_b_ht = 0, pulley_b_dia = 0, pulley_t_ht = 6);
        // bone hole
        translate ([-arm_shaft_size / 2 - 0.1, -arm_shaft_size / 2 - 0.1, 0] - display_tolerance_z) cube ([arm_shaft_size + 0.2, arm_shaft_size + 0.2, 9] + 2 * display_tolerance_z);
        // wire holes
        translate (-display_tolerance_z) cylinder(h = 6 + 3 + 2 * display_tolerance, r = 14, $fn = 70);
    }
}
//---------------------------------------------------------------------------
module pulley_upper_arm_sensor_shaft()
{
    difference(){
        color (plastic_color) 
        pulley(profile = "T2_5mm_pulley", num_teeth = 38, pulley_b_ht = 0, pulley_b_dia = 0, pulley_t_ht = 5.5);
        cylinder (h = 9, r = 4, $fn = 30);
        
        // screw hole
        translate ([0, 0, 4.5]) rotate([90, 0, 0]) cylinder (h = 20, r = m4_screw_radius);
        // nut hole
        hull(){
            translate ([0, -5, 4.5]) rotate([90, 30, 0]) M4_nut();
            translate ([0, -5, 9]) rotate([90, 30, 0]) M4_nut();
        }
    }
}
//---------------------------------------------------------------------------
//upper_arm_screw_rotation_pulley();
//upper_arm_motor_pulley();

//pulley_upper_arm_sensor_shaft();

//pulley_upper_arm_bone_for_sensor();

elbow_pulley();

//elbow_pulley_with_magnet_support();
//wrist_pulley();

//shoulder_traction_pulley();

//fore_arm_rotation_pulley();
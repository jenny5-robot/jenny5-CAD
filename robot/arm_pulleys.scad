// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_basic_components.scad>
include <../basic_scad/params_pulleys.scad>
include <../basic_scad/params_screws_nuts_washers.scad>

include <../basic_scad/config.scad>
include <../basic_scad/params_motor_housing.scad>

include <params_arm.scad>

use <../basic_scad/pulleys.scad>
include <../basic_scad/tolerance.scad>
use <../basic_scad/stepper_motors_housing.scad>
use <../basic_scad/point_transformations_3d.scad>
use <../basic_scad/potentiometer_support.scad>

use <arm_motor_housings.scad>


//---------------------------------------------------------------------------
module forearm_potentiometer_support()
{
    potentiometer_support_with_screw_holes(30, 30, 10, 29, 8);
}
//---------------------------------------------------------------------------
module upper_arm_motor_corner()
{
    nema_motor_housing_with_base_holes(motor_offset_x = 14, motor_offset_y = 0, nema_width = rbearing_608_housing_size[0], nema_height = 20, base_height = 13, nema_center_hole_radius = 5, nema_holes_position = rbearing_608_housing_holes_position, base_thick = 3, dist_to_base_holes_center_z = 18, nema_housing_base_holes_H_distance = undef, nema_housing_base_holes_V_distance = undef, motor_screw_holes_rotation_angle = 0, sunken_base_holes = 0, motor_play_x = 0);    
}
//---------------------------------------------------------------------------
module upper_arm_pulley()
{
    difference(){
        rotate ([0, 0, 0])         
           color (plastic_color) {
               pulley(profile = 56, num_teeth = 44, pulley_b_ht = 0, pulley_b_dia = 17, pulley_t_ht = 8);
                translate ([nema_17_with_19_1_gearbox_height / 2, -rbearing_608_housing_size[0] / 2 - 2, 8]) 
                rotate([0, -90, 0]){
      // bottom corner
                translate ([0, 0, rbearing_608_housing_size[2] + 6]) upper_arm_motor_corner();
    // top corner
                translate ([0, 0, -(rbearing_608_housing_size[2] + 6 - nema_17_with_19_1_gearbox_height)]) mirror ([0, 0, 1]) upper_arm_motor_corner();
  }
            }
        
        // middle hole
        translate(- display_tolerance_z) cylinder(h = upper_arm_gear_thick + 2 * display_tolerance, r = upper_arm_shaft_radius, $fn = 30);
        
        // holes for connecting 2 half pulleys
        // 1st screw hole
        dist_to_1st_screw = 19;
        
        dist_to_nut = 14;
        translate ([-30, dist_to_1st_screw, upper_arm_gear_thick / 2]) rotate ([0, 90, 0]) cylinder(h = 50, r = m4_screw_radius, $fn = 20);
        // 1 st screw head hole
        translate ([15, dist_to_1st_screw, upper_arm_gear_thick / 2]) rotate ([0, 90, 0]) cylinder(h = 30, r = 3.5, $fn = 20);
        // nut hole
        hull(){
            translate ([-dist_to_nut - m4_nut_thick, dist_to_1st_screw, upper_arm_gear_thick / 2]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
            translate ([-dist_to_nut - m4_nut_thick, dist_to_1st_screw, upper_arm_gear_thick]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
        }

        // 2nd screw hole
        
        translate ([-25, -dist_to_1st_screw, upper_arm_gear_thick / 2]) rotate ([0, 90, 0]) cylinder(h = 55, r = m4_screw_radius, $fn = 20);
        // screw head hole
        translate ([-40, -dist_to_1st_screw, upper_arm_gear_thick / 2]) rotate ([0, 90, 0]) cylinder(h = 17, r = 3.5, $fn = 20);
        // nut hole
        hull(){
            translate ([dist_to_nut, -dist_to_1st_screw, upper_arm_gear_thick / 2]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
            translate ([dist_to_nut, -dist_to_1st_screw, upper_arm_gear_thick]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
        }
  }
    
  //-16 - 8 - 5
}
//---------------------------------------------------------------------------
module upper_arm_pulley_half_1()
{
    difference(){
        upper_arm_pulley();
        translate ([-0.25, -40, -1]) cube([40, 100, 100]);
    }
}
//---------------------------------------------------------------------------
module upper_arm_pulley_half_2()
{
    difference(){
        upper_arm_pulley();
        translate ([-40, -40, -1]) cube([40.25, 100, 100]);
    }
}
//---------------------------------------------------------------------------
module shoulder_traction_pulley()
{
    difference(){
               
        color (plastic_color) pulley(profile = 56, num_teeth = 44, pulley_b_ht = 0, pulley_b_dia = 17, pulley_t_ht = 8);
        
        translate(- display_tolerance_z) cylinder(h = upper_arm_gear_thick + 2 * display_tolerance, r = shoulder_shaft_radius, $fn = 30);

        // 1st screw hole
        dist_to_1st_screw = 17;
        
        dist_to_nut = 14;
        translate ([-25, dist_to_1st_screw, upper_arm_gear_thick / 2]) rotate ([0, 90, 0]) cylinder(h = 50, r = m4_screw_radius, $fn = 20);
        // 1 st screw head hole
        translate ([15, dist_to_1st_screw, upper_arm_gear_thick / 2]) rotate ([0, 90, 0]) cylinder(h = 30, r = 3.5, $fn = 20);
        // nut hole
        hull(){
            translate ([-dist_to_nut - m4_nut_thick, dist_to_1st_screw, upper_arm_gear_thick / 2]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
            translate ([-dist_to_nut - m4_nut_thick, dist_to_1st_screw, upper_arm_gear_thick]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
        }

        // 2nd screw hole
        
        translate ([-29, -dist_to_1st_screw, upper_arm_gear_thick / 2]) rotate ([0, 90, 0]) cylinder(h = 55, r = m4_screw_radius, $fn = 20);
        // screw head hole
        translate ([-40, -dist_to_1st_screw, upper_arm_gear_thick / 2]) rotate ([0, 90, 0]) cylinder(h = 17, r = 3.5, $fn = 20);
        // nut hole
        hull(){
            translate ([dist_to_nut, -dist_to_1st_screw, upper_arm_gear_thick / 2]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
            translate ([dist_to_nut, -dist_to_1st_screw, upper_arm_gear_thick]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
        }
    
      
      // screw hole
      cylinder (h = 6, r = m8_nut_radius, $fn = 6);
      /*
        // motor housing fixer holes
      
      for (i = [0 : 3]){
          translate (nema_17_housing_small_base_holes_position[i] + [0, -0, 0] - display_tolerance_z) cylinder (h = 9 + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
          translate (nema_17_housing_small_base_holes_position[i] + [0, -0, 4] - display_tolerance_z) cylinder (h = 9 + 2 * display_tolerance, r = m4_nut_radius, $fn = 6);
      }
        */
  }
}
//---------------------------------------------------------------------
module forearm_pulley()
{
    difference(){
        pulley_base_height = 1.5;
        pulley_with_shaft(70, 35, 0, 0, 8, 12.5, m8_nut_radius, m8_nut_height);
        for (i = [1:4])
            translate ( nema_14_39BYGL215A_screw_hole_position[i]) cylinder (h = 11, r = 1.5, $fn = 10);
    }
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
      union(){
          pulley(profile = 71, num_teeth = 69, pulley_b_ht = 0, pulley_b_dia = 0, pulley_t_ht = 8);
          // motor housing
        translate ([distance_to_fore_arm_gear - 3, -belt_hole_forearm_pulley / 2 - 2, 3]) rotate ([0, 90, 0]) 
          forearm_motor_housing();
          // potentiometer support
        translate ([49, 15, 3]) rotate ([0, 90, 180]) forearm_potentiometer_support();
      }
     
        // bearing hole    
        translate ([0, 0, 0] - display_tolerance_z) cylinder( h = 11 + 2 * display_tolerance, r = rb_626_external_radius, $fn = 50);

        // cut hole for belt
        translate ([distance_to_fore_arm_gear, -belt_hole_forearm_pulley / 2, 0] - display_tolerance_z) cube([15, belt_hole_forearm_pulley, 20]);
        // holes for fixing the forearm
        // first bearing holes
        for (i= [0 : 1]){
            echo([fore_arm_x_offset, 0, 0] + rotate_z(90, rbearing_6905_enclosed_housing_holes_position[i]));
            translate ([fore_arm_x_offset, 0, 0] + rotate_z(90, rbearing_6905_enclosed_housing_holes_position[i]) - display_tolerance_z) cylinder (h = 11 + 2 * display_tolerance, r = 2, $fn = 30);
        }
  }
}
//---------------------------------------------------------------------------
module elbow_gear()
{// partial gear
    pot_gear(13, rb_626_external_radius, 10); 
}
//---------------------------------------------------------------------------


//upper_arm_pulley();

//upper_arm_pulley_half_1();
upper_arm_pulley_half_2();

//shoulder_traction_pulley();

//forearm_pulley();
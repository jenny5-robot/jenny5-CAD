// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
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

//---------------------------------------------------------------------------
module upper_arm_pulley()
{
    difference(){
        rotate ([0, 0, 2])         
           color (plastic_color) pulley(profile = 56, num_teeth = 44, pulley_b_ht = 0, pulley_b_dia = 17, pulley_t_ht = 8);
        
        
        // middle hole
        translate(- display_tolerance_z) cylinder(h = upper_arm_gear_thick + 2 * display_tolerance, r = upper_arm_shaft_radius, $fn = 30);

// holes for connecting the motor
        dist_x = 23;
        dist_y = 8;
        translate([dist_x, -dist_y, 0] - display_tolerance_z) cylinder(h = upper_arm_gear_thick + 2 * display_tolerance, r = 2, $fn = 10);
        translate([dist_x, dist_y, 0] - display_tolerance_z) cylinder(h = upper_arm_gear_thick + 2 * display_tolerance, r = 2, $fn = 10);
        translate([-dist_x, -dist_y, 0] - display_tolerance_z) cylinder(h = upper_arm_gear_thick + 2 * display_tolerance, r = 2, $fn = 10);
        translate([-dist_x, dist_y, 0] - display_tolerance_z) cylinder(h = upper_arm_gear_thick + 2 * display_tolerance, r = 2, $fn = 10);
        
        // holes for connecting 2 half pulleys
        // 1st screw hole
        dist_to_1st_screw = 17;
        
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
    
      
      // screw hole
      cylinder (h = 6, r = m8_nut_radius, $fn = 6);
      // motor housing fixer holes
      
      for (i = [0 : 3]){
          translate (nema_17_housing_small_base_holes_position[i] + [0, -0, 0] - display_tolerance_z) cylinder (h = 9 + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
          translate (nema_17_housing_small_base_holes_position[i] + [0, -0, 4] - display_tolerance_z) cylinder (h = 9 + 2 * display_tolerance, r = m4_nut_radius, $fn = 6);
      }
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
//upper_arm_pulley();

shoulder_traction_pulley();
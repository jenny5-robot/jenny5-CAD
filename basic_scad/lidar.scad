// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_stepper_motors.scad>
include <params_tera_ranger_one.scad>
include <params_basic_components.scad>
include <params_slip_rings.scad>
include <params_infrared_sensors.scad>
include <params_screws_nuts_washers.scad>

include <config.scad>

use <basic_components.scad>
use <tera_ranger_one.scad>
use <stepper_motors.scad>
use <buttons.scad>
use <stepper_motors_housing.scad>
use <slip_rings.scad>
use <pulleys.scad>


//---------------------------------------------------------------------
module tera_ranger_one_on_motor()
{
    nema_17();
    rotate ([0, 0, 90]) translate ([-tera_ranger_one_sizes[0] / 2, 5.5, nema_17_height + 5]) rotate ([90, 0, 0]){ 
      translate ([10, 40, -3]) rotate ([-90, 0, 0]) import("TR1_spider.stl");
      tera_ranger_one_support();
    }
    
    translate ([-nema_17_width / 2, -nema_17_width / 2, nema_17_height])
    button_on_support();
    
    translate ([-nema_17_width, nema_17_width - 2 * 9, 0]) rotate ([90, 0, 0]) nema_17_fixer();
}
//---------------------------------------------------------------------
module slip_ring_support()
{
    difference(){
        color (plastic_color) half_box(nema_17_width + 2 * wall_thick_2, 2 * SRC022A_6_flange_radius + wall_thick_2 + 10, 12, wall_thick_2, wall_thick_2, wall_thick_2);
        //screw holes
        for (i=[1:3])
            hull(){
                translate([nema_17_width / 2 + wall_thick_2, SRC022A_6_flange_radius + wall_thick_2 + 5, 0] - display_tolerance_z)
                    rotate([0, 0, 30]) translate(SRC022A_6_flange_holes_position[i])
                        cylinder(h = wall_thick_2 + 2 * display_tolerance, r = 2.75, $fn = 30);
                translate([nema_17_width / 2 + wall_thick_2, SRC022A_6_flange_radius + wall_thick_2 + 12, 0] - display_tolerance_z)
                    rotate([0, 0, 30]) translate(SRC022A_6_flange_holes_position[i])
                    cylinder(h = wall_thick_2 + 2 * display_tolerance, r = 2.75, $fn = 30);
            }
// stator
        hull(){
            translate([nema_17_width / 2 + wall_thick_2, SRC022A_6_flange_radius + wall_thick_2 + 5, 0] - display_tolerance_z)
                cylinder(h = wall_thick_2 + 2 * display_tolerance, r = SRC022A_6_stator_radius, $fn = 100);
                
            translate([nema_17_width / 2 + wall_thick_2, SRC022A_6_flange_radius + wall_thick_2 + 12, 0] - display_tolerance_z)
                cylinder(h = wall_thick_2 + 2 * display_tolerance, r = SRC022A_6_stator_radius, $fn = 100);
        }
// infrared sensor hole
        translate([-GP2Y0D805Z0F_size[0] / 2 + wall_thick_2 + nema_17_width / 2, 2, 0]- display_tolerance_z) cube([GP2Y0D805Z0F_size[0] - 5, GP2Y0D805Z0F_size[1], 2] + 2 * display_tolerance_z);
// infrared sensor screw hole
        translate([GP2Y0D805Z0F_size[0] / 2 + wall_thick_2 + nema_17_width / 2 - 2.5, 2 + GP2Y0D805Z0F_size[1] / 2, 0]- display_tolerance_z) cylinder (h = 2 + 2 * display_tolerance, r = 1, $fn = 10);
    }
}
//---------------------------------------------------------------------
module slip_ring_with_motor_support()
{
    slip_ring_support();
    
    translate([0, 2 * SRC022A_6_flange_radius + wall_thick_2 + 10 + 20, 0]) 
        mirror([0, 1, 0]) 
            difference(){
                color (plastic_color) half_box(nema_17_width + 2 * wall_thick_2, 20 + wall_thick_2, 12, wall_thick_2, wall_thick_2, wall_thick_2);
                translate([nema_17_width / 2 + wall_thick_2, - nema_17_width / 2 + 20, 0] - display_tolerance_z){
                    for (i=[1:4])
                        translate(gauri_nema_17[i])
                            cylinder(h = wall_thick_2 + 2 * display_tolerance, r = 1.5, $fn = 30);
                    // center hole
                    translate(gauri_nema_17[0])
                        cylinder(h = wall_thick_2 + 2 * display_tolerance, r = nema_17_motor_hole_radius_camiel, $fn = 30);
                }
            }
}
//---------------------------------------------------------------------
module tera_ranger_one_lidar()
{
  nema_17();

    translate ([nema_17_width / 2 + wall_thick_2, 2 * SRC022A_6_flange_radius + wall_thick_2 + 30 + 1, nema_17_height + wall_thick_2]) rotate ([0, 0, 180]) mirror([0, 0, 1]) slip_ring_with_motor_support();
    
    translate ([0, SRC022A_6_flange_radius + wall_thick_2 + 20, nema_17_height + wall_thick_2 - SRC022A_6_stator_length + SRC022A_6_flange_thickness]) rotate([0, 0, -30]) SRC022A_6();
    
    rotate ([0, 0, 90]) 
        translate ([-tera_ranger_one_sizes[0] / 2 + SRC022A_6_flange_radius + wall_thick_2 + 20, 5.5, nema_17_height + 7]) 
            rotate ([90, 0, 0]){ 
                translate ([10, 50, -3]) rotate ([-90, 0, 0]) import("TR1_spider.stl");
                translate ([0, -2, 0]) tera_ranger_one_support();
            }
    
    // pulley
    translate ([0, SRC022A_6_flange_radius + wall_thick_2 + 20, nema_17_height + 7]) 
        tera_ranger_support_pulley();
            
            // motor pulley
            translate ([0, 0, nema_17_height + 7]) 
            lidar_motor_pulley();
}
//---------------------------------------------------------------------
module tera_ranger_support_pulley()
{
    difference(){
        pulley(24, 30, 0, 0, 6);
        // hole for LIDAR support
        translate ([-6, -6, 0] - display_tolerance_z) cube([12, 12, 12]);
// screw
        translate([0, 0, 4.5]) rotate([0, 90, 0]) cylinder (h = 15, r = 2, $fn = 20);
        // nut
        translate([6, 0, 4.5]) rotate([0, 90, 0]) cylinder (h = m4_nut_thick, r = m4_nut_radius + 0.2, $fn = 6);

    }
}
//---------------------------------------------------------------------
module lidar_motor_pulley()
{
    difference(){
        pulley_with_shaft(24, 30, 0, 0, 6, 2.5);
        
// screw hole
        translate([0, 0, 4.5]) rotate([0, 90, 0]) cylinder (h = 15, r = 2, $fn = 20);
        // nut hole
        hull(){
          translate([6, 0, 4.5]) rotate([0, 90, 0]) cylinder (h = m4_nut_thick, r = m4_nut_radius + 0.2, $fn = 6);
          translate([6, 0, 0]) rotate([0, 90, 0]) cylinder (h = m4_nut_thick, r = m4_nut_radius + 0.2, $fn = 6);
        }
    }
}
//---------------------------------------------------------------------
module IR_obstacle()
{
    difference(){
        cube([15, 10, 5]);
        translate (-display_tolerance_z) translate ([0, 3.5, 0]) cube([10, 3, 5] + 2 * display_tolerance_z);
        translate ([5, 0, 2.5]) rotate ([-90, 0, 0]) cylinder (h = 10, r = 1.25, $fn = 10);
    }
}
//---------------------------------------------------------------------

tera_ranger_one_lidar();

//IR_obstacle();

//tera_ranger_support_pulley();

//lidar_motor_pulley();

//slip_ring_support();

//slip_ring_with_motor_support();

//tera_ranger_one_on_motor();
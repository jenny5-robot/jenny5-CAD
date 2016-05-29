// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_basic_components.scad>
include <../basic_scad/params_screws_nuts_washers.scad>
include <params_robot.scad>
include <../basic_scad/params_dc_motor.scad>
include <../basic_scad/config.scad>
use <../basic_scad/basic_components.scad>
use <../basic_scad/dc_motors.scad>

use <MCAD/involute_gears.scad>

//use <../basic_scad/Thread_Library.scad>

//---------------------------------------------------------------------------
module gripper_finger()
{
    color (plastic_color){
        inaltime = motor_length + 2 * (2 + m3_screw_radius + 2);
        
        cube([motor_height, motor_width / 2, 2 + m3_screw_radius + 2]);
        translate ([0, motor_width / 2, 0]) cube([motor_height, 3, inaltime]);
        // aripioara prindere motor
       // translate ([-3, motor_width / 2, 0]) cube([3, 15, inaltime]);
        difference(){
            translate ([-3, motor_width / 2, inaltime / 2]) rotate ([0, 90, 0]) rotate ([0, 0, 90]) half_cylinder(3, inaltime / 2, 30);
            //rotate ([]) cylinder (h = 3 + 2 * display_tolerance, r = m3_screw_radius, $fn  
        }
        // aripioara prindere finger
        translate ([motor_height - 3, motor_width / 2, 0]) cube([3, 35, inaltime]);
        // baza tragere
        translate ([35, 0, 0]) cube([5, 15, inaltime]);
        // exterior deget
        translate ([motor_height - 1, motor_width / 2 + 34, 0]) rotate([0, 0, -22])cube([100, 1, inaltime]);
        // interior deget
        translate ([39, 14, 0]) rotate([0, 0, -9])cube([80, 1, inaltime]);
    }
    
}
//---------------------------------------------------------------------------
module gripper()
{
    dc_motor();
    // prelungine ax
    
    translate ([0, 0, motor_height + motor_shaft_length]) cylinder (h = 20, r = m3_screw_radius, $fn = 20);
    // degete
    // left
    translate ([motor_length, 0, 0])
    rotate ([0, -90, 0]) gripper_finger();
    // right
    translate ([motor_length, 0, 0])
    mirror ([0, 1, 0]) rotate ([0, -90, 0]) gripper_finger();
}
//---------------------------------------------------------------------------
module gripper_motor_holder()
{
    grosime_perete = 3;
    motor_diameter = 17.3;
    lungime = grosime_perete + m4_nut_thick  + 1 + bone_thick + 1 + motor_diameter + m4_nut_thick + grosime_perete;
    grosime = 15;
    latime = motor_diameter + 2 * grosime_perete;
   
    difference(){
        union(){
            cube([lungime, latime, grosime]);
        }
        // gaura os
        translate([grosime_perete + m4_nut_thick, latime / 2 - bone_thick/2 - 0.2, 0] - display_tolerance_z) cube([bone_thick + 0.3, bone_thick + 2 * 0.2, grosime] + 2 * display_tolerance_z);
        // gaura motor
        translate([grosime_perete + m4_nut_thick  + 2 + bone_thick + 1 + motor_diameter / 2, latime / 2, 0] - display_tolerance_z) cylinder (h = grosime + 2 * display_tolerance, r = motor_diameter / 2, $fn = 50);        
        // M4 bone screw hole
        translate([grosime_perete + m4_nut_thick + bone_thick / 2, 0, grosime / 2]) rotate([-90, 0, 0]) cylinder (h = 10, r = m4_screw_radius, $fn = 30);
        translate([grosime_perete + m4_nut_thick + bone_thick / 2, 2.5, grosime / 2]) rotate([-90, 0, 0]) rotate ([0, 0, 30]) cylinder (h = m4_nut_thick + 1, r = m4_nut_radius, $fn = 6);
        // M4 motor screw hole
        translate([lungime - (m4_nut_thick + grosime_perete), latime / 2, grosime / 2] - display_tolerance_x) rotate([0, 90, 0]) cylinder (h = 10, r = m4_screw_radius, $fn = 30);
        translate([lungime - (m4_nut_thick + grosime_perete), latime / 2, grosime / 2]) rotate([0, 90, 0]) cylinder (h = m4_nut_thick + 0.5, r = m4_nut_radius, $fn = 6);
    }
}
//---------------------------------------------------------------------------
/*
module gripper_motor_holder_with_C920_holder()
{
    grosime_perete = 3;
    motor_diameter = 17.3;
    lungime = grosime_perete + m4_nut_thick  + 1 + bone_thick + motor_diameter + m4_nut_thick + grosime_perete;
    grosime = 15;
    latime = motor_diameter + 2 * grosime_perete;
    
    dist_between_holes = 64.25;

    lungime_holder = 75;

    union(){
      gripper_motor_holder();
        
      translate([-(lungime_holder - lungime) / 2, latime - 0.1, 0]) 
        difference(){
            
        cube([lungime_holder, 3, grosime]);
// holes for fixing the camera
            translate ([lungime_holder / 2 - dist_between_holes / 2, 0, 5] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h = 3 + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
            translate ([lungime_holder / 2 + dist_between_holes / 2, 0, 5] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h = 3 + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
        }
    }
}
*/
//---------------------------------------------------------------------------
module gripper_motor_holder_with_C920_holder()
{
    grosime_perete = 3;
    motor_diameter = 17.3;
    lungime_prindere_os = grosime_perete + m4_nut_thick  + 1 + bone_thick + motor_diameter + m4_nut_thick + grosime_perete;
     
    grosime = 20;
    latime = motor_diameter + 2 * grosime_perete;
    
    dist_between_holes = 64.25;

    lungime_holder = 75;
    
    lungime_ir = 45;
    grosime_ir = 13;
    
    grosime_gripper_holder = 15;
    
    dist_between_ir_holes = 37;

    union(){
      rotate ([0, 0, -90]) gripper_motor_holder();
        // ir suppport
        translate([-(lungime_ir - latime) / 2, -0.1, 0]) 
        difference(){
            
        cube([lungime_ir, grosime_ir, grosime_gripper_holder]);
// holes for fixing the camera
            translate ([lungime_ir / 2 - dist_between_ir_holes / 2, grosime_ir / 2, 0] - display_tolerance_z) cylinder (h = grosime_gripper_holder + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
            translate ([lungime_ir / 2 + dist_between_ir_holes / 2, grosime_ir / 2, 0] - display_tolerance_z) cylinder (h = grosime_gripper_holder + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
        }
       
      translate([-(lungime_holder - latime) / 2, grosime_ir -0.1, 0]) 
        difference(){
            
        cube([lungime_holder, 3, grosime]);
// holes for fixing the camera
            translate ([lungime_holder / 2 - dist_between_holes / 2, 0, 7] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h = 3 + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
            translate ([lungime_holder / 2 + dist_between_holes / 2, 0, 7] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h = 3 + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
        }
    }
}
//---------------------------------------------------------------------------


//gripper_motor_holder();
//gripper_motor_holder_with_C920_holder();
//gripper_finger();
gripper();




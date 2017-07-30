// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_basic_components.scad>
use <../basic_scad/basic_components.scad>

include <../basic_scad/config.scad>

include <params_body.scad>
include <../basic_scad/params_screws_nuts_washers.scad>
use <../basic_scad/screws_nuts_washers.scad>
include <../basic_scad/params_radial_bearings.scad>

use <../basic_scad/stepper_motors.scad>

include <../basic_scad/params_stepper_motors.scad>

use <../basic_scad/radial_bearing_housing.scad>

include <../basic_scad/params_potentiometers.scad>
use <../basic_scad/potentiometers.scad>
use <../basic_scad/point_transformations_3d.scad>

include <../basic_scad/params_alu_profiles.scad>

include <../basic_scad/params_breadboards.scad>
use <../basic_scad/breadboards.scad>

include <params_arm.scad>
use <arm.scad>

use <../basic_scad/alu_profiles.scad>

use <../basic_scad/belt.scad>
use <../basic_scad/belt_tensioner.scad>
include <../basic_scad/params_belt_tensioner.scad>

use <../basic_scad/thrust_bearing_housing.scad>
include <../basic_scad/params_thrust_bearing_housing.scad>

include <../basic_scad/params_thrust_bearings.scad>

use <../basic_scad/thrust_bearings.scad>

use <../basic_scad/linear_motors.scad>


include <../basic_scad/params_pulleys.scad>
use <../basic_scad/pulleys.scad>
use <../basic_scad/bearing_housing_pot_support.scad>

//---------------------------------------------------------------------------
module vertebral_column()
{   
    alu_sigma_profile_30x30(vertebral_column_size[2]);
}
//---------------------------------------------------------------------------
module bearing_housing_top_body()
{
  radial_bearing_housing_with_potentiometer_support(rbearing_6001_housing_size, rbearing_6001_housing_holes_position, rb_6001_external_radius, rb_6001_thick, rbearing_6001_housing_size[2] + 4, m4_screw_radius, 25);
}
//---------------------------------------------------------------------------
module clavicle_bone()
{
    echo("clavicule length", body_width);
    echo("L profile 40x20mm, 3mm thick");
    difference(){
        color (aluminium_color) 
        //L_profile(body_width, L_profile_40x20_short_size, clavicule_size[0], alu_sheet_3_thick); 
        rotate ([-90, 0, 0]) rectangular_tube(50, 30, 3, body_width);
        echo("clavicule bone bearing housing holes = ");
        for (i = [1 : 4]){
            echo([clavicule_size[0] / 2, dist_edge_to_body_shaft, 0] + rbearing_6001_housing_holes_position[i], "radius = 2");
            translate ([clavicule_size[0] / 2, dist_edge_to_body_shaft, 0] + rbearing_6001_housing_holes_position[i] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        }
        /*
// shaft hole
            echo([clavicule_size[0] / 2, dist_edge_to_body_shaft, 0] + rbearing_6001_housing_holes_position[0], "radius = 10 (approx)");
            translate ([clavicule_size[0] / 2, dist_edge_to_body_shaft, 0] + rbearing_6001_housing_holes_position[0] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 10, $fn = 30);
*/
        echo("clavicule bone bearing housing holes = the same as the other side!");
        for (i = [1 : 4]){
            translate ([clavicule_size[0] / 2, body_width - dist_edge_to_body_shaft, 0] + rbearing_6001_housing_holes_position[i] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        }
        /*
// shaft hole
        echo([clavicule_size[0] / 2, body_width - dist_edge_to_body_shaft, 0] + rbearing_6001_housing_holes_position[0], "radius = 10 (approx)");
        translate ([clavicule_size[0] / 2, body_width - dist_edge_to_body_shaft, 0] + rbearing_6001_housing_holes_position[0] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 10, $fn = 30);
        */
        // holes for vertebral column screws
        echo("holes for vertebral column screws");
        echo([clavicule_size[0] / 2, body_width / 2, 0] + sigma_profile_holes[0], "radius=", 4);
        translate ([clavicule_size[0] / 2, body_width / 2, 0] + sigma_profile_holes[0] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 4, $fn = 20);
        
        for (i = [1 : 4]){
          echo([clavicule_size[0] / 2, body_width / 2, 0] + sigma_profile_holes[i], "radius = 2");
          translate ([clavicule_size[0] / 2, body_width / 2, 0] + sigma_profile_holes[i] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 2, $fn = 20);
        }

        // head holes
        echo("head holes = ");
          echo([clavicule_size[0] / 2, body_width / 2 - 30, 0], "radius = 2");
          translate ([clavicule_size[0] / 2, body_width / 2 - 30, 0] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 2, $fn = 20);

          echo([clavicule_size[0] / 2, body_width / 2 + 30, 0], "radius = 2");
          translate ([clavicule_size[0] / 2, body_width / 2 + 30, 0] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 2, $fn = 20);
        
    }
}
//---------------------------------------------------------------------------
module clavicle_with_pieces()
{
    clavicle_bone();
    // bearing housing top - left
    translate ([clavicule_size[0] / 2, body_width - dist_edge_to_body_shaft, rbearing_6001_housing_size[2] + 7]) rotate ([0, 0, -90])mirror ([0,0,1]) rbearing_6001_double_housing_with_potentiometer_support();
    
        // bearing housing top - right
    translate ([clavicule_size[0] / 2, dist_edge_to_body_shaft, rbearing_6001_housing_size[2] + 7]) rotate([0, 0, 90]) mirror ([0,0,1]) rbearing_6001_double_housing_with_potentiometer_support();
    
    // top potentiometer
    translate ([clavicule_size[0] / 2, dist_edge_to_body_shaft + 30, rbearing_6001_housing_size[2] + 7 - pot_92R1A_J22_L15L_base_height - 2]) rotate([0, 0, 90]) 
    potentiometer_92R1A_J22_L15L();
}
//---------------------------------------------------------------------------
module diafragma_bone()
{
    echo("Diafragma length", body_width);
    echo("L profile 40x20mm, 3mm thick");

    difference(){
        color (aluminium_color) 
        //L_profile(body_width, L_profile_40x20_short_size, clavicule_size[0], alu_sheet_3_thick);
        rotate ([-90, 0, 0]) rectangular_tube(50, 30, 3, body_width);
        // left axis bearing housing hole
        echo("diafragma bone bearing holes (left) = ");

// middle hole
        echo([clavicule_size[0] / 2, dist_edge_to_body_shaft, 0] + rbearing_6001_housing_holes_position[0], "radius = 10");
        translate ([clavicule_size[0] / 2, dist_edge_to_body_shaft, 0] + rbearing_6001_housing_holes_position[0] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 10, $fn = 30);
// screw holes
        for (i = [1 : 4]){
            echo([clavicule_size[0] / 2, dist_edge_to_body_shaft, 0] + rbearing_6001_housing_holes_position[i], "radius = 2");
            translate ([clavicule_size[0] / 2, dist_edge_to_body_shaft, 0] + rbearing_6001_housing_holes_position[i] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        }
        // right axis bearing housing hole
        echo("diafragma bone bearing holes (right) = the same as left side!");

        translate ([clavicule_size[0] / 2, body_width - dist_edge_to_body_shaft, 0] + rbearing_6001_housing_holes_position[0] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 10, $fn = 30);

        for (i = [1 : 4]){
            translate ([clavicule_size[0] / 2, body_width - dist_edge_to_body_shaft, 0] + rbearing_6001_housing_holes_position[i] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);
        }
    // motor holes

        echo("diafragma left motor holes = ");

        echo([alu_sheet_3_thick + nema_17_motor_gearbox_radius + 1, dist_edge_to_body_shaft + dist_between_motor_and_axis, 0] + gearbox_nema_17_holes_position[0], "radius = ", gearbox_nema_17_holes_radius[0]);
        for (i = [1 : 4])
            echo([alu_sheet_3_thick + nema_17_motor_gearbox_radius + 1, dist_edge_to_body_shaft + dist_between_motor_and_axis, 0] + gearbox_nema_17_holes_position[i], "radius = ", gearbox_nema_17_holes_radius[i]);
        
        translate ([alu_sheet_3_thick + nema_17_motor_gearbox_radius + 1, dist_edge_to_body_shaft + dist_between_motor_and_axis, 0] - display_tolerance_z) {
          translate (gearbox_nema_17_holes_position[0]) cylinder(h = 3 + 2 * display_tolerance, r = gearbox_nema_17_holes_radius[0]);
          for (i = [1 : 4])
            translate (gearbox_nema_17_holes_position[i]) cylinder(h = 3 + 2 * display_tolerance, r = gearbox_nema_17_holes_radius[i]);
        }
     // the right side
        // motor holes
                
        echo("diafragma right motor holes = the same as the other side");
        translate ([alu_sheet_3_thick + nema_17_motor_gearbox_radius + 1, body_width - (dist_edge_to_body_shaft + dist_between_motor_and_axis), 0] - display_tolerance_z) {
          translate (gearbox_nema_17_holes_position[0]) cylinder(h = 3 + 2 * display_tolerance, r = gearbox_nema_17_holes_radius[0]);
          for (i = [1 : 4])
            translate (gearbox_nema_17_holes_position[i]) cylinder(h = 3 + 2 * display_tolerance, r = gearbox_nema_17_holes_radius[i]);
        }
        
        // holes for vertebral column screws
        echo("holes for vertebral column screws");
        echo([clavicule_size[0] / 2, body_width / 2, 0] + sigma_profile_holes[0], "radius = 4");
        translate ([clavicule_size[0] / 2, body_width / 2, 0] + sigma_profile_holes[0] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 4, $fn = 20);
        
        for (i = [1 : 4]){
          echo([clavicule_size[0] / 2, body_width / 2, 0] + sigma_profile_holes[i], "radius = 2");
          translate ([clavicule_size[0] / 2, body_width / 2, 0] + sigma_profile_holes[i] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 2, $fn = 20);
        } 
        
        // holes for thrust bearing housing
        echo("holes for thrust bearing housing");
        for (i = [0 : 3]){
          echo([clavicule_size[0] / 2, body_width / 2, 0] + rotate_z(90,thrust_bearing_housing_51105_holes[i]), "radius = 2");

          translate ([clavicule_size[0] / 2, body_width / 2, 0] - display_tolerance_z) rotate([0, 0, 90]) translate (thrust_bearing_housing_51105_holes[i]) cylinder (h = alu_sheet_3_thick + 2 * display_tolerance, r = 2, $fn = 10);
        }
//hole for M6 screw for push
        echo("hole for M6 screw for push", [alu_sheet_3_thick + 15, body_width / 2 + 55, 0], "radius = 3");
        translate ([alu_sheet_3_thick + 15, body_width / 2 + 55, 0] - display_tolerance_z) cylinder (h = alu_sheet_3_thick + 2 * display_tolerance, r = 3, $fn = 20);
        
        // belt tensioner left side
        echo("belt tensioner holes");
        echo([clavicule_size[0] - belt_tensioner_external_size[1] / 2, dist_to_belt_tensioner - belt_tensioner_external_size[0] / 2, 0], "radius = 2");
        echo([clavicule_size[0] - belt_tensioner_external_size[1] / 2, dist_to_belt_tensioner + belt_tensioner_external_size[0] / 2, 0], "radius = 2");
        translate([clavicule_size[0] - belt_tensioner_external_size[1] / 2, dist_to_belt_tensioner - belt_tensioner_external_size[0] / 2, 0] - display_tolerance_z) cylinder (h = alu_sheet_3_thick + 2 * display_tolerance, r = 2, $fn = 20);
        translate([clavicule_size[0] - belt_tensioner_external_size[1] / 2, dist_to_belt_tensioner + belt_tensioner_external_size[0] / 2, 0] - display_tolerance_z) cylinder (h = alu_sheet_3_thick + 2 * display_tolerance, r = 2, $fn = 20);
// belt tensioner holes; right side
        translate([clavicule_size[0] - belt_tensioner_external_size[1] / 2, body_width - (dist_to_belt_tensioner - belt_tensioner_external_size[0] / 2), 0] - display_tolerance_z) cylinder (h = alu_sheet_3_thick + 2 * display_tolerance, r = 2, $fn = 20);
        translate([clavicule_size[0] - belt_tensioner_external_size[1] / 2, body_width - (dist_to_belt_tensioner + belt_tensioner_external_size[0] / 2), 0] - display_tolerance_z) cylinder (h = alu_sheet_3_thick + 2 * display_tolerance, r = 2, $fn = 20);
    }
}
//---------------------------------------------------------------------------
module diafragma_with_pieces()
{
    mirror([0, 0, 1]) diafragma_bone();
    
    // bearing housing
    translate ([clavicule_size[0] / 2, dist_edge_to_body_shaft, clavicule_size[1] + rbearing_6001_housing_size[2] + rb_6001_thick]) mirror([0, 0, 1]) rbearing_6001_double_housing_with_bearings();
    // motor
   /*
    translate ([alu_sheet_3_thick + nema_17_motor_gearbox_radius + 1, dist_edge_to_body_shaft + dist_between_motor_and_axis, -nema_17_with_19_1_gearbox_height - alu_sheet_3_thick]) nema_17_with_19_1_gearbox();
  */
    translate ([alu_sheet_3_thick + nema_17_motor_gearbox_radius + 1, body_width / 2 - 60, +nema_17_with_19_1_gearbox_height + alu_sheet_3_thick]) mirror([0, 0, 1]) nema_17_with_19_1_gearbox();
    
    
    // motor gear
    translate ([alu_sheet_3_thick + nema_17_motor_gearbox_radius + 1, dist_edge_to_body_shaft + dist_between_motor_and_axis, 0 + 7]) motor_pulley_8mm_shaft();
    
    // belt tensioner
    //translate ([clavicule_size[0] - belt_tensioner_external_size[1] / 2, dist_to_belt_tensioner - belt_tensioner_external_size[0] / 2, 0]) rotate([0, 0, 90]) belt_tensioner_external_with_bearings();
    
    // other side
    // bearing housing
    translate ([clavicule_size[0] / 2, body_width - dist_edge_to_body_shaft, alu_sheet_3_thick]) rbearing_6001_double_housing_with_bearings();
    // motor
    translate ([alu_sheet_3_thick + nema_17_motor_gearbox_radius + 1, body_width - (dist_edge_to_body_shaft + dist_between_motor_and_axis), -nema_17_with_19_1_gearbox_height - alu_sheet_3_thick]) nema_17_with_19_1_gearbox();
  
    // motor gear
    translate ([alu_sheet_3_thick + nema_17_motor_gearbox_radius + 1, body_width - (dist_edge_to_body_shaft + dist_between_motor_and_axis), +7]) motor_pulley_8mm_shaft();
    
    // belt tensioner
   // translate ([clavicule_size[0] - belt_tensioner_external_size[1] / 2, body_width - (dist_to_belt_tensioner + belt_tensioner_external_size[0] / 2), 0]) rotate([0, 0, 90]) belt_tensioner_external_with_bearings();

    //M6 screw for push
    translate ([alu_sheet_3_thick + 15, body_width / 2 + 55, 4]) mirror([0, 0, 1]) M6_hexa_screw(40);
}
//---------------------------------------------------------------------------
module body_rotation_sheet()
{
    difference(){
      color(aluminium_color)
        cube(body_rotation_sheet_size);
        // hole for motor screw
        translate ([body_rotation_sheet_size[0] / 2, 13, 0] - display_tolerance_z) cylinder(h = 10 + 2 * display_tolerance, r = 3);
        // hole for fixer screw
        translate ([body_rotation_sheet_size[0] / 2, body_rotation_sheet_size[1] - 37 / 2, 0] - display_tolerance_z) cylinder(h = 10 + 2 * display_tolerance, r = 5);
        
        // holes for thrust bearing housing
        for (i = [0 : 3])
            translate ([body_rotation_sheet_size[0] / 2, body_rotation_sheet_size[1] - 37 / 2, 0] + thrust_bearing_housing_51105_holes[i] - display_tolerance_z) cylinder (h = 10 + 2 * display_tolerance, r = 2);
    }
}
//---------------------------------------------------------------------------
module body_arm_bone(bone_length)
{
    echo("body arm bone length = ", bone_length);
    
    cylinder_empty(bone_length, body_shaft_radius, 4);
}
//---------------------------------------------------------------------------
module body_arm_traction_pulley()
{
    difference(){
        rotate ([0, 0, 2]) pulley(profile = 60, num_teeth = 33, pulley_b_ht = 0, pulley_b_dia = 0, pulley_t_ht = 8);
        translate(- display_tolerance_z) cylinder(h = 11 + 2 * display_tolerance, r = body_shaft_radius, $fn = 30);

        // 1st screw hole
        dist_to_1st_screw = 15;
        translate ([-17, dist_to_1st_screw, 5.5]) rotate ([0, 90, 0]) cylinder(h = 35, r = m4_screw_radius, $fn = 20);
        // 1 st screw head hole
        translate ([12, dist_to_1st_screw, 5.5]) rotate ([0, 90, 0]) cylinder(h = 20, r = 3.5, $fn = 20);
        // nut hole
        hull(){
            translate ([-9 - m4_nut_thick, dist_to_1st_screw, 5.5]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
            translate ([-9 - m4_nut_thick, dist_to_1st_screw, 11]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
        }

        // 2nd screw hole
        
        translate ([-15, -dist_to_1st_screw, 5.5]) rotate ([0, 90, 0]) cylinder(h = 31, r = m4_screw_radius, $fn = 20);
        translate ([-30, -dist_to_1st_screw, 5.5]) rotate ([0, 90, 0]) cylinder(h = 17, r = 3.5, $fn = 20);
        // nut hole
        hull(){
            translate ([9, -dist_to_1st_screw, 5.5]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
            translate ([9, -dist_to_1st_screw, 11]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
        }
    }
}
//---------------------------------------------------------------------------
module half_1_traction_pulley()
{
    difference(){
        body_arm_traction_pulley();
        translate ([0, -30, 0] - display_tolerance_z) cube([30, 60, 11] + 2 * display_tolerance_z);
    }
}
//---------------------------------------------------------------------------
module half_2_traction_pulley()
{
    difference(){
        body_arm_traction_pulley();
        translate ([-30, -30, 0] - display_tolerance_z) cube([30, 60, 11] + 2 * display_tolerance_z);
    }
}
//---------------------------------------------------------------------------
module body()
{
    // bottom 
    translate ([-body_width / 2, 0, 0]) 
        rotate ([0, 0, -90]) 
            diafragma_with_pieces();
    // top 
    translate ([-body_width / 2, 0, body_height - clavicule_size[1]]) 
        rotate ([0, 0, -90]) 
            mirror([0, 0, 1])
                clavicle_with_pieces();

// vertebral column
    translate ([0, -clavicule_size[0] / 2, 3]) vertebral_column();
    
    // left arm
    translate ([-(body_width / 2 -dist_edge_to_body_shaft), -clavicule_size[0] / 2, 0]) {

    // vertical axis
        translate([0, 0, -11 - 4])
            color ("black") body_arm_bone(body_arm_shaft_length);
        
    // traction pulley
        translate ([0, 0, -11 - 4]) rotate([0, 0, angle_body_arm]) body_arm_traction_pulley();
    }
        
    // belt left arm
    translate ([-body_width / 2 + rbearing_6001_housing_size[0] / 2, -clavicule_size[0] / 2, -4 - 8]) rotate([0, 0, 0]) belt_on_2_pulleys(25.8, 11.5, 89, 6);
    
    echo ("belt length = ", length_belt_on_2_pulleys(25.8, 11.5, 89, 6));
    
    translate ([(body_width / 2 -dist_edge_to_body_shaft), -clavicule_size[0] / 2, 0]){
        translate([0, 0, -11 - 4])
          color ("black") body_arm_bone(body_arm_shaft_length);
        
    // traction pulley
        translate ([0, 0, -11 - 4]) rotate([0, 0, angle_body_arm]) body_arm_traction_pulley();
    }
    // breadboard for arms
    translate ([0, -clavicule_size[0] / 2 - vertebral_column_size[0] / 2, vertebral_column_size[2] / 2 - arms_breadboard_size[1] / 2]) rotate([0, 0, -180]) arms_breadboard();
    // top thrust bearing housing
    translate ([0, -thrust_bearing_housing_51105_size[1] / 2 - alu_sheet_3_thick, 0]) mirror([0, 0, 1]) thrust_bearing_housing_51105();
}    
//---------------------------------------------------------------------------
module body_with_rotation(linear_motor_position)
{
    translate ([0, -(alu_sheet_3_thick + 37 / 2), 0]) rotate ([0, 0, 0]) translate ([0, alu_sheet_3_thick + 37 / 2, 0]) body();
    // bottom thrust bearing housing
    translate ([0, -thrust_bearing_housing_51105_size[1] / 2 - alu_sheet_3_thick, - thrust_bearing_housing_51105_thin_size[2] - thrust_bearing_housing_51105_size[2] - tb_51105_height + 2 * thrust_bearing_depth]) thrust_bearing_housing_51105_small();
    
    //bottom thrust bearing
    translate ([0, -thrust_bearing_housing_51105_size[1] / 2 - alu_sheet_3_thick, - thrust_bearing_housing_51105_size[2] - tb_51105_height + thrust_bearing_depth])
        thrust_bearing_51105();
    
    // sheet
    translate ([-30, -body_rotation_sheet_size[1] - alu_sheet_3_thick, - thrust_bearing_housing_51105_size[2] - thrust_bearing_housing_51105_thin_size[2] - tb_51105_height + 2 * thrust_bearing_depth - 10])
    body_rotation_sheet();
    
    // linear motor
    translate ([0, -190, -10]) rotate ([0, 0, -18]) rotate ([-90, 0, 0]) linear_dc_motor(50, linear_motor_position);
    
    // screw for linear motor base
    translate ([0, -190, -62]) M6_hexa_screw(50);
}
//---------------------------------------------------------------------------
module body_with_arms()
{
    body_with_rotation();
    
    // left arm
    translate ([(-body_width / 2 + dist_edge_to_body_shaft), -clavicule_size[0] / 2, 0])
        rotate ([0, 0, angle_body_arm])  
        
        translate ([0, 0, body_arm_shaft_length / 2 + plate_body_size[0] / 2 + 1.5]) 
        //rotate ([0, 0, angle_body_arm]) 
        translate ([bone_thick / 2, -3 / 2 * bone_thick, 0]) 
        rotate ([0, 90, 0]) 
        arm(body_arm_shaft_length)
        ;

    // right arm
    translate ([body_width / 2 - dist_edge_to_body_shaft, -clavicule_size[0] / 2, 0]) 
    translate ([0, 0, body_arm_shaft_length / 2 + plate_body_size[0] / 2 + 1.5]) 
    rotate ([0, 0, -angle_body_arm]) 
    translate ([-bone_thick / 2, -3 / 2 * bone_thick, 0]) 
    mirror([1, 0, 0])
    rotate ([0, 90, 0]) 
  //  arm(body_arm_shaft_length)
    ;
           
}
//---------------------------------------------------------------------------

body_with_arms();

//body_with_rotation(linear_motor_position = body_rotation_linear_motor_position);

//body();

//clavicle_bone();

//clavicle_with_pieces();

//diafragma_bone();

//diafragma_with_pieces();

//rbearing_6001_double_housing_with_potentiometer_support(); // 2x


//rbearing_6001_double_housing(); // 2x


//body_arm_traction_pulley();

//half_1_traction_pulley(); // 2x
//half_2_traction_pulley(); // 2x

//motor_pulley_8mm_shaft(); // 2x

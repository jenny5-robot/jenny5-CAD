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


//---------------------------------------------------------------------------
module vertebral_column()
{   
    alu_sigma_profile_30x30(vertebral_column_size[2]);
}
//---------------------------------------------------------------------------
module bearing_housing_top_body()
{
  radial_bearing_housing_with_potentiometer_support(rbearing_608_housing_size, rbearing_608_housing_holes_position, rb_608_external_radius, rb_608_thick, rbearing_608_housing_size[2] + 4, m4_screw_radius, 25);
}
//---------------------------------------------------------------------------
module clavicle_bone()
{
    echo("clavicule length", chest_length);
    echo("L profile 40x20mm, 3mm thick");
    difference(){
        color (aluminium_color) L_profile(chest_length, L_profile_40x20_short_size, L_profile_40x20_long_size, alu_sheet_3_thick); 
        echo("clavicule bone bearing housing holes = ");
        for (i = [1 : 4]){
            echo([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i], "radius = 2");
            translate ([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        }
// shaft hole
            echo([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[0], "radius = 10 (approx)");
            translate ([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[0] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 10, $fn = 30);

        echo("clavicule bone bearing housing holes = the same as the other side!");
        for (i = [1 : 4]){
        translate ([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, chest_length - dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        }
// shaft hole
        echo([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, chest_length - dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[0], "radius = 10 (approx)");
        translate ([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, chest_length - dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[0] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 10, $fn = 30);
        
        // holes for vertebral column screws
        echo("holes for vertebral column screws");
        echo([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, chest_length / 2, 0] + sigma_profile_holes[0], "radius=", 4);
        translate ([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, chest_length / 2, 0] + sigma_profile_holes[0] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 4, $fn = 20);
        
        for (i = [1 : 4]){
          echo([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, chest_length / 2, 0] + sigma_profile_holes[i], "radius = 2");
          translate ([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, chest_length / 2, 0] + sigma_profile_holes[i] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 2, $fn = 20);
        }

        // head holes
        echo("head holes = ");
          echo([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, chest_length / 2 - 30, 0], "radius = 2");
          translate ([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, chest_length / 2 - 30, 0] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 2, $fn = 20);

          echo([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, chest_length / 2 + 30, 0], "radius = 2");
          translate ([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, chest_length / 2 + 30, 0] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 2, $fn = 20);
        
    }
}
//---------------------------------------------------------------------------
module clavicle_with_pieces()
{
    clavicle_bone();
    // bearing housing top - left
    translate ([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, chest_length - dist_edge_to_shaft, alu_sheet_3_thick + rbearing_608_housing_size[2] + 7]) rotate ([0, 0, -90])mirror ([0,0,1]) rbearing_608_housing_with_potentiometer_support();
    
        // bearing housing top - right
    translate ([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, dist_edge_to_shaft, alu_sheet_3_thick + rbearing_608_housing_size[2] + 7]) rotate([0, 0, 90]) mirror ([0,0,1]) rbearing_608_housing_with_potentiometer_support();
    
    // top potentiometer
    translate ([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, dist_edge_to_shaft + 20, alu_sheet_3_thick + rbearing_608_housing_size[2] + 7 - pot_92R1A_J22_L15L_base_height - 2]) rotate([0, 0, 90]) 
    potentiometer_92R1A_J22_L15L();
}
//---------------------------------------------------------------------------
module diafragma_bone()
{
    echo("Diafragma length", chest_length);
    echo("L profile 40x20mm, 3mm thick");

    difference(){
        color (aluminium_color) L_profile(chest_length, L_profile_40x20_short_size, L_profile_40x20_long_size, alu_sheet_3_thick);
        // left axis bearing housing hole
        echo("diafragma bone bearing holes (left) = ");

// middle hole
        echo([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[0], "radius = 10");
        translate ([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[0] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 10, $fn = 30);
// screw holes
        for (i = [1 : 4]){
            echo([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i], "radius = 2");
            translate ([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        }
        // right axis bearing housing hole
        echo("diafragma bone bearing holes (right) = the same as left side!");

        translate ([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, chest_length - dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[0] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 10, $fn = 30);

        for (i = [1 : 4]){
            translate ([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, chest_length - dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);
        }
    // motor holes

        echo("diafragma left motor holes = ");

        echo([alu_sheet_3_thick + nema_17_motor_gearbox_radius + 1, dist_edge_to_shaft + dist_between_motor_and_axis, 0] + gearbox_nema_17_holes_position[0], "radius = ", gearbox_nema_17_holes_radius[0]);
        for (i = [1 : 4])
            echo([alu_sheet_3_thick + nema_17_motor_gearbox_radius + 1, dist_edge_to_shaft + dist_between_motor_and_axis, 0] + gearbox_nema_17_holes_position[i], "radius = ", gearbox_nema_17_holes_radius[i]);
        
        translate ([alu_sheet_3_thick + nema_17_motor_gearbox_radius + 1, dist_edge_to_shaft + dist_between_motor_and_axis, 0] - display_tolerance_z) {
          translate (gearbox_nema_17_holes_position[0]) cylinder(h = 3 + 2 * display_tolerance, r = gearbox_nema_17_holes_radius[0]);
          for (i = [1 : 4])
            translate (gearbox_nema_17_holes_position[i]) cylinder(h = 3 + 2 * display_tolerance, r = gearbox_nema_17_holes_radius[i]);
        }
     // the right side
        // motor holes
                
        echo("diafragma right motor holes = the same as the other side");
        translate ([alu_sheet_3_thick + nema_17_motor_gearbox_radius + 1, chest_length - (dist_edge_to_shaft + dist_between_motor_and_axis), 0] - display_tolerance_z) {
          translate (gearbox_nema_17_holes_position[0]) cylinder(h = 3 + 2 * display_tolerance, r = gearbox_nema_17_holes_radius[0]);
          for (i = [1 : 4])
            translate (gearbox_nema_17_holes_position[i]) cylinder(h = 3 + 2 * display_tolerance, r = gearbox_nema_17_holes_radius[i]);
        }
        
        // holes for vertebral column screws
        echo("holes for vertebral column screws");
        echo([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, chest_length / 2, 0] + sigma_profile_holes[0], "radius = 4");
        translate ([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, chest_length / 2, 0] + sigma_profile_holes[0] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 4, $fn = 20);
        
        for (i = [1 : 4]){
          echo([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, chest_length / 2, 0] + sigma_profile_holes[i], "radius = 2");
          translate ([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, chest_length / 2, 0] + sigma_profile_holes[i] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 2, $fn = 20);
        } 
        
        // holes for thrust bearing housing
        echo("holes for thrust bearing housing");
        for (i = [0 : 3]){
          echo([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, chest_length / 2, 0] + rotate_z(90,thrust_bearing_housing_51105_holes[i]), "radius = 2");

          translate ([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, chest_length / 2, 0] - display_tolerance_z) rotate([0, 0, 90]) translate (thrust_bearing_housing_51105_holes[i]) cylinder (h = alu_sheet_3_thick + 2 * display_tolerance, r = 2, $fn = 10);
        }
//hole for M6 screw for push
        echo("hole for M6 screw for push", [alu_sheet_3_thick + 15, chest_length / 2 + 55, 0], "radius = 3");
        translate ([alu_sheet_3_thick + 15, chest_length / 2 + 55, 0] - display_tolerance_z) cylinder (h = alu_sheet_3_thick + 2 * display_tolerance, r = 3, $fn = 20);
        
        // belt tensioner left side
        echo("belt tensioner holes");
        echo([L_profile_40x20_long_size - belt_tensioner_external_size[1] / 2, dist_to_belt_tensioner - belt_tensioner_external_size[0] / 2, 0], "radius = 2");
        echo([L_profile_40x20_long_size - belt_tensioner_external_size[1] / 2, dist_to_belt_tensioner + belt_tensioner_external_size[0] / 2, 0], "radius = 2");
        translate([L_profile_40x20_long_size - belt_tensioner_external_size[1] / 2, dist_to_belt_tensioner - belt_tensioner_external_size[0] / 2, 0] - display_tolerance_z) cylinder (h = alu_sheet_3_thick + 2 * display_tolerance, r = 2, $fn = 20);
        translate([L_profile_40x20_long_size - belt_tensioner_external_size[1] / 2, dist_to_belt_tensioner + belt_tensioner_external_size[0] / 2, 0] - display_tolerance_z) cylinder (h = alu_sheet_3_thick + 2 * display_tolerance, r = 2, $fn = 20);
// belt tensioner holes; right side
        translate([L_profile_40x20_long_size - belt_tensioner_external_size[1] / 2, chest_length - (dist_to_belt_tensioner - belt_tensioner_external_size[0] / 2), 0] - display_tolerance_z) cylinder (h = alu_sheet_3_thick + 2 * display_tolerance, r = 2, $fn = 20);
        translate([L_profile_40x20_long_size - belt_tensioner_external_size[1] / 2, chest_length - (dist_to_belt_tensioner + belt_tensioner_external_size[0] / 2), 0] - display_tolerance_z) cylinder (h = alu_sheet_3_thick + 2 * display_tolerance, r = 2, $fn = 20);
    }
}
//---------------------------------------------------------------------------
module diafragma_with_pieces()
{
    mirror([0, 0, 1]) diafragma_bone();
    
    // bearing housing
    translate ([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, dist_edge_to_shaft, -rbearing_608_housing_size[2] - alu_sheet_3_thick]) rbearing_608_housing_with_bearing();
    // motor
    translate ([alu_sheet_3_thick + nema_17_motor_gearbox_radius + 1, dist_edge_to_shaft + dist_between_motor_and_axis, -nema_17_with_13_1_gearbox_height - alu_sheet_3_thick]) nema_17_with_13_1_gearbox();
  
    // motor gear
    translate ([alu_sheet_3_thick + nema_17_motor_gearbox_radius + 1, dist_edge_to_shaft + dist_between_motor_and_axis, 0 + 7]) motor_pulley();
    
    // belt tensioner
    translate ([L_profile_40x20_long_size - belt_tensioner_external_size[1] / 2, dist_to_belt_tensioner - belt_tensioner_external_size[0] / 2, 0]) rotate([0, 0, 90]) belt_tensioner_external_with_bearings();
    
    // other side
    // bearing housing
    translate ([alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2, chest_length - dist_edge_to_shaft, -rbearing_608_housing_size[2] - alu_sheet_3_thick]) rbearing_608_housing_with_bearing();
    // motor
    translate ([alu_sheet_3_thick + nema_17_motor_gearbox_radius + 1, chest_length - (dist_edge_to_shaft + dist_between_motor_and_axis), -nema_17_with_13_1_gearbox_height - alu_sheet_3_thick]) nema_17_with_13_1_gearbox();
  
    // motor gear
    translate ([alu_sheet_3_thick + nema_17_motor_gearbox_radius + 1, chest_length - (dist_edge_to_shaft + dist_between_motor_and_axis), +7]) motor_pulley();
    
    // belt tensioner
    translate ([L_profile_40x20_long_size - belt_tensioner_external_size[1] / 2, chest_length - (dist_to_belt_tensioner + belt_tensioner_external_size[0] / 2), 0]) rotate([0, 0, 90]) belt_tensioner_external_with_bearings();

    //M6 screw for push
    translate ([alu_sheet_3_thick + 15, chest_length / 2 + 55, 4]) mirror([0, 0, 1]) M6_hexa_screw(40);
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
    echo("body arm bone holes position = ");
    difference(){
        cube_empty(6, 10, bone_length);
        for (i = [0 : 1]){
            echo(bone_length / 2 + body_holes_position[i], "radius = 2");
            translate ([-bone_thick / 2, 0, bone_length / 2 + body_holes_position[i]] - display_tolerance_x) rotate ([0, 90, 0]) cylinder (h = bone_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
        }
    }
}
//---------------------------------------------------------------------------
module body()
{
    // bottom 
    translate ([-chest_length / 2, 0, 0]) 
        rotate ([0, 0, -90]) 
            diafragma_with_pieces();
    // top 
    translate ([-chest_length / 2, 0, chest_height]) 
        rotate ([0, 0, -90]) 
            mirror([0, 0, 1])
                clavicle_with_pieces();

// vertebral column
    translate ([0, -(alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2), 0]) vertebral_column();
    
    // left arm
    // vertical axis
    translate ([-(chest_length / 2 -dist_edge_to_shaft), -(alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2), 0]) {
        rotate ([0, 0, angle_body_arm])  
            color (aluminium_color) body_arm_bone(body_arm_length);
        
    // traction pulley
        translate ([0, 0, 6]) rotate([0, 0, angle_body_arm]) body_arm_traction_pulley();

        mirror([1, 0, 0]) translate ([0, 0, body_arm_length / 2 + plate_body_size[0] / 2 + 1.5]) rotate ([0, 0, angle_body_arm]) translate ([bone_thick / 2, -3 / 2 * bone_thick, 0]) rotate ([0, 90, 0]) arm(body_arm_length);
    }

    //translate ([-(chest_length / 2 -dist_edge_to_shaft), -(alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2), 0]) mirror([1, 0, 0]) 
        
    // belt left arm
    translate ([-chest_length / 2 + rbearing_608_housing_size[0] / 2, -(alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2), 9]) rotate([0, 0, 0]) belt_on_2_pulleys(25.8, 11.5, 89, 6);
    
    echo ("belt length = ", length_belt_on_2_pulleys(25.8, 11.5, 89, 6));
    
    // right arm
    //translate ([chest_length / 2 - dist_edge_to_shaft, -(alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2), 0]) arm(body_arm_length);

    translate ([(chest_length / 2 -dist_edge_to_shaft), -(alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2), 0]){
        rotate ([0, 0, angle_body_arm])  
    color (aluminium_color) body_arm_bone(body_arm_length);
        
    // traction pulley
        translate ([0, 0, 6]) rotate([0, 0, angle_body_arm]) body_arm_traction_pulley();

        translate ([0, 0, body_arm_length / 2 + plate_body_size[0] / 2 + 1.5]) rotate ([0, 0, angle_body_arm]) translate ([bone_thick / 2, -3 / 2 * bone_thick, 0]) rotate ([0, 90, 0]) arm(body_arm_length);
    }    
    // breadboard for arms
    translate ([0, -(alu_sheet_3_thick + (L_profile_40x20_long_size - alu_sheet_3_thick) / 2) - vertebral_column_size[0] / 2, vertebral_column_size[2] / 2 - arms_breadboard_size[1] / 2]) rotate([0, 0, -180]) arms_breadboard();
    // top thrust bearing housing
    translate ([0, -thrust_bearing_housing_51105_size[1] / 2 - alu_sheet_3_thick, -alu_sheet_3_thick]) mirror([0, 0, 1]) thrust_bearing_housing_51105();
}    
//---------------------------------------------------------------------------
module body_with_rotation(linear_motor_position)
{
    translate ([0, -(alu_sheet_3_thick + 37 / 2), 0]) rotate ([0, 0, 0]) translate ([0, alu_sheet_3_thick + 37 / 2, 0]) body();
    // bottom thrust bearing housing
    translate ([0, -thrust_bearing_housing_51105_size[1] / 2 - alu_sheet_3_thick, -alu_sheet_3_thick - thrust_bearing_housing_51105_thin_size[2] - thrust_bearing_housing_51105_size[2] - tb_51105_height + 2 * thrust_bearing_depth]) thrust_bearing_housing_51105_small();
    
    //bottom thrust bearing
    translate ([0, -thrust_bearing_housing_51105_size[1] / 2 - alu_sheet_3_thick, -alu_sheet_3_thick - thrust_bearing_housing_51105_size[2] - tb_51105_height + thrust_bearing_depth])
        thrust_bearing_51105();
    
    // sheet
    translate ([-30, -body_rotation_sheet_size[1] - alu_sheet_3_thick, -alu_sheet_3_thick - thrust_bearing_housing_51105_size[2] - thrust_bearing_housing_51105_thin_size[2] - tb_51105_height + 2 * thrust_bearing_depth - 10])
    body_rotation_sheet();
    
    // linear motor
    translate ([0, -190, -27]) rotate ([0, 0, -18]) rotate ([-90, 0, 0]) linear_dc_motor(50, linear_motor_position);
    
    // screw for linear motor base
    translate ([0, -190, -62]) M6_hexa_screw(50);
}
//---------------------------------------------------------------------------

//body_with_rotation(linear_motor_position = body_rotation_linear_motor_position);

//clavicle_bone();

//diafragma_bone();

//diafragma_with_pieces();

//rbearing_608_housing_with_potentiometer_support();

body_arm_bone(body_arm_length);
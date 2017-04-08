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
module clavicle()
{
    difference(){
        color (aluminium_color) L_profile(chest_length, L_profile_40x20_short_size, L_profile_40x20_long_size, alu_sheet_3_thick); 
        echo("gauri_os_clavicula left = ");
        for (i = [0:4]){
            echo([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2, dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i]);
            translate ([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2, dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);
        }
// shaft hole
            translate ([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2, dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[0] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 11, $fn = 30);

        echo("clavicule right bone holes = ");
        for (i = [0:4]){
            echo([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2, chest_length - dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i]);
        translate ([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2, chest_length - dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);
        }
// shaft hole
        translate ([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2, chest_length - dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[0] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 11, $fn = 30);
    }
    
    // bearing housing top - left
    translate ([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2, chest_length - dist_edge_to_shaft, alu_sheet_3_thick + rbearing_608_housing_size[2] + 7]) rotate ([0, 0, -90])mirror ([0,0,1]) rbearing_608_housing_with_potentiometer_support();
    
        // bearing housing top - right
    translate ([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2, dist_edge_to_shaft, alu_sheet_3_thick + rbearing_608_housing_size[2] + 7]) rotate([0, 0, 90]) mirror ([0,0,1]) rbearing_608_housing_with_potentiometer_support();
    
    // top potentiometer
    translate ([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2, dist_edge_to_shaft + 20, alu_sheet_3_thick + rbearing_608_housing_size[2] + 7 - pot_92R1A_J22_L15L_base_height - 2]) rotate([0, 0, 90]) 
    potentiometer_92R1A_J22_L15L();
}
//---------------------------------------------------------------------------
module diafragma_bone()
{
    difference(){
        color (aluminium_color) L_profile(chest_length, L_profile_40x20_short_size, L_profile_40x20_long_size, alu_sheet_3_thick);
        // left axis bearing housing hole
        echo("diafragma bone left holes = ");

// middle hole
        echo([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2 + 2, dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[0], "radius = 8");
        translate ([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2 + 2, dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[0] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 8, $fn = 30);
// screw holes
        for (i = [1 : 4]){
            echo([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2 + 2, dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i], "radius = 2");
            translate ([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2 + 2, dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        }
        // right axis bearing housing hole
        echo("diafragma bone right holes = ");
            echo([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2 + 2, chest_length - dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[0], "radius = 8");
            translate ([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2 + 2, chest_length - dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[0] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = 8, $fn = 30);

        for (i = [1 : 4]){
            echo([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2 + 2, chest_length - dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i], "radius = 2");
            translate ([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2 + 2, chest_length - dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);
        }
// motor holes

        echo("diafragma left motor holes = ");

        echo([alu_sheet_3_thick + nema_17_motor_gearbox_radius + 1, dist_edge_to_shaft + dist_between_motor_and_axis, 0] + gearbox_nema_17_holes_position[0], "radius = 11");
        for (i = [1 : 4])
            echo([alu_sheet_3_thick + nema_17_motor_gearbox_radius + 1, dist_edge_to_shaft + dist_between_motor_and_axis, 0] + gearbox_nema_17_holes_position[i], "radius = 1.5");
        
        translate ([alu_sheet_3_thick + nema_17_motor_gearbox_radius + 1, dist_edge_to_shaft + dist_between_motor_and_axis, 0] - display_tolerance_z) {
          translate (gearbox_nema_17_holes_position[0]) cylinder(h = 3 + 2 * display_tolerance, r = 11);
          for (i = [1 : 4])
            translate (gearbox_nema_17_holes_position[i]) cylinder(h = 3 + 2 * display_tolerance, r = 1.5);
        }
     
        echo("diafragma right motor holes = ");
        echo([alu_sheet_3_thick + nema_17_motor_gearbox_radius + 1, chest_length - (dist_edge_to_shaft + dist_between_motor_and_axis), 0] + gearbox_nema_17_holes_position[0], "radius = 11");
        for (i = [1 : 4])
            echo([alu_sheet_3_thick + nema_17_motor_gearbox_radius + 1, chest_length - (dist_edge_to_shaft + dist_between_motor_and_axis), 0] + gearbox_nema_17_holes_position[i], "radius = 1.5");
        
        translate ([alu_sheet_3_thick + nema_17_motor_gearbox_radius + 1, chest_length - (dist_edge_to_shaft + dist_between_motor_and_axis), 0] - display_tolerance_z) {
            translate (gearbox_nema_17_holes_position[0]) cylinder(h = 3 + 2 * display_tolerance, r = 11);
            for (i = [1 : 4])
                translate (gearbox_nema_17_holes_position[i]) cylinder(h = 3 + 2 * display_tolerance, r = 1.5);
        }
    }
}
//---------------------------------------------------------------------------
module diafragma_bone_with_pieces()
{
    mirror([0, 0, 1]) diafragma_bone();
    
    // bearing housing
    translate ([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2, dist_edge_to_shaft, -rbearing_608_housing_size[2] - alu_sheet_3_thick]) rbearing_608_housing_with_bearing();
    // motor
    translate ([alu_sheet_3_thick + nema_17_width / 2, dist_edge_to_shaft + dist_between_motor_and_axis, -nema_17_with_13_1_gearbox_height - alu_sheet_3_thick]) nema_17_with_13_1_gearbox();
  
    // motor gear
    translate ([alu_sheet_3_thick + nema_17_width / 2, dist_edge_to_shaft + dist_between_motor_and_axis, 0+ 7]) motor_pulley();
    
    // other side
    // bearing housing
    translate ([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2, chest_length - dist_edge_to_shaft, -rbearing_608_housing_size[2] - alu_sheet_3_thick]) rbearing_608_housing_with_bearing();
    // motor
    translate ([alu_sheet_3_thick + nema_17_width / 2, chest_length - (dist_edge_to_shaft + dist_between_motor_and_axis), -nema_17_with_13_1_gearbox_height - alu_sheet_3_thick]) nema_17_with_13_1_gearbox();
  
    // motor gear
    translate ([alu_sheet_3_thick + nema_17_width / 2, chest_length - (dist_edge_to_shaft + dist_between_motor_and_axis), +7]) motor_pulley();
}
//---------------------------------------------------------------------------
module body()
{
    // bottom 
    translate ([-chest_length / 2, 0, 0]) 
    rotate ([0, 0, -90]) 
    //mirror([0, 0, 1])
        diafragma_bone_with_pieces();
    // top 
    translate ([-chest_length / 2, 0, chest_height]) rotate ([0, 0, -90]) 
    mirror([0, 0, 1])
    clavicle();

// vertebral column
    translate ([0, -vertebral_column_size[1] / 2 - alu_sheet_3_thick, 0]) vertebral_column();
    
    // left arm
    translate ([-(chest_length / 2 -dist_edge_to_shaft), -(alu_sheet_3_thick + rbearing_608_housing_size[0] / 2), 0]) mirror([1, 0, 0]) arm(body_arm_length);
    // right arm
    translate ([chest_length / 2 - dist_edge_to_shaft, -(alu_sheet_3_thick + rbearing_608_housing_size[0] / 2), 0]) arm(body_arm_length);
    
    // breadboard for arms
    translate ([-arms_breadboard_size[0] / 2, -vertebral_column_size[0] -alu_sheet_3_thick, vertebral_column_size[2] / 2 - arms_breadboard_size[1] / 2]) rotate ([90, 0, 0]) arms_breadboard();
}    
//---------------------------------------------------------------------------

body();



//diafragma_bone();
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
use <../basic_scad/functions_3d.scad>
use <../basic_scad/stepper_motors.scad>

include <../basic_scad/params_stepper_motors.scad>
include <params_motor_plate.scad>
use <../basic_scad/radial_bearing_housing.scad>

include <../basic_scad/params_potentiometers.scad>
use <../basic_scad/potentiometers.scad>

use <motor_plate.scad>

include <params_arm.scad>
use <arm.scad>



//---------------------------------------------------------------------------

module vertebral_column()
{
    color (aluminium_color) cube_empty(coloana_vertebrala_size[0] - 3, coloana_vertebrala_size[0], coloana_vertebrala_size[2]);
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
        color (aluminium_color) L(chest_length, latura_L / 2, latura_L, alu_sheet_3_thick); 
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
        color (aluminium_color) L(chest_length, latura_L / 2, latura_L, alu_sheet_3_thick);
        // left axis hole
        echo("gauri_os_diafragma left = ");
        for (i = [0:4]){
            echo([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2, dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i]);
            translate ([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2, dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);
        }
        // right axis hole
        echo("gauri_os_diafragma right = ");
        for (i = [0:4]){
            echo([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2, chest_length - dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i]);
            translate ([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2, chest_length - dist_edge_to_shaft, 0] + rbearing_608_housing_holes_position[i] - display_tolerance_z) cylinder(h = alu_sheet_3_thick + 2 * display_tolerance, r = m3_screw_radius, $fn = 10);
        }
// motor sheet holes

echo("diafragma holes; motor left = ");
        for (i = [0:4])
            echo([alu_sheet_3_thick + nema_17_width / 2, dist_edge_to_shaft + dist_between_motor_and_axis, 0] + rotate_z(90, pozitie_gauri_placa_motor[i]));
        
      translate ([alu_sheet_3_thick + nema_17_width / 2, dist_edge_to_shaft + dist_between_motor_and_axis, 0]) rotate ([0, 0, 90]) motor_plate_holes(placa_motor_trunchi_size[0], placa_motor_trunchi_size[1], placa_motor_trunchi_size[2], 2, 2, 0, 0);
     
     echo("diafragma holes; motor right = ");
        for (i = [0:4])
            echo([alu_sheet_3_thick + nema_17_width / 2, chest_length - (dist_edge_to_shaft + dist_between_motor_and_axis), 0] + rotate_z(90, pozitie_gauri_placa_motor[i]));
        
      translate ([alu_sheet_3_thick + nema_17_width / 2, chest_length - (dist_edge_to_shaft + dist_between_motor_and_axis), 0]) rotate ([0, 0, 90]) motor_plate_holes(placa_motor_trunchi_size[0], placa_motor_trunchi_size[1], placa_motor_trunchi_size[2], 2, 2, 0, 0);
        
    }
}
//---------------------------------------------------------------------------
module diafragma_bone_with_pieces()
{
    diafragma_bone();
    
    // bearing housing
    translate ([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2, dist_edge_to_shaft, rbearing_608_housing_size[2] + alu_sheet_3_thick]) mirror ([0, 0, 1]) rbearing_608_housing_with_bearing();
    // motor
    translate ([alu_sheet_3_thick + nema_17_width / 2, dist_edge_to_shaft + dist_between_motor_and_axis, nema_17_with_13_1_gearbox_height + alu_sheet_3_thick + placa_motor_trunchi_size[2]]) mirror ([0, 0, 1]) nema_17_with_13_1_gearbox();
    // belt tensioner plate
    translate ([alu_sheet_3_thick + nema_17_width / 2, dist_edge_to_shaft + dist_between_motor_and_axis, alu_sheet_3_thick]) rotate ([0, 0, 90]) motor_plate_belt_tensioner(motor_housing_tolerance);
  
    // motor gear
    translate ([alu_sheet_3_thick + nema_17_width / 2, dist_edge_to_shaft + dist_between_motor_and_axis, -2]) mirror ([0, 0, 1]) motor_pulley();
    
    // other side
    // bearing housing
    translate ([alu_sheet_3_thick + rbearing_608_housing_size[0] / 2, chest_length - dist_edge_to_shaft, rbearing_608_housing_size[2] + alu_sheet_3_thick]) mirror ([0, 0, 1]) rbearing_608_housing_with_bearing();
    // motor
    translate ([alu_sheet_3_thick + nema_17_width / 2, chest_length - (dist_edge_to_shaft + dist_between_motor_and_axis), nema_17_with_13_1_gearbox_height + alu_sheet_3_thick + placa_motor_trunchi_size[2]]) mirror ([0, 0, 1]) nema_17_with_13_1_gearbox();
    // belt tensioner plate
    translate ([alu_sheet_3_thick + nema_17_width / 2, chest_length - (dist_edge_to_shaft + dist_between_motor_and_axis), alu_sheet_3_thick]) rotate ([0, 0, 90]) motor_plate_belt_tensioner(motor_housing_tolerance);
  
    // motor gear
    translate ([alu_sheet_3_thick + nema_17_width / 2, chest_length - (dist_edge_to_shaft + dist_between_motor_and_axis), -2]) mirror ([0, 0, 1]) motor_pulley();
    
}
//---------------------------------------------------------------------------
module body()
{
    // left side
    // bottom L
    translate ([-chest_length / 2, 0, 0]) 
    rotate ([0, 0, -90]) 
    //mirror([0, 0, 1])
        diafragma_bone_with_pieces();
    // top L
    translate ([-chest_length / 2, 0, chest_height]) rotate ([0, 0, -90]) 
    mirror([0, 0, 1])
    clavicle();

// vertebral column
    translate ([0, -coloana_vertebrala_size[1]/2 - alu_sheet_3_thick, alu_sheet_3_thick]) vertebral_column();
    
// left arm
    translate ([-(chest_length / 2 -dist_edge_to_shaft), -(alu_sheet_3_thick + rbearing_608_housing_size[0] / 2), 0]) mirror([1, 0, 0]) arm(body_arm_length);
    // right arm
    translate ([chest_length / 2 - dist_edge_to_shaft, -(alu_sheet_3_thick + rbearing_608_housing_size[0] / 2), 0]) arm(body_arm_length);
}    
//---------------------------------------------------------------------------

body();



//rbearing_608_housing_with_potentiometer_support();
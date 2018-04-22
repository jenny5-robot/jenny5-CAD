// Author: Mihai Oltean, 
// https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_stepper_motor_gearbox.scad>
include <params_stepper_motors.scad>
include <params_basic_components.scad>
include <config.scad>
include <tolerance.scad>
include <params_screws_nuts_washers.scad>

//--------------------------------------------------------------
module stepper_gearbox_motor_alu_sheet(sheet_size, gearbox_hole_position, screw_hole_position, gearbox_hole_radius, gearbox_radius, rotate_screw_holes)
{
    difference(){
        translate ([-sheet_size[0] / 2, -sheet_size[1] / 2, 0]) cube(sheet_size);
        // middle hole
        translate (-display_tolerance_z) cylinder(h = sheet_size[2] + 2 * display_tolerance, r = gearbox_hole_radius);
       // translate ([0, 0, nema_17_gearbox_sheet_base_wall_thick]) cylinder(h = sheet_size[2], r = gearbox_radius,$fn = 80);
        // gearbox holes
        for (i = [1 : 4])
            rotate ([0, 0, rotate_screw_holes]) translate (+ gearbox_hole_position[i]) cylinder(h = sheet_size[2] , r2 = 1.5, r1 = 2.5, $fn = 10);

// screw holes for belt tensioner        
        for (i = [0 : 4]){
            translate (-display_tolerance_z + screw_hole_position[i]) cylinder(h = sheet_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        }
    }
}
//--------------------------------------------------------------
module stepper_gearbox_motor_plastic_sheet(sheet_size, gearbox_hole_position, screw_hole_position, gearbox_hole_radius, gearbox_radius, rotate_screw_holes)
{
    difference(){
        translate ([-sheet_size[0] / 2, -sheet_size[1] / 2, 0]) cube(sheet_size);
        // middle hole
        translate (-display_tolerance_z) cylinder(h = sheet_size[2] + 2 * display_tolerance, r = gearbox_hole_radius);
        translate ([0, 0, nema_17_gearbox_sheet_base_wall_thick]) cylinder(h = sheet_size[2], r = gearbox_radius,$fn = 80);
        // gearbox holes
        for (i = [1 : 4])
            rotate ([0, 0, rotate_screw_holes]) translate (+ gearbox_hole_position[i]) cylinder(h = nema_17_gearbox_sheet_base_wall_thick , r2 = 1.5, r1 = 2.5, $fn = 10);

// screw holes for belt tensioner        
        for (i = [0 : 4]){
            translate (-display_tolerance_z + screw_hole_position[i]) cylinder(h = sheet_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
            translate (screw_hole_position[i] + [0, 0, sheet_size[2] - m4_nut_thick]) cylinder(h = m4_nut_thick + display_tolerance, r = m4_nut_radius, $fn = 6);
        }
    }
}
//--------------------------------------------------------------
module stepper_gearbox_nema_17_motor_alu_sheet()
{
    stepper_gearbox_motor_alu_sheet(nema_17_gearbox_alu_sheet_size, gearbox_nema_17_holes_position, nema17_gearbox_tensioner_sheet_screw_hole_position, nema_17_gearbox_motor_hole_radius, nema_17_motor_gearbox_radius, 0);
}
//--------------------------------------------------------------
module stepper_gearbox_nema_17_motor_plastic_sheet()
{
    stepper_gearbox_motor_plastic_sheet(nema_17_gearbox_sheet_size, gearbox_nema_17_holes_position, nema17_gearbox_tensioner_sheet_screw_hole_position, nema_17_gearbox_motor_hole_radius, nema_17_motor_gearbox_radius, 0);
}
//--------------------------------------------------------------
module stepper_gearbox_nema_11_motor_platic_sheet()
{
    stepper_gearbox_motor_plastic_sheet(nema_11_gearbox_sheet_size, gearbox_nema_11_holes_position, nema11_gearbox_tensioner_sheet_screw_hole_position, nema_11_motor_gearbox_hole_radius, nema_11_motor_gearbox_radius, 45);
}
//--------------------------------------------------------------

//stepper_gearbox_nema_11_motor_platic_sheet();

//stepper_gearbox_nema_17_motor_plastic_sheet();

stepper_gearbox_nema_17_motor_alu_sheet();
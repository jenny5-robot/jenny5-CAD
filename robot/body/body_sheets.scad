// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// License: MIT
//--------------------------------------------------------------


include <../../basic_scad/params_basic_components.scad>

include <../../basic_scad/material_colors.scad>

include <body_params.scad>
include <../../basic_scad/params_screws_nuts_washers.scad>

include <../../basic_scad/params_stepper_motors.scad>

use <../../basic_scad/thrust_bearing_housing.scad>
include <../../basic_scad/params_thrust_bearing_housing.scad>

include <../../basic_scad/tolerance.scad>
include <../../basic_scad/point_transformations_3d.scad>

include <../../basic_scad/params_radial_bearings_u_housing.scad>

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

module body_sheet_for_bearing_support_top()
{
    echo(body_sheet_size = body_sheet_size);
    difference(){
        color(aluminium_color) cube(body_sheet_size);
        // middle hole
        echo("body sheet middle hole", [body_sheet_size[0] / 2, body_sheet_size[1] / 2, 0]);
        translate([body_sheet_size[0] / 2, body_sheet_size[1] / 2, 0] - display_tolerance_z) cylinder (h = body_sheet_size[2] + 2 * display_tolerance, r = 17.5);
        // screw holes
        echo("bearing support holes = ");
        for (i = [1 : 4]){
            echo([body_sheet_size[0] / 2, body_sheet_size[1] / 2, 0] + rbearing_6907_housing_holes_position[i]);
            translate([body_sheet_size[0] / 2, body_sheet_size[1] / 2, 0] - display_tolerance_z) translate(rbearing_6907_housing_holes_position[i]) cylinder (h = body_sheet_size[2] + 2 * display_tolerance, r = 2);
        }
        bracket_holes = f_tube_bracket_holes(body_sheet_size[0], body_shaft_radius);
        
        echo("braket holes = ");
        for (i = [0 : 3]){
            echo(bracket_holes[i]);
            translate(- display_tolerance_z) translate(bracket_holes[i]) cylinder (h = body_sheet_size[2] + 2 * display_tolerance, r = 2);
        }
        
        for (i = [0 : 3]){
            echo([0, body_sheet_size[1] - f_bracket_width(body_shaft_radius), 0] + bracket_holes[i]);
            translate([0, body_sheet_size[1] - f_bracket_width(body_shaft_radius), 0] - display_tolerance_z) translate(bracket_holes[i]) cylinder (h = body_sheet_size[2] + 2 * display_tolerance, r = 2);
        }
    }
}
//---------------------------------------------------------------------------
module body_sheet_for_bearing_support_bottom()
{
    echo(body_sheet_size_bottom = body_sheet_size_bottom);
    difference(){
        color(aluminium_color) cube(body_sheet_size_bottom);
        // middle hole
        echo("body sheet middle hole", [body_sheet_size[0] / 2, body_sheet_size[1] / 2, 0]);
        translate([body_sheet_size[0] / 2, body_sheet_size[1] / 2, 0] - display_tolerance_z) cylinder (h = body_sheet_size[2] + 2 * display_tolerance, r = 17.5);
        // screw holes
        echo("bearing support holes = ");
        for (i = [1 : 4]){
            echo([body_sheet_size[0] / 2, body_sheet_size[1] / 2, 0] + rbearing_6907_housing_holes_position[i]);
            translate([body_sheet_size[0] / 2, body_sheet_size[1] / 2, 0] - display_tolerance_z) translate(rbearing_6907_housing_holes_position[i]) cylinder (h = body_sheet_size[2] + 2 * display_tolerance, r = 2);
        }
        bracket_holes = f_tube_bracket_holes(body_sheet_size[0], body_shaft_radius);
        
        echo("braket holes = ");
        for (i = [0 : 3]){
            echo(bracket_holes[i]);
            translate(- display_tolerance_z) translate(bracket_holes[i]) cylinder (h = body_sheet_size[2] + 2 * display_tolerance, r = 2);
        }
        
        for (i = [0 : 3]){
            echo([0, body_sheet_size[1] - f_bracket_width(body_shaft_radius), 0] + bracket_holes[i]);
            translate([0, body_sheet_size[1] - f_bracket_width(body_shaft_radius), 0] - display_tolerance_z) translate(bracket_holes[i]) cylinder (h = body_sheet_size[2] + 2 * display_tolerance, r = 2);
        }
        
        // bearing support holes
        echo("bearing holes");
        echo([body_sheet_size_bottom[0] - 4, body_sheet_size_bottom[1] / 2 - 13, 0]);
        echo([body_sheet_size_bottom[0] - 4, body_sheet_size_bottom[1] / 2 + 13, 0]);
        translate([body_sheet_size_bottom[0] - 4, body_sheet_size_bottom[1] / 2 - 13, 0] - display_tolerance_z) cylinder (h = body_sheet_size_bottom[2] + 2 * display_tolerance, r = 2, $fn = 10);
        translate([body_sheet_size_bottom[0] - 4, body_sheet_size_bottom[1] / 2 + 13, 0] - display_tolerance_z) cylinder (h = body_sheet_size_bottom[2] + 2 * display_tolerance, r = 2, $fn = 10);
    }
}
//---------------------------------------------------------------------------
module body_sheet_for_motor_support()
{
    echo(body_motor_sheet_size =  body_motor_sheet_size);
    difference(){
        color(aluminium_color) cube(body_motor_sheet_size);
        // motor holes
        // middle hole
        echo("motor holes = ");
        echo([body_motor_sheet_size[0] / 2, body_motor_sheet_size[1] / 2, 0]);
        translate([body_motor_sheet_size[0] / 2, body_motor_sheet_size[1] / 2, 0] - display_tolerance_z) cylinder (h = body_motor_sheet_size[2] + 2 * display_tolerance, r = nema_17_gearbox_motor_hole_radius);
        // screw holes
        for (i = [1 : 4]){
            echo([body_motor_sheet_size[0] / 2, body_motor_sheet_size[1] / 2, 0] + rotate_z(45, gearbox_nema_17_holes_position[i]));
            translate([body_motor_sheet_size[0] / 2, body_motor_sheet_size[1] / 2, 0] - display_tolerance_z) rotate ([0, 0, 45]) translate(gearbox_nema_17_holes_position[i]) cylinder (h = body_motor_sheet_size[2] + 2 * display_tolerance, r = 1.5, $fn = 10);
        }
        bracket_holes = f_tube_bracket_holes(body_motor_sheet_size[0], body_shaft_radius);
        echo("braket holes");
        for (i = [0 : 3]){
            echo(bracket_holes[i]);
            translate( - display_tolerance_z) translate(bracket_holes[i]) cylinder (h = body_motor_sheet_size[2] + 2 * display_tolerance, r = 2, $fn = 10);
        }
        for (i = [0 : 3]){
            echo([0, body_motor_sheet_size[1] - f_bracket_width(body_shaft_radius), 0] + bracket_holes[i]);
            translate([0, body_motor_sheet_size[1] - f_bracket_width(body_shaft_radius), 0] - display_tolerance_z) translate(bracket_holes[i]) cylinder (h = body_motor_sheet_size[2] + 2 * display_tolerance, r = 2, $fn = 10);
        }

    }
}
//---------------------------------------------------------------------------
module body_sheet_for_motor_support_top()
{
    echo(body_motor_sheet_size =  body_motor_sheet_size);
    difference(){
        color(aluminium_color) cube(body_motor_sheet_size);
        // motor holes
        // middle hole
        echo("motor holes = ");
        echo([body_motor_sheet_size[0] / 2, body_motor_sheet_size[1] / 2, 0]);
        translate([body_motor_sheet_size[0] / 2, body_motor_sheet_size[1] / 2, 0] - display_tolerance_z) cylinder (h = body_motor_sheet_size[2] + 2 * display_tolerance, r = 18);
        bracket_holes = f_tube_bracket_holes(body_motor_sheet_size[0], body_shaft_radius);
        echo("braket holes");
        for (i = [0 : 3]){
            echo(bracket_holes[i]);
            translate( - display_tolerance_z) translate(bracket_holes[i]) cylinder (h = body_motor_sheet_size[2] + 2 * display_tolerance, r = 2, $fn = 10);
        }
        
        for (i = [0 : 3]){
            echo([0, body_motor_sheet_size[1] - f_bracket_width(body_shaft_radius), 0] + bracket_holes[i]);
            translate([0, body_motor_sheet_size[1] - f_bracket_width(body_shaft_radius), 0] - display_tolerance_z) translate(bracket_holes[i]) cylinder (h = body_motor_sheet_size[2] + 2 * display_tolerance, r = 2, $fn = 10);
        }

    }

}
//---------------------------------------------------------------------------
module body_sheet_for_intramodule()
{
    difference(){
        echo(body_intermodule_sheet_size = body_intermodule_sheet_size);
        color(aluminium_color) cube(body_intermodule_sheet_size);
        
        bracket_holes = f_tube_bracket_holes(body_intermodule_sheet_size[0], body_shaft_radius);
        // holes one side
        for (i = [0 : 3]){
            echo(bracket_holes[i]);
            translate( - display_tolerance_z) translate(bracket_holes[i]) cylinder (h = body_intermodule_sheet_size[2] + 2 * display_tolerance, r = 2);
            }
        // holes other side
        for (i = [0 : 3]){
            echo([0, body_intermodule_sheet_size[1] - f_bracket_width(body_shaft_radius), 0] + bracket_holes[i]);
            translate([0, body_intermodule_sheet_size[1] - f_bracket_width(body_shaft_radius), 0] - display_tolerance_z) translate(bracket_holes[i]) cylinder (h = body_intermodule_sheet_size[2] + 2 * display_tolerance, r = 2);
        }
    }
}
//---------------------------------------------------------------------------
module corner_sheet(tube_radius = 12.5)
{
    echo(corner_sheet_size = corner_sheet_size);
    difference(){
      color(aluminium_color) cube(corner_sheet_size);
      corner_height = f_corner_height(tube_radius);
      for (i = [0 : 7]){
        translate(corner_holes[i] - display_tolerance_z) cylinder (h = corner_height + 2 * display_tolerance, r = m4_screw_radius, $fn = 15);
          
      }
      echo(sheet_corner_holes = corner_holes);
    }
}
//-------------------------------------------------------------------------



body_sheet_for_motor_support();
//body_sheet_for_bearing_support_top();
//body_sheet_for_bearing_support_bottom();
//body_sheet_for_intramodule();
//corner_sheet(tube_radius = 12.5);

//body_rotation_sheet();
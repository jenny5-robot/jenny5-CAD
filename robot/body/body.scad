// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// License: MIT
//--------------------------------------------------------------

include <../../basic_scad/params_screws_nuts_washers.scad>
use <../../basic_scad/screws_nuts_washers.scad>

use <../../basic_scad/belt.scad>

include <../../basic_scad/tolerance.scad>

use <../../basic_scad/tube_bracket.scad>
include <../../basic_scad/params_tube_bracket.scad>

include <../../basic_scad/as5147_params.scad>
use <../../basic_scad/as5147.scad>

use <../arm/arm.scad>
include <../arm/arm_params.scad>

use <body_sensor_support.scad>
use <body_pulleys.scad>
use <body_sheets.scad>
use <body_bones.scad>
use <body_sheets_with_components.scad>

include <body_params.scad>

//---------------------------------------------------------------------------
module body_corner_module()
{
    // plastic parts
    translate ([-18, 0, 0]) rotate ([90, 0, 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    translate ([18, 0, 0]) rotate ([90, 0, 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    translate ([-18, 0, 0]) rotate ([-90, 0, 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    translate ([18, 0, 0]) rotate ([-90, 0, 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);

    translate ([0, 0, 27]) rotate ([0, 90, 90]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    translate ([0, 0, 64]) rotate ([0, 90, 90]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    translate ([0, 0, 27]) rotate ([0, 90, -90]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    translate ([0, 0, 64]) rotate ([0, 90, -90]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    
    // sheets
    translate ([-corner_sheet_size[0] / 2, -(body_shaft_radius + tube_bracket_base_thick_strong), - f_bracket_width(body_shaft_radius) / 2]) rotate ([90, 0, 0]) corner_sheet(body_shaft_radius);
    
    translate ([-corner_sheet_size[0] / 2, (body_shaft_radius + tube_bracket_base_thick_strong) + corner_sheet_size[2], - f_bracket_width(body_shaft_radius) / 2]) rotate ([90, 0, 0]) corner_sheet(body_shaft_radius);
}
//---------------------------------------------------------------------------
module body_module()
{
    // vertical tube
    translate ([0, 0, body_shaft_radius]) body_frame_vertical_bone();
    // bottom tube
    translate ([-body_width / 2, 0, 0]) rotate ([0, 90, 0]) body_frame_horizontal_bone();
    // top tube
    translate ([-body_width / 2, 0, body_height + 2 * body_shaft_radius]) rotate ([0, 90, 0]) color ("black") body_frame_horizontal_bone();
        // bottom corner
    body_corner_module();
    translate ([0, 0, body_height + 2 * body_shaft_radius])
    mirror([0, 0, 1])
    body_corner_module();
   // rotate ([90, 0, 0]) tube_corner(body_shaft_radius);
        // top corner
    //translate ([0, 0, body_height + 2 * body_shaft_radius]) rotate ([-90, 0, 0]) tube_corner(body_shaft_radius);
    
}
//---------------------------------------------------------------------------
module body_bearing_support_top()
{
    // bottom sheet
    translate ([-body_sheet_size[0] / 2, -body_sheet_size[1] / 2, -body_shaft_radius - tube_bracket_base_thick_strong - body_sheet_size[2]] ) body_sheet_with_bearing();
    // top sheet
    translate ([-body_sheet_size[0] / 2, -body_sheet_size[1] / 2, body_shaft_radius + tube_bracket_base_thick_strong + body_sheet_size[2]]) mirror([0, 0, 1]) body_sheet_with_bearing();
    
    // sensor support
    
    translate ([-(body_sheet_size[0] / 2 - 6), 0, body_shaft_radius + tube_bracket_base_thick_strong + body_sheet_size[2] + 5]) mirror ([0, 0, 1]) rotate ([0, 0, -90]) body_sensor_support();
    
    // brackets
    translate ([-body_sheet_size[0] / 2 + bracket_thick / 2, -body_sheet_size[1] / 2 + f_bracket_width(body_shaft_radius) / 2, 0])
            tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    translate ([-body_sheet_size[0] / 2 + bracket_thick / 2, -body_sheet_size[1] / 2 + f_bracket_width(body_shaft_radius) / 2, 0])
        mirror([0, 0, 1])
            tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
       
    translate ([+body_sheet_size[0] / 2 - bracket_thick / 2, -body_sheet_size[1] / 2 + f_bracket_width(body_shaft_radius) / 2, 0])
            tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    translate ([body_sheet_size[0] / 2 - bracket_thick / 2, -body_sheet_size[1] / 2 + f_bracket_width(body_shaft_radius) / 2, 0])
        mirror([0, 0, 1])
            tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
// back
    translate ([-body_sheet_size[0] / 2 + bracket_thick / 2, (body_sheet_size[1] / 2 - f_bracket_width(body_shaft_radius) / 2), 0])
            tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    
    translate ([-body_sheet_size[0] / 2 + bracket_thick / 2, (body_sheet_size[1] / 2 - f_bracket_width(body_shaft_radius) / 2), 0])
        mirror([0, 0, 1])
            tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
       
    translate ([+body_sheet_size[0] / 2 - bracket_thick / 2, (body_sheet_size[1] / 2 - f_bracket_width(body_shaft_radius) / 2), 0])
            tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
            
    translate ([body_sheet_size[0] / 2 - bracket_thick / 2, (body_sheet_size[1] / 2 - f_bracket_width(body_shaft_radius) / 2), 0])
        mirror([0, 0, 1])
            tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
}
//---------------------------------------------------------------------------
module body_bearing_support_bottom()
{
        // bottom sheet
       translate ([-body_sheet_size[0] / 2, -body_sheet_size[1] / 2, -body_shaft_radius - tube_bracket_base_thick_strong - body_sheet_size[2]] ) body_sheet_with_bearing_and_belt_tensioner();
    // top sheet
       translate ([-body_sheet_size[0] / 2, -body_sheet_size[1] / 2, body_shaft_radius + tube_bracket_base_thick_strong + body_sheet_size[2]]) mirror([0, 0, 1]) body_sheet_with_bearing();
    
            translate ([-body_sheet_size[0] / 2 + bracket_thick / 2, -body_sheet_size[1] / 2 + f_bracket_width(body_shaft_radius) / 2, 0])
            tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
        translate ([-body_sheet_size[0] / 2 + bracket_thick / 2, -body_sheet_size[1] / 2 + f_bracket_width(body_shaft_radius) / 2, 0])
        mirror([0, 0, 1])
            tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
       
        translate ([+body_sheet_size[0] / 2 - bracket_thick / 2, -body_sheet_size[1] / 2 + f_bracket_width(body_shaft_radius) / 2, 0])
            tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
        translate ([body_sheet_size[0] / 2 - bracket_thick / 2, -body_sheet_size[1] / 2 + f_bracket_width(body_shaft_radius) / 2, 0])
        mirror([0, 0, 1])
            tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
// back
        translate ([-body_sheet_size[0] / 2 + bracket_thick / 2, (body_sheet_size[1] / 2 - f_bracket_width(body_shaft_radius) / 2), 0])
            tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
        translate ([-body_sheet_size[0] / 2 + bracket_thick / 2, (body_sheet_size[1] / 2 - f_bracket_width(body_shaft_radius) / 2), 0])
        mirror([0, 0, 1])
            tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
       
        translate ([+body_sheet_size[0] / 2 - bracket_thick / 2, (body_sheet_size[1] / 2 - f_bracket_width(body_shaft_radius) / 2), 0])
            tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
        translate ([body_sheet_size[0] / 2 - bracket_thick / 2, (body_sheet_size[1] / 2 - f_bracket_width(body_shaft_radius) / 2), 0])
        mirror([0, 0, 1])
            tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
}
//---------------------------------------------------------------------------
module body_motor_module()
{
    translate ([-body_motor_sheet_size[0] / 2, -body_motor_sheet_size[1] / 2, -body_shaft_radius - tube_bracket_base_thick_strong])  mirror ([0, 0, 1]) body_sheet_with_motor();
      // motor sheet bracket
// bottom
    translate ([-body_motor_sheet_size[0] / 2 + bracket_thick / 2, -(body_motor_sheet_size[1] / 2 - f_bracket_width(body_shaft_radius) / 2), 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    translate ([-body_motor_sheet_size[0] / 2 + bracket_thick / 2, body_motor_sheet_size[1] / 2 - f_bracket_width(body_shaft_radius) / 2, 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
// top
    translate ([-body_motor_sheet_size[0] / 2 + bracket_thick / 2, -(body_motor_sheet_size[1] / 2 - f_bracket_width(body_shaft_radius) / 2), 0]) mirror([0, 0, 1]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    translate ([-body_motor_sheet_size[0] / 2 + bracket_thick / 2, body_motor_sheet_size[1] / 2 - f_bracket_width(body_shaft_radius) / 2, 0]) mirror([0, 0, 1]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);


// other side
    // bottom
    translate ([-body_motor_sheet_size[0] / 2 - bracket_thick / 2 + body_motor_sheet_size[0], -(body_motor_sheet_size[1] / 2 - f_bracket_width(body_shaft_radius) / 2), 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    translate ([-body_motor_sheet_size[0] / 2 - bracket_thick / 2 + body_motor_sheet_size[0], body_motor_sheet_size[1] / 2 - f_bracket_width(body_shaft_radius) / 2, 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    // top
    translate ([-body_motor_sheet_size[0] / 2 - bracket_thick / 2 + body_motor_sheet_size[0], -(body_motor_sheet_size[1] / 2 - f_bracket_width(body_shaft_radius) / 2), 0]) mirror([0, 0, 1]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    translate ([-body_motor_sheet_size[0] / 2 - bracket_thick / 2 + body_motor_sheet_size[0], body_motor_sheet_size[1] / 2 - f_bracket_width(body_shaft_radius) / 2, 0]) mirror([0, 0, 1]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    
    // top sheet
    translate ([-body_motor_sheet_size[0] / 2, -body_motor_sheet_size[1] / 2, +body_shaft_radius + tube_bracket_base_thick_strong])
    body_sheet_for_motor_support_top();
    
    // screws
    bracket_holes = f_tube_bracket_holes(body_motor_sheet_size[0], body_shaft_radius);
    for (i = [0 : 3]){
            translate([-body_motor_sheet_size[0] / 2, -body_motor_sheet_size[1] / 2, 25] - display_tolerance_z) translate(bracket_holes[i]) mirror([0, 0, 1]) M4_hexa(50);
    }

    for (i = [0 : 3]){
            translate([-body_motor_sheet_size[0] / 2, body_motor_sheet_size[1] / 2 - f_bracket_width(body_shaft_radius), 25] - display_tolerance_z) translate(bracket_holes[i]) mirror([0, 0, 1]) M4_hexa(50);
        }
}
//---------------------------------------------------------------------------
module body_intramodule_connector()
{
    // aluminium sheets
    translate ([body_shaft_radius + tube_bracket_base_thick_strong + body_intermodule_sheet_size[2], -body_intermodule_sheet_size[1] / 2, -body_intermodule_sheet_size[0] / 2]) rotate([0, -90, 0]) body_sheet_for_intramodule();
    translate ([-body_shaft_radius - tube_bracket_base_thick_strong, -body_intermodule_sheet_size[1] / 2, -body_intermodule_sheet_size[0] / 2]) rotate([0, -90, 0]) body_sheet_for_intramodule();
    // front
    // top
    translate ([0, - distance_between_body_modules / 2, body_intermodule_sheet_size[0] / 2 - bracket_thick / 2]) rotate([0, 90, 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    
    translate ([0, - distance_between_body_modules / 2, body_intermodule_sheet_size[0] / 2 - bracket_thick / 2]) rotate([0, -90, 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
// bottom
    translate ([0, - distance_between_body_modules / 2, bracket_thick / 2-body_intermodule_sheet_size[0] / 2]) rotate([0, 90, 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    
    translate ([0, - distance_between_body_modules / 2, bracket_thick / 2-body_intermodule_sheet_size[0] / 2]) rotate([0, -90, 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
// back
// top
    translate ([0, distance_between_body_modules / 2, body_intermodule_sheet_size[0] / 2 - bracket_thick / 2]) rotate([0, -90, 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    
    translate ([0, distance_between_body_modules / 2, body_intermodule_sheet_size[0] / 2 - bracket_thick / 2]) rotate([0, 90, 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
// bottom
    translate ([0, distance_between_body_modules / 2, bracket_thick / 2 - body_intermodule_sheet_size[0] / 2]) rotate([0, -90, 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    
    translate ([0, distance_between_body_modules / 2, bracket_thick / 2- body_intermodule_sheet_size[0] / 2]) rotate([0, 90, 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
}
//---------------------------------------------------------------------------
module body()
{
    translate ([0, -distance_between_body_modules / 2, 0]) body_module();
    
    translate ([0, distance_between_body_modules / 2, 0]) body_module();
    // bottom intermodule parts
    ///////////////////////////////////////////////////////////////////////
    
    translate ([0, 0, body_height / 2 + body_shaft_radius - body_intermodule_offset]) 
        body_intramodule_connector();
    // top intermodule parts
    translate ([0, 0, body_height / 2 + body_shaft_radius + body_intermodule_offset]) 
        body_intramodule_connector();
    
///////////////////////////////////////////////////////////////////////
    // left arm
    translate ([-(body_width / 2 -dist_edge_to_body_shaft), 0, 0]) {
    // bone first
        translate([0, 0, -rbearing_6907_housing_size[2] - body_shaft_radius - body_sheet_size[2] - tube_bracket_base_thick])
            body_arm_bone(body_arm_shaft_length);
        
    // traction pulley
        translate ([0, 0, -(body_shaft_radius + body_sheet_size[2] + tube_bracket_base_thick + 5) - 11]) rotate([0, 0, angle_body_arm]) body_arm_traction_pulley();
        
    // bottom arm support
        body_bearing_support_bottom();

// top arm support
    // bottom sheet
        translate([0, 0, body_height + 2 * body_shaft_radius])  body_bearing_support_top();
   
       // motor with sheet
        translate ([offset_body_motor_sheet, 0, 0])
            body_motor_module();
    }
    
    // right arm
    // bone first    
    translate ([(body_width / 2 - dist_edge_to_body_shaft), 0, 0]){
        translate([0, 0, -11 - 4 - body_shaft_radius - body_sheet_size[2] - tube_bracket_base_thick])
          body_arm_bone(body_arm_shaft_length);
        
    // traction pulley
        translate ([0, 0, -(body_shaft_radius + body_sheet_size[2] + tube_bracket_base_thick + 5) - 11]) rotate([0, 0, angle_body_arm]) body_arm_traction_pulley();
        
    // bottom arm support
        mirror ([1, 0, 0]) body_bearing_support_bottom();
        
        translate([0, 0, body_height + 2 * body_shaft_radius]) 
            body_bearing_support_top();

        translate ([-offset_body_motor_sheet, 0, 0])
            body_motor_module();
    }

}    
//---------------------------------------------------------------------------

body();

//body_arm_traction_pulley();

//body_bearing_support_top();

//body_sheet_for_motor_support();

//body_sheet_with_motor();

//body_sheet_with_bearing();

//corner_sheet(body_shaft_radius);

//body_sheet_with_bearing_and_belt_tensioner();

//body_module();

//tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true); 

//body_motor_module();

//body_sensor_support();
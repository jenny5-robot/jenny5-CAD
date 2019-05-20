// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../../basic_scad/params_sheets.scad>
include <../../basic_scad/params_basic_components.scad>
use <../../basic_scad/basic_components.scad>

include <../../basic_scad/config.scad>

include <body_params.scad>
include <../../basic_scad/params_screws_nuts_washers.scad>
use <../../basic_scad/screws_nuts_washers.scad>

include <../../basic_scad/params_radial_bearings.scad>
use <../../basic_scad/radial_bearings.scad>

use <../../basic_scad/stepper_motors.scad>
include <../../basic_scad/params_stepper_motors.scad>

use <../../basic_scad/radial_bearing_housing.scad>

use <../../basic_scad/belt.scad>
use <../../basic_scad/belt_tensioner.scad>
include <../../basic_scad/params_belt_tensioner.scad>

use <../../basic_scad/thrust_bearing_housing.scad>
include <../../basic_scad/params_thrust_bearing_housing.scad>

include <../../basic_scad/params_thrust_bearings.scad>

use <../../basic_scad/thrust_bearings.scad>

use <../../basic_scad/linear_motors.scad>
include <../../basic_scad/tolerance.scad>

use <../../basic_scad/corners.scad>

use <../../basic_scad/tube_bracket.scad>
include <../../basic_scad/params_tube_bracket.scad>

include <../../basic_scad/params_corners.scad>

use <body_sheets.scad>
use <../../basic_scad/motor_pulley.scad>
use <body_pulleys.scad>

include <../../basic_scad/as5147_params.scad>
use <../../basic_scad/as5147.scad>

use <../arm/arm.scad>
include <../arm/arm_params.scad>

use <body_sensor_support.scad>

use <body_bones.scad>

//---------------------------------------------------------------------------
module body_module_corner()
{
    translate ([-18, 0, 0]) rotate ([90, 0, 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    translate ([18, 0, 0]) rotate ([90, 0, 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    translate ([-18, 0, 0]) rotate ([-90, 0, 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    translate ([18, 0, 0]) rotate ([-90, 0, 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);

    translate ([0, 0, 27]) rotate ([0, 90, 90]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    translate ([0, 0, 64]) rotate ([0, 90, 90]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    translate ([0, 0, 27]) rotate ([0, 90, -90]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    translate ([0, 0, 64]) rotate ([0, 90, -90]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    
    translate ([-corner_sheet_size[0] / 2, -(body_shaft_radius + tube_bracket_base_thick_strong), - f_bracket_width(body_shaft_radius) / 2]) rotate ([90, 0, 0]) corner_sheet(body_shaft_radius);
    translate ([-corner_sheet_size[0] / 2, (body_shaft_radius + tube_bracket_base_thick_strong) + corner_sheet_size[2], - f_bracket_width(body_shaft_radius) / 2]) rotate ([90, 0, 0]) corner_sheet(body_shaft_radius);
}
//---------------------------------------------------------------------------
module body_module()
{
    // vertical tube
    translate ([0, 0, body_shaft_radius]) color ("black")cylinder (h = body_height, r = body_shaft_radius);
    // bottom tube
    translate ([-body_width / 2, 0, 0]) rotate ([0, 90, 0]) color ("black")cylinder (h = body_width, r = body_shaft_radius);
    // top tube
    translate ([-body_width / 2, 0, body_height + 2 * body_shaft_radius]) rotate ([0, 90, 0]) color ("black") cylinder (h = body_width, r = body_shaft_radius);
        // bottom corner
    body_module_corner();
    translate ([0, 0, body_height + 2 * body_shaft_radius])
    mirror([0, 0, 1])
    body_module_corner();
   // rotate ([90, 0, 0]) tube_corner(body_shaft_radius);
        // top corner
    //translate ([0, 0, body_height + 2 * body_shaft_radius]) rotate ([-90, 0, 0]) tube_corner(body_shaft_radius);
    
}
//---------------------------------------------------------------------------

module body_sheet_with_bearing()
{
    // sheet
    body_sheet_for_bearing_support_top();
    // bearing
    translate([body_sheet_size[0] / 2, body_sheet_size[1] / 2, body_sheet_size[2]])
    6905rs();
    // bearing housing
    translate([body_sheet_size[0] / 2, body_sheet_size[1] / 2, 0]) translate ([0, 0, rbearing_6905_housing_size[2] + body_sheet_size[2]]) mirror([0, 0, 1]) rbearing_6905_housing();
    
    // screws
    for (i = [1 : 4])
            translate([body_sheet_size[0] / 2, body_sheet_size[1] / 2, 0]) translate(rbearing_6905_housing_holes_position[i]) {
                // screw
                M4x18_sunken();
                //washer
                translate([0, 0, body_sheet_size[2] + rbearing_6905_housing_size[2]]) M4x12_washer();
                // autolock nut
                translate([0, 0, body_sheet_size[2] + rbearing_6905_housing_size[2] + washer_4_thick]) M4_autolock_nut();
            }
}
//---------------------------------------------------------------------------
module body_sheet_with_bearing_and_belt_tensioner()
{
    // sheet
    body_sheet_for_bearing_support_bottom();
    // bearing
    translate([body_sheet_size[0] / 2, body_sheet_size[1] / 2, body_sheet_size_bottom[2]])
    6905rs();
    // bearing housing
    translate([body_sheet_size[0] / 2, body_sheet_size[1] / 2, 0]) translate ([0, 0, rbearing_6905_housing_size[2] + body_sheet_size[2]]) mirror([0, 0, 1]) rbearing_6905_housing();
    
    // screws
    for (i = [1 : 4])
            translate([body_sheet_size[0] / 2, body_sheet_size[1] / 2, 0]) translate(rbearing_6905_housing_holes_position[i]) {
                // screw
                M4x18_sunken();
                //washer
                translate([0, 0, body_sheet_size[2] + rbearing_6905_housing_size[2]]) M4x12_washer();
                // autolock nut
                translate([0, 0, body_sheet_size[2] + rbearing_6905_housing_size[2] + washer_4_thick]) M4_autolock_nut();
            }
// belt tensioner            
  translate ([body_sheet_size_bottom[0] - 4, body_motor_sheet_size[1] / 2 - 15, -rb_624_thick -wall_thick_2]) 624rs();
  translate ([body_sheet_size_bottom[0] - 4, body_motor_sheet_size[1] / 2 + 15, - rb_624_thick- wall_thick_2]) 624rs();
  translate ([body_sheet_size_bottom[0] - 4, body_motor_sheet_size[1] / 2 - 15, - 2 *rb_624_thick - wall_thick_2]) 624rs();
  translate ([body_sheet_size_bottom[0] - 4, body_motor_sheet_size[1] / 2 + 15, - 2 * rb_624_thick - wall_thick_2]) 624rs();
  translate ([body_sheet_size_bottom[0] - 4, body_motor_sheet_size[1] / 2 - 15, - 3 * rb_624_thick - wall_thick_2]) 624rs();
  translate ([body_sheet_size_bottom[0] - 4, body_motor_sheet_size[1] / 2 + 15, - 3 * rb_624_thick - wall_thick_2]) 624rs();
    
  translate ([body_sheet_size_bottom[0] - 4, body_motor_sheet_size[1] / 2 - 15, body_motor_sheet_size[2]]) mirror ([0, 0, 1]) M4x25_hexa();
  translate ([body_sheet_size_bottom[0] - 4, body_motor_sheet_size[1] / 2 + 15, body_motor_sheet_size[2]]) mirror ([0, 0, 1]) M4x25_hexa();
            
}
//---------------------------------------------------------------------------
module body_sheet_with_motor()
{
    body_sheet_for_motor_support();
    
    translate ([body_motor_sheet_size[0] / 2, body_motor_sheet_size[1] / 2, -nema_17_with_19_1_gearbox_height]) rotate ([0, 0, 45]) nema_17_with_19_1_gearbox();
    
    translate ([body_motor_sheet_size[0] / 2, body_motor_sheet_size[1] / 2, body_motor_sheet_size[2] + 5]) motor_pulley_8mm_shaft();
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
            translate([-body_motor_sheet_size[0] / 2, body_motor_sheet_size[1] / 2 - f_bracket_width(body_shaft_radius), 25] - display_tolerance_z) translate(bracket_holes[i])mirror([0, 0, 1]) M4_hexa(50);
        }
}
//---------------------------------------------------------------------------
module body_intramodule()
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
        body_intramodule();
    // top intermodule parts
    translate ([0, 0, body_height / 2 + body_shaft_radius + body_intermodule_offset]) 
        body_intramodule();
    
///////////////////////////////////////////////////////////////////////
    // left arm
    translate ([-(body_width / 2 -dist_edge_to_body_shaft), 0, 0]) {
    // vertical axis
        translate([0, 0, -rbearing_6905_housing_size[2] - body_shaft_radius - body_sheet_size[2] - tube_bracket_base_thick])
            color ("black") body_arm_bone(body_arm_shaft_length);
        
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
    translate ([(body_width / 2 - dist_edge_to_body_shaft), 0, 0]){
        translate([0, 0, -11 - 4 - body_shaft_radius - body_sheet_size[2] - tube_bracket_base_thick])
          color ("black") body_arm_bone(body_arm_shaft_length);
        
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
module body_with_rotation(linear_motor_position)
{
    translate ([0, -(alu_sheet_3_thick + 37 / 2), 0]) rotate ([0, 0, 0]) translate ([0, alu_sheet_3_thick + 37 / 2, 0]) body();
}
//---------------------------------------------------------------------------

body_with_rotation(linear_motor_position = body_rotation_linear_motor_position);

//body();

//body_arm_traction_pulley();

//half_1_body_arm_traction_pulley();
//half_2_body_arm_traction_pulley();

//body_bearing_support_top();

//body_sheet_for_bearing_support();

//body_sheet_for_motor_support();

//body_sheet_with_motor();

//body_sheet_with_bearing();

//corner_sheet(body_shaft_radius);

//rbearing_6905_housing(); // 8x

//body_sheet_with_bearing_and_belt_tensioner();

//body_module_corner();

//body_intramodule();
//half_1_traction_gear(); // 2x
//half_2_traction_gear(); // 2x

//motor_pulley_8mm_shaft(); // 2x

//body_module();

//motor_gear_D(hole_radius = 4, thick = 16);

//corner_half_T(body_shaft_radius); // 4x

//bearing_housing_top_body();

//tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, false); // 2x

//body_motor_module();

//body_sensor_support();
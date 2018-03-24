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

include <params_arm_breadboard.scad>
use <arm_breadboard.scad>

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
include <../basic_scad/tolerance.scad>

include <../basic_scad/params_pulleys.scad>
use <../basic_scad/pulleys.scad>
use <../basic_scad/radial_bearing_housing_pot_support.scad>

use <../basic_scad/radial_bearings.scad>

use <../basic_scad/corners.scad>

use <../basic_scad/tube_bracket.scad>
include <../basic_scad/params_tube_bracket.scad>

use <../basic_scad/parametric_involute_gear_v5.0.scad>

use <potentiometer_gears.scad>

include <../basic_scad/params_corners.scad>

use <body_sheets.scad>
use <motor_pulley.scad>

//---------------------------------------------------------------------------
module radial_bearing_housing_with_potentiometer_body()
{
  radial_bearing_housing_with_potentiometer_support(rbearing_6905_housing_size, rbearing_6905_housing_holes_position, rb_6905_external_radius, rb_6905_thick, rbearing_6905_housing_size[2], m4_screw_radius, 25);
    
    translate ([rbearing_6905_housing_size[0] / 2 + pot_92R1A_J22_L15L_base_length / 2, 0, pot_92R1A_J22_L15L_base_height + 2]) mirror([0, 0, 1]) potentiometer_92R1A_J22_L15L();
    
    translate ([rbearing_6905_housing_size[0] / 2 + pot_92R1A_J22_L15L_base_length / 2, 0, -pot_92R1A_J22_L15L_base_height - 3]) pot_gear(num_teeth = 15, internal_radius = 3.3, height = 8, screw_rotation_angle = 15);
}
//---------------------------------------------------------------------------

module body_arm_bone(bone_length)
{
    echo("body arm bone length = ", bone_length);
    
    cylinder_empty(bone_length, body_shaft_radius, body_shaft_radius - 2);
}
//---------------------------------------------------------------------------
module body_arm_traction_pulley()
{
    difference(){
        pulley(profile = 56, num_teeth = 44, pulley_b_ht = 0, pulley_b_dia = 17, pulley_t_ht = 8);
        
        translate(- display_tolerance_z) cylinder(h = body_shaft_pulley_height + 2 * display_tolerance, r = body_shaft_radius, $fn = 30);

        // 1st screw hole
        dist_to_1st_screw = 17;
        
        dist_to_nut = 14;
        translate ([-30, dist_to_1st_screw, body_shaft_pulley_height / 2]) rotate ([0, 90, 0]) cylinder(h = 50, r = m4_screw_radius, $fn = 20);
        // 1 st screw head hole
        translate ([15, dist_to_1st_screw, body_shaft_pulley_height / 2]) rotate ([0, 90, 0]) cylinder(h = 30, r = 3.5, $fn = 20);
        // nut hole
        hull(){
            translate ([-dist_to_nut - m4_nut_thick, dist_to_1st_screw, body_shaft_pulley_height / 2]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
            translate ([-dist_to_nut - m4_nut_thick, dist_to_1st_screw, body_shaft_pulley_height]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
        }

        // 2nd screw hole
        
        translate ([-25, -dist_to_1st_screw, body_shaft_pulley_height / 2]) rotate ([0, 90, 0]) cylinder(h = 55, r = m4_screw_radius, $fn = 20);
        // screw head hole
        translate ([-40, -dist_to_1st_screw, body_shaft_pulley_height / 2]) rotate ([0, 90, 0]) cylinder(h = 17, r = 3.5, $fn = 20);
        // nut hole
        hull(){
            translate ([dist_to_nut, -dist_to_1st_screw, body_shaft_pulley_height / 2]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
            translate ([dist_to_nut, -dist_to_1st_screw, body_shaft_pulley_height]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick + 0.3, r = m4_nut_radius, $fn = 6);
        }
    }
}
//---------------------------------------------------------------------------
module half_1_traction_pulley()
{
    difference(){
        body_arm_traction_pulley();
        translate ([0, -40, 0] - display_tolerance_z) cube([40, 80, 13] + 2 * display_tolerance_z);
    }
}
//---------------------------------------------------------------------------
module half_1_traction_pulley()
{
    difference(){
        body_arm_traction_pulley();
        translate ([-30, -30, 0] - display_tolerance_z) cube([30, 60, 11] + 2 * display_tolerance_z);
    }
}
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
module body_sheet_with_bearing_and_potentiometer()
{
        // sheet
    body_sheet_for_bearing_support();
    // bearing
    translate([body_sheet_size[0] / 2, body_sheet_size[1] / 2, body_sheet_size[2]])
    6905rs();
    // bearing housing
    translate([body_sheet_size[0] / 2, body_sheet_size[1] / 2, 0]) translate ([0, 0, rbearing_6905_housing_size[2] + body_sheet_size[2]]) mirror([0, 0, 1]) 
    radial_bearing_housing_with_potentiometer_body();
}
//---------------------------------------------------------------------------
module body_sheet_with_motor()
{
    body_sheet_for_motor_support();
    
    translate ([body_motor_sheet_size[0] / 2, body_motor_sheet_size[1] / 2, -nema_17_with_19_1_gearbox_height]) nema_17_with_19_1_gearbox();
    
    translate ([body_motor_sheet_size[0] / 2, body_motor_sheet_size[1] / 2, body_motor_sheet_size[2] + 5]) motor_pulley_8mm_shaft();
}
//---------------------------------------------------------------------------
module body_potentiometer_shaft_gear()
{
    bone_gear(num_teeth = 17, screw_rotation_angle = 11, internal_radius = 12.5, height = 10);
}
//---------------------------------------------------------------------------
module body_bearing_support_top()
{
        // bottom sheet
       translate ([-body_sheet_size[0] / 2, -body_sheet_size[1] / 2, -body_shaft_radius - tube_bracket_base_thick_strong - body_sheet_size[2]] ) body_sheet_with_bearing();
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
    translate ([-body_motor_sheet_size[0] / 2 + bracket_thick / 2, -(body_motor_sheet_size[1] / 2 - f_bracket_width(body_shaft_radius) / 2), 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    translate ([-body_motor_sheet_size[0] / 2 + bracket_thick / 2, body_motor_sheet_size[1] / 2 - f_bracket_width(body_shaft_radius) / 2, 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);

    translate ([-body_motor_sheet_size[0] / 2 - bracket_thick / 2 + body_motor_sheet_size[0], -(body_motor_sheet_size[1] / 2 - f_bracket_width(body_shaft_radius) / 2), 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);
    translate ([-body_motor_sheet_size[0] / 2 - bracket_thick / 2 + body_motor_sheet_size[0], body_motor_sheet_size[1] / 2 - f_bracket_width(body_shaft_radius) / 2, 0]) tube_bracket_long_one_hole(bracket_thick, body_shaft_radius, true);

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
        translate ([0, 0, body_shaft_radius + body_sheet_size[2] + tube_bracket_base_thick + 5]) rotate([0, 0, angle_body_arm]) body_arm_traction_pulley();
        
    // bottom arm support
        mirror ([1, 0, 0]) body_bearing_support_bottom();
        
        translate([0, 0, body_height + 2 * body_shaft_radius]) 
            body_bearing_support_top();

        translate ([-offset_body_motor_sheet, 0, 0])
            body_motor_module();
    }
    // breadboard for arms
    translate ([0, 0, 100]) arms_breadboard();
    // top thrust bearing housing

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
    translate ([(body_width / 2 - dist_edge_to_body_shaft), 0, body_shaft_radius + body_height / 2 + plate_body_size[0] / 2])
        rotate ([0, 0, angle_body_arm])  
        translate ([0, -body_arm_offset, 0]) 
        translate ([-body_shaft_radius - plate_body_size[2], 0, 0]) 
        rotate ([0, 90, 0]) 
        arm(body_arm_shaft_length)
        ;

// body brackets
// top
        translate ([(body_width / 2 - dist_edge_to_body_shaft), 0, body_shaft_radius + body_height / 2 + plate_body_size[0] / 2])    
    rotate ([0, 0, angle_body_arm])
    translate ([0, 0, -body_arm_bracket_thick / 2]) 
    rotate ([0, -90, 0]) 
    tube_bracket_long_one_hole(bracket_thick = body_arm_bracket_thick, tube_radius = body_shaft_radius)
    ;
// bottom
        translate ([(body_width / 2 - dist_edge_to_body_shaft), 0, body_shaft_radius + body_height / 2 - plate_body_size[0] / 2])    
    rotate ([0, 0, angle_body_arm])
    translate ([0, 0, body_arm_bracket_thick / 2]) 
    rotate ([0, -90, 0]) 
    tube_bracket_long_one_hole(bracket_thick = body_arm_bracket_thick, tube_radius = body_shaft_radius)
    ;
/////////////////////////////////////////////////////////////////////////
    // right arm
    translate ([-body_width / 2 + dist_edge_to_body_shaft, 0, body_shaft_radius + body_height / 2 + plate_body_size[0] / 2]) 
        rotate ([0, 0, -angle_body_arm]) 
           translate ([0, -body_arm_offset, 0]) 
    
    translate ([body_shaft_radius + plate_body_size[2], 0, 0]) 
    mirror([1, 0, 0])
    rotate ([0, 90, 0]) 
 //   arm(body_arm_shaft_length)
    ;
    
    // brackets
    // top
        translate ([-(body_width / 2 - dist_edge_to_body_shaft), 0, body_shaft_radius + body_height / 2 + plate_body_size[0] / 2])    
    rotate ([0, 0, -angle_body_arm])
    translate ([0, 0, -body_arm_bracket_thick / 2]) 
    rotate ([0, 90, 0]) 
    tube_bracket_long_one_hole(bracket_thick = body_arm_bracket_thick, tube_radius = body_shaft_radius)
    ;
// bottom
   
        translate ([-(body_width / 2 - dist_edge_to_body_shaft), 0, body_shaft_radius + body_height / 2 - plate_body_size[0] / 2])   
    rotate ([0, 0, -angle_body_arm])
    translate ([0, 0, body_arm_bracket_thick / 2]) 
    rotate ([0, 90, 0]) 
    tube_bracket_long_one_hole(bracket_thick = body_arm_bracket_thick, tube_radius = body_shaft_radius)
    ;

           
}
//---------------------------------------------------------------------------


body_with_arms();

//body_with_rotation(linear_motor_position = body_rotation_linear_motor_position);

//body();

//body_arm_traction_pulley();

//body_sheet_for_bearing_support();

//body_sheet_for_motor_support();

//body_sheet_with_motor();

//body_sheet_with_bearing();

//rbearing_6905_double_housing_with_potentiometer_support(); // 2x

//corner_sheet(body_shaft_radius);

//rbearing_6905_housing(); // 8x

//body_sheet_with_bearing_and_belt_tensioner();

//body_arm_traction_gear();

//body_motor_module();

//body_module_corner();


     //body_intramodule();
//half_1_traction_gear(); // 2x
//half_2_traction_gear(); // 2x

//motor_pulley_8mm_shaft(); // 2x

//body_module();

//motor_gear_D(hole_radius = 4, thick = 16);

//corner_half_T(body_shaft_radius); // 4x

//bearing_housing_top_body();

//radial_bearing_housing_with_potentiometer_body();
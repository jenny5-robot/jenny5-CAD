// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_stepper_motors.scad>

include <../basic_scad/params_basic_components.scad>
use <../basic_scad/basic_components.scad>
use <../basic_scad/stepper_motors.scad>
include <../basic_scad/params_screws_nuts_washers.scad>
use <../basic_scad/screws_nuts_washers.scad>
include <../basic_scad/params_radial_bearings.scad>
use <../basic_scad/radial_bearings.scad>
use <../basic_scad/stepper_motors_housing.scad>
include <../basic_scad/params_motor_housing.scad>
use <../basic_scad/radial_bearing_housing.scad>
include <../basic_scad/config.scad>
include <../basic_scad/params_radial_bearings_housing.scad>

include <../basic_scad/params_nuts_housing.scad>
use <../basic_scad/parametric_involute_gear_v5.0.scad>

include <params_leg.scad>

use <../basic_scad/linear_motors.scad>

include <../basic_scad/params_motor_housing.scad>

use <../basic_scad/func_3d.scad>

//-------------------------------------------------------
module base_side(base_height = 40)
{
    difference(){
        color (aluminium_color) cube([lateral_base_size[0], lateral_base_size[1], base_height]);
     // hole first bone
        translate ([dist_to_first_bone, 0, base_height - 8] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = m8_screw_radius, $fn = 30);
     // hole second bone
        translate ([dist_to_second_bone, 0, base_height - 8] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = m8_screw_radius, $fn = 30);
        // hole spacer 1
        translate ([dist_to_first_spacer, 0, rectangular_tube_30x30x3_size[1] / 2] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = m8_screw_radius, $fn = 30);
        // hole spacer 2
        translate ([dist_to_second_spacer, 0, rectangular_tube_30x30x3_size[1] / 2] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = m8_screw_radius, $fn = 30);
     // hole motor shaft
        translate ([dist_to_push_motor_hole_in_base, 0, dist_to_wrist_in_base] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = m8_screw_radius, $fn = 30);
    }
}
//-------------------------------------------------------
module knee_side()
{
    difference(){
        // sheet
        color (aluminium_color) cube(knee_side_simple_sizes);
        // front hole bottom
        translate ([dist_to_first_bone, 0, 8] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = 4, $fn = 30);
        // front hole top
        translate ([dist_to_first_bone, 0, knee_side_simple_sizes[2] - 8] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = 4, $fn = 30);
        // back hole bottom
        translate ([dist_to_second_bone, 0, 8] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = 4, $fn = 30);
        // back hole top
        translate ([dist_to_second_bone, 0, knee_side_simple_sizes[2] - 8] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = 4, $fn = 30);
    }
}
//-------------------------------------------------------
module base(base_height = 40)
{
    translate ([0, - alu_sheet_10_thick -crotch_width / 2, 0]) base_side(base_height);

    translate ([0, crotch_width / 2, 0]) base_side(base_height);
    
    difference(){
        union(){
        // first spacer
            color (aluminium_color) translate ([dist_to_first_spacer - rectangular_tube_30x30x3_size[1] / 2, - crotch_width / 2, 0]) cube([rectangular_tube_30x30x3_size[1], crotch_width, rectangular_tube_30x30x3_size[1]]);
    // second spacer
            color (aluminium_color) translate ([dist_to_second_spacer - rectangular_tube_30x30x3_size[1] / 2, - crotch_width / 2, 0]) cube([rectangular_tube_30x30x3_size[1], crotch_width, rectangular_tube_30x30x3_size[1]]);
        }
        // holes for fixing the bone to the platform   
        for (i = [0 : 3])
            translate (foot_spacer_holes[i] - display_tolerance_z) cylinder (h = rectangular_tube_30x30x3_size[1] + 2 * display_tolerance, r = m8_screw_radius, $fn = 30);
    }
}
//----------------------------------------------------------------------
module knee()
{
    // one side
    translate ([0, - alu_sheet_10_thick, 0]) knee_side();
// other side
    translate ([0, crotch_width, 0]) knee_side();
    // knee spacer
     color (aluminium_color) translate ([knee_side_simple_sizes[0] / 2, -0, knee_side_simple_sizes[2] / 2]) rotate ([-90, 0, 0]) cylinder (h = crotch_width, r = 15 * sqrt(2), $fn = 4);
}
//----------------------------------------------------------------------
module leg_bone()
{
    difference(){
        
        color (aluminium_color) teava_dreptunghiulara(rectangular_tube_30x30x3_size[1], rectangular_tube_30x30x3_size[0], rectangular_tube_30x30x3_wall_thick, leg_bone_length);
        
// midle hole bottom bearing
        
        echo ("middle hole bottom bearing", [rectangular_tube_30x30x3_size[1] / 2, 0, dist_to_wrist_in_bone] + rbearing_608_housing_holes_position[0], "raza = 6");
        
        translate ([rectangular_tube_30x30x3_size[1] / 2, 0, dist_to_wrist_in_bone] - display_tolerance_y) rotate ([-90, 0, 0]) 
        translate (rbearing_608_housing_holes_position[0]) cylinder (h = rectangular_tube_30x30x3_size[0] + 2 * display_tolerance, r = 4, $fn = 30); 

        translate ([rectangular_tube_30x30x3_size[1] / 2, 0, distance_to_push_position + dist_to_wrist_in_bone] - display_tolerance_y) rotate ([-90, 0, 0]) 
        translate (rbearing_608_housing_holes_position[0]) cylinder (h = rectangular_tube_30x30x3_size[0] + 2 * display_tolerance, r = 4, $fn = 30); 

// holes for fixing the bottom bearing
        for (i=[1:4]){
            echo ("holes for screws holes bottom bearing support", [rectangular_tube_30x30x3_size[1] / 2, dist_to_wrist_in_bone, 0] + rbearing_608_housing_holes_position[i], "raza = 1.6");
            
            translate ([rectangular_tube_30x30x3_size[1] / 2, 0, dist_to_wrist_in_bone] - display_tolerance_y) rotate ([-90, 0, 0]) translate (rbearing_608_housing_holes_position[i]) cylinder (h = rectangular_tube_30x30x3_size[0] + 2 * display_tolerance, r = 1.6, $fn = 30); 
        }
        
// top bearing hole
        translate ([rectangular_tube_30x30x3_size[1] / 2, 0, leg_bone_length - dist_to_wrist_in_bone] - display_tolerance_y) rotate ([-90, 0, 0]) 
        translate (rbearing_608_housing_holes_position[0]) cylinder (h = rectangular_tube_30x30x3_size[0] + 2 * display_tolerance, r = 4, $fn = 30); 

// holes for fixing the top bearing
        for (i=[1:4]){
            echo ("holes for screws holes top bearing support", [rectangular_tube_30x30x3_size[1] / 2, dist_to_wrist_in_bone, 0] + rbearing_608_housing_holes_position[i], "raza = 1.6");
            
            translate ([rectangular_tube_30x30x3_size[1] / 2, 0, leg_bone_length - dist_to_wrist_in_bone] - display_tolerance_y) rotate ([-90, 0, 0]) translate (rbearing_608_housing_holes_position[i]) cylinder (h = rectangular_tube_30x30x3_size[0] + 2 * display_tolerance, r = 1.6, $fn = 30); 
        }
    }
}
//----------------------------------------------------------------------
module leg_bone_with_bearings()
{
  leg_bone();

  translate ([rectangular_tube_30x30x3_size[1] / 2, 0, rbearing_608_housing_size[0] / 2]) rotate ([-90, 0, 0]) mirror([0, 0, 1]) translate (rbearing_608_housing_holes_position[0]) rbearing_608_housing_with_bearing();
// screws for bottom bearing    
    for (i=[1:4]){            
        translate ([rectangular_tube_30x30x3_size[1] / 2, - rbearing_608_housing_size[2] - m4_nut_thick - washer_4_9_thick, dist_to_wrist_in_bone]) rotate ([-90, 0, 0])    translate (rbearing_608_housing_holes_position[i]) M4x12_hexa();
    }

// the other side    
    translate ([rectangular_tube_30x30x3_size[1] / 2, rectangular_tube_30x30x3_size[1], rbearing_608_housing_size[0] / 2]) rotate ([-90, 0, 0]) translate (rbearing_608_housing_holes_position[0]) rbearing_608_housing_with_bearing();
    for (i=[1:4]){            
      translate ([rectangular_tube_30x30x3_size[1] / 2, - rbearing_608_housing_size[2] - m4_nut_thick - washer_4_9_thick, dist_to_wrist_in_bone]) rotate ([-90, 0, 0]) translate (rbearing_608_housing_holes_position[i]) M4_hexa(55);
    }
        
        
    translate ([rectangular_tube_30x30x3_size[1] / 2, 0, leg_bone_length - rbearing_608_housing_size[0] / 2]) rotate ([-90, 0, 0]) mirror([0, 0, 1]) translate (rbearing_608_housing_holes_position[0]) rbearing_608_housing_with_bearing();
// screws for bottom bearing    
    for (i=[1:4]){            
      translate ([rectangular_tube_30x30x3_size[1] / 2, - rbearing_608_housing_size[2] - m4_nut_thick - washer_4_9_thick, leg_bone_length - dist_to_wrist_in_bone]) rotate ([-90, 0, 0]) translate (rbearing_608_housing_holes_position[i]) M4_hexa(55);
    }

    translate ([rectangular_tube_30x30x3_size[1] / 2, rectangular_tube_30x30x3_size[1], leg_bone_length - rbearing_608_housing_size[0] / 2]) rotate ([-90, 0, 0]) translate (rbearing_608_housing_holes_position[0]) rbearing_608_housing_with_bearing(); 
}
//----------------------------------------------------------------------
module sheet_push_motor()
{
    difference(){
        translate ([-nema_17_width / 2, -nema_17_width / 2, 0]) cube([nema_17_width, nema_17_width, 3]);
        for (i = [0:3]){
            translate (nema_17_housing_base_holes[i] - display_tolerance_z) cylinder ( h = 3 + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
          }
    }
}
//----------------------------------------------------------------------
module linear_motor_with_top_shaft(stroke, current_position)
{
    linear_dc_motor(stroke, current_position);

    motor_base_length = 105 + stroke - 20;

    translate([0, 0, motor_base_length + 10]) 
      // perpendicular shaft
        translate ([0, -crotch_width / 2, current_position + 10]) rotate([-90, 0, 0]) cylinder(h = crotch_width, r = 4);
}
//----------------------------------------------------------------------
module half_leg(motor_position = 0, base_height = 40)
{
    h = 2 * area_heron(leg_base_length - 8 - dist_to_first_bone, 205 + motor_position- 19, distance_to_push_position) / (leg_base_length - 8 - dist_to_first_bone);
   
    echo(h = h);
    leg_angle = 90 - asin( h / distance_to_push_position);
    echo(leg_angle = leg_angle);
    
    // bottom sheet
    base(base_height);
    // back bone 1
    translate ([dist_to_second_bone, crotch_width / 2 - rectangular_tube_30x30x3_size[1] - rbearing_608_housing_size[2] - 5, base_height - 8])
    rotate ([0, leg_angle, 0])
    translate ([-rectangular_tube_30x30x3_size[1] / 2, 0, -dist_to_wrist_in_bone])
    leg_bone_with_bearings();
    
    // back bone 2
    translate ([dist_to_second_bone, - crotch_width / 2 + rbearing_608_housing_size[2] + 5, base_height - 8])
    rotate ([0, leg_angle, 0])
    translate ([-rectangular_tube_30x30x3_size[1] / 2, 0, -dist_to_wrist_in_bone])
    leg_bone_with_bearings();
    
       // front bone 1
    translate ([dist_to_first_bone, crotch_width / 2 - rectangular_tube_30x30x3_size[1] - rbearing_608_housing_size[2] - 5, base_height - 8])
    rotate ([0, leg_angle, 0])
    translate ([-rectangular_tube_30x30x3_size[1] / 2, 0, -dist_to_wrist_in_bone]) 
    leg_bone_with_bearings();
    
       // front bone 2
    translate ([dist_to_first_bone, - crotch_width / 2 + rbearing_608_housing_size[2] + 5, base_height - 8])
    rotate ([0, leg_angle, 0])
    translate ([-rectangular_tube_30x30x3_size[1] / 2, 0, -dist_to_wrist_in_bone]) 
    leg_bone_with_bearings();

    // bottom shaft front
    translate([dist_to_first_bone, -crotch_width / 2 - alu_sheet_10_thick - m8_nut_thick, base_height - 8]) rotate ([-90, 0, 0]) M8_hexa(crotch_width + 2 * alu_sheet_10_thick + 10);
    
    // bottom shaft middle
    translate([dist_to_second_bone, -crotch_width / 2 - alu_sheet_10_thick - m8_nut_thick, base_height - 8]) rotate ([-90, 0, 0]) M8_hexa(crotch_width + 2 * alu_sheet_10_thick + 10);

    // motor shaft
    translate([leg_base_length - 8, -crotch_width / 2 - alu_sheet_10_thick - 10, base_height - 8]) rotate ([-90, 0, 0]) cylinder (h = crotch_width + 2 * alu_sheet_10_thick + 20, r = shaft_radius, $fn = 30);

    // linear motor

    motor_angle = 90 - asin(h / (205 + motor_position - 19));
    echo(motor_angle = motor_angle);
    
    translate([dist_to_push_motor_hole_in_base, 0, base_height - 8])
      rotate ([0, -motor_angle, 0])
         linear_motor_with_top_shaft(100, motor_position);


// knee shaft - first bone    

    translate ([(leg_bone_length - 2 * dist_to_wrist_in_bone) * sin(leg_angle) + dist_to_first_bone, 
    - crotch_width / 2 - alu_sheet_10_thick - m8_nut_thick, 
    (leg_bone_length - 2 * dist_to_wrist_in_bone) * cos(leg_angle) 
    + base_height - 8])
    rotate ([-90, 0, 0])
    M8_hexa(crotch_width + 2 * alu_sheet_10_thick + 10);
    
// knee shaft - second bone    
    translate ([(leg_bone_length - 2 * dist_to_wrist_in_bone) * sin(leg_angle) + dist_to_second_bone, 
    - crotch_width / 2 - alu_sheet_10_thick - m8_nut_thick, 
    (leg_bone_length - 2 * dist_to_wrist_in_bone) * cos(leg_angle) 
    + base_height - 8])
    rotate ([-90, 0, 0])
    M8_hexa(crotch_width + 2 * alu_sheet_10_thick + 10);
}
//----------------------------------------------------------------------
module long_leg(motor_position = 0)
{

 h = 2 * area_heron(leg_base_length - 8 - dist_to_first_bone, 205 + motor_position- 19, distance_to_push_position) / (leg_base_length - 8 - dist_to_first_bone);
   
    leg_angle = 90 - asin( h / distance_to_push_position);

    // bottom leg
    half_leg(motor_position, 60);

    // top leg
    translate ([0, 0, 2 * ((leg_bone_length - 2 * dist_to_wrist_in_bone) * cos(leg_angle) + (50 - 8 + knee_side_simple_sizes[2] / 2 - 8))]) 
    mirror ([0, 0, 1]) half_leg(motor_position, 40);
        
    // knee
    translate ([(leg_bone_length - 2 * dist_to_wrist_in_bone) * sin(leg_angle), 
    - crotch_width / 2, 
    (leg_bone_length - 2 * dist_to_wrist_in_bone) * cos(leg_angle) 
    + dist_to_wrist_in_base - 8])
    knee();
}
//----------------------------------------------------------------------

long_leg(leg_motor_position); // between 0 and 100


//linear_motor_with_top_shaft(100, 50);

//half_leg(motor_position = 100);

//leg_bone_with_bearings();

//base();

//knee();
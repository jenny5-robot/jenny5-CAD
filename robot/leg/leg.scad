// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../../basic_scad/params_stepper_motors.scad>

include <../../basic_scad/params_basic_components.scad>
use <../../basic_scad/basic_components.scad>
use <../../basic_scad/stepper_motors.scad>
include <../../basic_scad/params_screws_nuts_washers.scad>
use <../../basic_scad/screws_nuts_washers.scad>
include <../../basic_scad/params_radial_bearings.scad>
use <../../basic_scad/radial_bearings.scad>
use <../../basic_scad/stepper_motors_housing.scad>
include <../../basic_scad/params_motor_housing.scad>
use <../../basic_scad/radial_bearing_housing.scad>
include <../../basic_scad/config.scad>
include <../../basic_scad/params_radial_bearings_housing.scad>

include <../../basic_scad/params_nuts_housing.scad>

include <leg_params.scad>

use <../../basic_scad/linear_motors.scad>

include <../../basic_scad/params_motor_housing.scad>
include <../../basic_scad/params_alu_profiles.scad>

use <../../basic_scad/alu_profiles.scad>

include <../../basic_scad/tolerance.scad>

use <leg_bones.scad>
use <leg_sheets.scad>

//-------------------------------------------------------
module leg_base_spacer()
{    
  rotate([-90, 0, 0]) alu_sigma_profile_30x30(base_spacer_length);
}
//----------------------------------------------------------------------
module leg_base(base_height = 40)
{
    translate ([0, - (alu_sheet_10_thick + base_spacer_length / 2), 0]) base_side_top(base_height);

    translate ([0, (base_spacer_length / 2), 0]) base_side_top(base_height);
    
    translate ([dist_to_first_spacer, - base_spacer_length / 2, 15]) leg_base_spacer();
    translate ([dist_to_second_spacer, - base_spacer_length / 2, 15]) leg_base_spacer();
}
//----------------------------------------------------------------------
module knee()
{
    // one side
    translate ([0, 0, 0]) knee_side();
// other side
    translate ([0, base_spacer_length + alu_sheet_10_thick, 0]) knee_side();
    // knee spacer
     color (aluminium_color) translate ([knee_side_simple_sizes[0] / 2, alu_sheet_10_thick, knee_side_simple_sizes[2] / 2]) rotate ([0, 45, 0]) leg_base_spacer();
}
//----------------------------------------------------------------------
module linear_motor_with_top_shaft(stroke, current_position)
{
    rotate([0, 0, 180]) linear_dc_motor_simple(stroke);
}
//----------------------------------------------------------------------
module leg_pusher_tube()
{
    cube([25, 25, leg_pusher_tube_length], center = true);
}
//----------------------------------------------------------------------
module front_bones_with_components()
{
  translate ([0, (crotch_width_front / 2 + leg_bone_thick[1] / 2), 0])
        front_bone_with_pusher_components(1);
    
  translate ([0, - (crotch_width_front / 2 + leg_bone_thick[1] / 2), 0])
        front_bone_with_pusher_components(0);
    
    // pusher tube
  translate ([0, -0, leg_distance_to_pusher])
    rotate ([-90, 0, 0]) leg_pusher_tube();
}
//----------------------------------------------------------------------
module half_leg(leg_angle_to_horizontal = 45)
{
    base_height = 40;
    motor_angle_to_horizontal = 50;

    leg_base(base_height);
        
    // back bone 1
    translate ([dist_to_second_bone, crotch_width_back / 2 + leg_bone_thick[1] / 2, dist_to_wrist_in_base])
    rotate ([0, 90 - leg_angle_to_horizontal, 0])
        translate ([0, 0, -rbearing_6001_housing_size_thicker[0] / 2])
    leg_bone_with_bearings()
    ;
    
    // back bone 2
    translate ([dist_to_second_bone, - (crotch_width_back / 2 + leg_bone_thick[1] / 2), dist_to_wrist_in_base])
    rotate ([0, 90 - leg_angle_to_horizontal, 0])
        translate ([0, 0, -rbearing_6001_housing_size_thicker[0] / 2])
    leg_bone_with_bearings()
    ;
    
       // front bones
       
    translate ([dist_to_first_bone, 0, dist_to_wrist_in_base])
    rotate ([0, 90 - leg_angle_to_horizontal, 0])
    rotate ([0, 0, 180])
    translate ([0, 0, -rbearing_6001_housing_size_thicker[0] / 2])
    front_bones_with_components()
    ;
    

    // bottom shaft front
    translate([dist_to_first_bone, -base_spacer_length / 2 - alu_sheet_10_thick - M12_nut_thick, dist_to_wrist_in_base]) rotate ([-90, 0, 0]) cylinder(base_spacer_length + 2 * alu_sheet_10_thick + 2 * M12_nut_thick, r = leg_shaft_radius);
    
    // bottom shaft middle
    translate([dist_to_second_bone, -base_spacer_length / 2 - alu_sheet_10_thick - M12_nut_thick, dist_to_wrist_in_base]) rotate ([-90, 0, 0]) cylinder(base_spacer_length + 2 * alu_sheet_10_thick + 2 * M12_nut_thick, r = leg_shaft_radius);

    // motor shaft
    translate([dist_to_push_motor_hole_in_base, -base_spacer_length / 2 - alu_sheet_10_thick - m8_nut_thick, base_height - 8]) rotate ([-90, 0, 0]) cylinder (h = base_spacer_length + 2 * alu_sheet_10_thick + 2 * m8_nut_thick, r = leg_motor_shaft_radius, $fn = 30);

    // linear motor
    
    translate([dist_to_push_motor_hole_in_base, 0, base_height -8 ]) 
      rotate ([0, -(90 - motor_angle_to_horizontal), 0])
        linear_motor_with_top_shaft(150, 10);
        
// knee shaft - first bone    

    translate ([(leg_bone_length - (rbearing_6001_housing_size_thicker[0])) * sin(90 - leg_angle_to_horizontal) + dist_to_first_bone, 
    - base_spacer_length / 2 - alu_sheet_10_thick - M12_nut_thick, 
    (leg_bone_length - rbearing_6001_housing_size_thicker[0]) * cos(90 - leg_angle_to_horizontal) 
    + base_height - leg_shaft_distance_to_edge])
    rotate ([-90, 0, 0])
    M12_hexa(base_spacer_length + 2 * alu_sheet_10_thick + 2 * M12_nut_thick);
    
// knee shaft - second bone    
    translate ([(leg_bone_length - rbearing_6001_housing_size_thicker[0]) * sin(90 - leg_angle_to_horizontal) + dist_to_second_bone, 
    - base_spacer_length / 2 - alu_sheet_10_thick - M12_nut_thick, 
    (leg_bone_length - rbearing_6001_housing_size_thicker[0]) * cos(90 - leg_angle_to_horizontal) 
    + base_height - leg_shaft_distance_to_edge])
    rotate ([-90, 0, 0])
    M12_hexa(base_spacer_length + 2 * alu_sheet_10_thick + 2 * M12_nut_thick);
}
//----------------------------------------------------------------------
module complete_leg(leg_angle)
{   
    // bottom half leg
    half_leg(leg_angle);

    // top half leg
    translate ([0, 0, 
    2 * ((leg_bone_length - rbearing_6001_housing_size_thicker[0]) * cos(90 - leg_angle) + knee_side_simple_sizes[2] - 2 * leg_shaft_distance_to_edge)]) 
    mirror ([0, 0, 1]) half_leg(leg_angle);
        
    // knee
    translate ([(leg_bone_length - rbearing_6001_housing_size_thicker[0]) * sin(90 - leg_angle) + dist_to_first_bone - leg_shaft_distance_to_edge, 
    - base_spacer_length / 2 - alu_sheet_10_thick, 
    (leg_bone_length - rbearing_6001_housing_size_thicker[0]) * cos(90 - leg_angle) 
    + dist_to_wrist_in_base - leg_shaft_distance_to_edge])
    knee()
    ;
}
//----------------------------------------------------------------------

complete_leg(leg_angle = leg_angle);

//leg_pusher_bearing_sheet();

//leg_bone_with_bearings();

//front_bone_with_pusher_components(1);

//translate ([0, 0, 30]) rotate ([0, 90, 0]) 
//leg_bone();

//linear_motor_with_top_shaft(100, 50);

//half_leg(leg_angle);

//leg_base();

//knee();

//knee_side();

//rbearing_6907_housing_thicker(0); // 4x
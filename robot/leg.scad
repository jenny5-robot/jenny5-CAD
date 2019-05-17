// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
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


include <leg_params.scad>

use <../basic_scad/linear_motors.scad>

include <../basic_scad/params_motor_housing.scad>
include <../basic_scad/params_alu_profiles.scad>

use <../basic_scad/func_3d.scad>

use <../basic_scad/point_transformations_3d.scad>

use <../basic_scad/alu_profiles.scad>

include <../basic_scad/tolerance.scad>

//-------------------------------------------------------
module base_side_bottom(base_height = 40)
{
    color (aluminium_color) 
    render()
    difference(){
        echo("leg base size = ", lateral_bottom_base_size[0], lateral_bottom_base_size[1], base_height);
        cube([lateral_bottom_base_size[0], lateral_bottom_base_size[1], base_height]);
        
     // hole first bone
        echo("first bone hole position = ", dist_to_first_bone, base_height - leg_shaft_distance_to_edge);
        translate ([dist_to_first_bone, 0, base_height - leg_shaft_distance_to_edge] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = M12_screw_radius, $fn = 30);
        
     // hole second bone
        echo("second bone hole position = ", dist_to_second_bone, base_height - leg_shaft_distance_to_edge);
        translate ([dist_to_second_bone, 0, base_height - leg_shaft_distance_to_edge] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = M12_screw_radius, $fn = 30);
                
     // hole motor shaft
        echo("motor support hole position = ", dist_to_push_motor_hole_in_base, base_height - 8);
        translate ([dist_to_push_motor_hole_in_base, 0, base_height - 8] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = m8_screw_radius, $fn = 30);
    }
}
//-------------------------------------------------------
module base_side_top(base_height = 40)
{
    color (aluminium_color) 
    render()
    difference(){
        echo("leg base size = ", lateral_top_base_size[0], lateral_top_base_size[1], base_height);
        cube([lateral_top_base_size[0], lateral_top_base_size[1], base_height]);
        
     // hole first bone
        echo("first bone hole position = ", dist_to_first_bone, base_height - leg_shaft_distance_to_edge);
        translate ([dist_to_first_bone, 0, base_height - leg_shaft_distance_to_edge] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = M12_screw_radius, $fn = 30);
        
     // hole second bone
        echo("second bone hole position = ", dist_to_second_bone, base_height - leg_shaft_distance_to_edge);
        translate ([dist_to_second_bone, 0, base_height - leg_shaft_distance_to_edge] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = M12_screw_radius, $fn = 30);
                
     // hole motor shaft
        echo("motor support hole position = ", dist_to_push_motor_hole_in_base, base_height - 8);
        translate ([dist_to_push_motor_hole_in_base, 0, base_height - 8] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = m8_screw_radius, $fn = 30);
    }
}
//-------------------------------------------------------
module knee_side()
{
    difference(){
        // sheet
        echo("knee size", knee_side_simple_sizes);
        color (aluminium_color) cube(knee_side_simple_sizes);
        // front hole bottom
        echo("knee side holes = ");
        echo([leg_shaft_distance_to_edge, 0, leg_shaft_distance_to_edge], "radius = 6");
        translate ([leg_shaft_distance_to_edge, 0, leg_shaft_distance_to_edge] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = M12_screw_radius, $fn = 30);
        // front hole top
        echo([leg_shaft_distance_to_edge, 0, knee_side_simple_sizes[2] - leg_shaft_distance_to_edge], "radius = 6");
        translate ([leg_shaft_distance_to_edge, 0, knee_side_simple_sizes[2] - leg_shaft_distance_to_edge] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = M12_screw_radius, $fn = 30);
        // back hole bottom
        echo([knee_side_simple_sizes[0] - leg_shaft_distance_to_edge, 0, leg_shaft_distance_to_edge], "radius = 6");
        translate ([knee_side_simple_sizes[0] - leg_shaft_distance_to_edge, 0, leg_shaft_distance_to_edge] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = M12_screw_radius, $fn = 30);
        // back hole top
        echo([knee_side_simple_sizes[0] - leg_shaft_distance_to_edge, 0, knee_side_simple_sizes[2] - leg_shaft_distance_to_edge], "radius = 6");
        translate ([knee_side_simple_sizes[0] - leg_shaft_distance_to_edge, 0, knee_side_simple_sizes[2] - leg_shaft_distance_to_edge] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = 6, $fn = 30);
        // middle hole for spacer
        echo([knee_side_simple_sizes[0] / 2, 0, knee_side_simple_sizes[2] / 2], "radius = 4");
        translate([knee_side_simple_sizes[0] / 2, 0, knee_side_simple_sizes[2] / 2] - display_tolerance_y) rotate([-90, 0, 0]) cylinder (h = knee_side_simple_sizes[1] + 2 * display_tolerance, r = m8_screw_radius);
    }
}
//-------------------------------------------------------
module leg_base_spacer()
{    
  rotate([-90, 0, 0]) alu_sigma_profile_30x30(base_spacer_length);
}
//----------------------------------------------------------------------
module base_top(base_height = 40)
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
module leg_bone()
{
    //render(){
    
  //  translate ([0, 0, -rbearing_6001_housing_size_thicker[0] / 2]) 
        difference(){
          //  translate ([-leg_bone_thick[0] / 2, -leg_bone_thick[1] / 2, 0])
            color(aluminium_color) rectangular_tube (leg_bone_thick[0], leg_bone_thick[1], 2, leg_bone_length);
            // shaft hole
            echo("middle hole", rbearing_6001_housing_holes_position[0] + [ rbearing_6001_housing_size_thicker[0] / 2, leg_bone_thick[0] / 2, 0], "radius = 12.5");
            translate ([0, leg_bone_thick[1] / 2, rbearing_6001_housing_size_thicker[0] / 2])
                rotate([90, 0, 0]) {
                    translate (rbearing_6001_housing_holes_position[0] - display_tolerance_z) cylinder (h = leg_bone_thick[1] + 2 * display_tolerance, r = 12.5, $fn = 70);
        // screws holes
                    echo("screw hole");
                    for (i = [1 : 4]){
                        translate (rbearing_6001_housing_holes_position[i] - display_tolerance_z) cylinder (h = leg_bone_thick[1] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
                    echo(rbearing_6001_housing_holes_position[i] + [ rbearing_6001_housing_size_thicker[0] / 2, leg_bone_thick[0] / 2, 0], "radius = 2");
                    }
                }
            // holes in the other side
            translate ([0, leg_bone_thick[1] / 2, leg_bone_length - rbearing_6001_housing_size_thicker[0] / 2])
                rotate([90, 0, 0]) {
                    translate (rbearing_6001_housing_holes_position[0] - display_tolerance_z) cylinder (h = leg_bone_thick[1] + 2 * display_tolerance, r = 12.5, $fn = 70);
        // screws holes
                    for (i = [1 : 4])
                        translate (rbearing_6001_housing_holes_position[i] - display_tolerance_z) cylinder (h = leg_bone_thick[1] + 2 * display_tolerance, r = 1.6, $fn = 20);
                }
                
        }
}
//----------------------------------------------------------------------
module leg_pusher_bearing_sheet()
{
    difference(){
        color(aluminium_color) cube(leg_pusher_bearing_sheet_size);
        echo(leg_pusher_bearing_sheet_size = leg_pusher_bearing_sheet_size);

        // rb6907 bearing housing holes
        echo("rb6907 bearing housing holes");
        for (i = [1 : 4]){
            translate([leg_pusher_bearing_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] + rbearing_6907_housing_holes_position[i] - display_tolerance_z) cylinder (h = leg_pusher_bearing_sheet_size[2] + 2 * display_tolerance, r = 2, $fn = 10);

            echo([leg_pusher_bearing_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] + rbearing_6907_housing_holes_position[i], "radius = 2");
        }
// middle hole
        translate([leg_pusher_bearing_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] - display_tolerance_z) cylinder (h = leg_pusher_bearing_sheet_size[2] + 2 * display_tolerance, r = 22, $fn = 30);
        echo("bearing housing middle hole", [leg_pusher_bearing_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0], "radius = 21");
         
    }
}
//---------------------------------------------------------------------------
module leg_pusher_no_bearing_sheet()
{
    difference(){
        color(aluminium_color) cube(leg_pusher_bearing_sheet_size);
        echo(leg_pusher_bearing_sheet_size = leg_pusher_bearing_sheet_size);

        // rb6907 bearing housing holes
        echo("rb6907 bearing housing holes");
        for (i = [1 : 4]){
            translate([leg_pusher_bearing_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] + rbearing_6907_housing_holes_position[i] - display_tolerance_z) cylinder (h = leg_pusher_bearing_sheet_size[2] + 2 * display_tolerance, r = 2, $fn = 10);
            translate([leg_pusher_bearing_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] + rbearing_6907_housing_holes_position[i] + [0, 0, 1]) cylinder (h = 2, r1 = 2, r2 = 3.8, $fn = 20);

            echo([leg_pusher_bearing_sheet_size[0] / 2, rbearing_6907_housing_size[0] / 2, 0] + rbearing_6907_housing_holes_position[i], "radius = 2");
        }         
    }
}
//---------------------------------------------------------------------------
module leg_bone_with_bearings()
{
    leg_bone();
    // bottom bearing
    // plastic housing
    translate([0, rb_6001_thick, rbearing_6001_housing_size_thicker[0] / 2]) rotate ([90, 0, 0]) rbearing_6001_double_housing_thicker_wall(0);
    // one bearing
    translate([0, 0, rbearing_6001_housing_size_thicker[0] / 2]) rotate ([90, 0, 0]) 6001rs();
    // the other bearing
    translate([0, rb_6001_thick, rbearing_6001_housing_size_thicker[0] / 2]) rotate ([90, 0, 0]) 6001rs();
    
    translate([0, 0, leg_bone_length - rbearing_6001_housing_size_thicker[0]]){
    // top bearing
    // plastic housing
        translate([0, rb_6001_thick, rbearing_6001_housing_size_thicker[0] / 2]) rotate ([90, 0, 0]) rbearing_6001_double_housing_thicker_wall(0);
    // one bearing
        translate([0, 0, rbearing_6001_housing_size_thicker[0] / 2]) rotate ([90, 0, 0]) 6001rs();
    // the other bearing
        translate([0, rb_6001_thick, rbearing_6001_housing_size_thicker[0] / 2]) rotate ([90, 0, 0]) 6001rs();
    }
}
//----------------------------------------------------------------------
module linear_motor_with_top_shaft(stroke, current_position)
{
    rotate([0, 0, 180]) linear_dc_motor_simple(stroke);
}
//----------------------------------------------------------------------
module front_bone_with_pusher_components(left_side = 0)
{
    leg_bone_with_bearings();
    if (left_side == 0){
        translate([0, leg_bone_thick[1] / 2, leg_distance_to_pusher]) rotate([90, 0, 0]){
            // bearing housing
            translate ([0, 0, -rb_6907_thick - 1]) rbearing_6907_housing_thicker(0);
            // bearing 
            translate ([0, 0, -rb_6907_thick]) 6907rs();
            // sheet on bearing side
            translate ([-leg_pusher_bearing_sheet_size[0] / 2, -leg_pusher_bearing_sheet_size[1] / 2, -leg_pusher_bearing_sheet_size[2] - rb_6907_thick - 1]) leg_pusher_bearing_sheet();
            // sheet on the oposite position
            translate ([-leg_pusher_bearing_sheet_size[0] / 2, -leg_pusher_bearing_sheet_size[1] / 2, leg_bone_thick[1] + leg_pusher_bearing_sheet_size[2]]) mirror([0, 0, 1]) leg_pusher_no_bearing_sheet();
        }
    }
    else{
        translate([0, -leg_bone_thick[1] / 2, leg_distance_to_pusher]) rotate([90, 0, 0]){
            translate ([0, 0, rb_6907_thick + 1]) mirror([0, 0, 1]) rbearing_6907_housing_thicker(0);
            translate ([0, 0, 0]) 6907rs();
            translate ([-leg_pusher_bearing_sheet_size[0] / 2, -leg_pusher_bearing_sheet_size[1] / 2, rb_6907_thick + 1]) leg_pusher_bearing_sheet();
            translate ([-leg_pusher_bearing_sheet_size[0] / 2, -leg_pusher_bearing_sheet_size[1] / 2, - leg_bone_thick[1]]) mirror([0, 0, 1]) leg_pusher_no_bearing_sheet();
        }
    }
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
    
    // bottom sheet
        base_top(base_height);
        
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

//complete_leg(leg_angle = leg_angle);

//leg_pusher_bearing_sheet();

//leg_bone_with_bearings();

//front_bone_with_pusher_components(1);

//translate ([0, 0, 30]) rotate ([0, 90, 0]) 
//leg_bone();

//linear_motor_with_top_shaft(100, 50);

//half_leg(leg_angle);

//base();

//base_side(40); // 4x

//knee();

//knee_side();

//leg_spacer();

//rbearing_6907_housing_thicker(0); // 4x
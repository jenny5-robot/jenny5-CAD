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

include <leg_params.scad>

use <../basic_scad/linear_motors.scad>

include <../basic_scad/params_motor_housing.scad>
include <../basic_scad/params_alu_profiles.scad>

use <../basic_scad/func_3d.scad>

use <../basic_scad/point_transformations_3d.scad>

use <../basic_scad/alu_profiles.scad>

include <../basic_scad/tolerance.scad>

//-------------------------------------------------------
module base_side(base_height = 40)
{
    color (aluminium_color) 
    render()
    difference(){
        echo("leg base size = ", lateral_base_size[0], lateral_base_size[1], base_height);
        cube([lateral_base_size[0], lateral_base_size[1], base_height]);
        
     // hole first bone
        echo("first bone hole position = ", dist_to_first_bone, base_height - 8);
        translate ([dist_to_first_bone, 0, base_height - 8] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = m8_screw_radius, $fn = 30);
        
     // hole second bone
        echo("second bone hole position = ", dist_to_second_bone, base_height - 8);
        translate ([dist_to_second_bone, 0, base_height - 8] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = m8_screw_radius, $fn = 30);
                
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
        echo([dist_to_first_bone, 0, 8], "radius = 4");
        translate ([dist_to_first_bone, 0, 8] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = 4, $fn = 30);
        // front hole top
        echo([dist_to_first_bone, 0, knee_side_simple_sizes[2] - 8], "radius = 4");
        translate ([dist_to_first_bone, 0, knee_side_simple_sizes[2] - 8] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = 4, $fn = 30);
        // back hole bottom
        echo([dist_to_second_bone, 0, 8], "radius = 4");
        translate ([dist_to_second_bone, 0, 8] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = 4, $fn = 30);
        // back hole top
        echo([dist_to_second_bone, 0, knee_side_simple_sizes[2] - 8], "radius = 4");
        translate ([dist_to_second_bone, 0, knee_side_simple_sizes[2] - 8] -display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = alu_sheet_10_thick + 2 * display_tolerance, r = 4, $fn = 30);
        // middle hole for spacer
        echo([knee_side_simple_sizes[0] / 2, 0, knee_side_simple_sizes[2] / 2], "radius = 4");
        translate([knee_side_simple_sizes[0] / 2, 0, knee_side_simple_sizes[2] / 2] - display_tolerance_y) rotate([-90, 0, 0]) cylinder (h = knee_side_simple_sizes[1] + 2 * display_tolerance, r = 4);
    }
}
//-------------------------------------------------------
module leg_spacer()
{    
  rotate([-90, 0, 0]) alu_sigma_profile_30x30(crotch_width_back);
}
//-------------------------------------------------------
module leg_spacer_base()
{
  render(){
    difference(){
        leg_spacer();
        // holes for fixing the bone to the platform   
        translate([0, crotch_width_back / 2 - dist_to_foot_spacer_hole, -15]) cylinder (h = 30, r = 4);
        translate([0, crotch_width_back / 2 + dist_to_foot_spacer_hole, -15]) cylinder (h = 30, r = 4);
    }
  }
}
//-------------------------------------------------------
module base(base_height = 40)
{
    translate ([0, - (alu_sheet_10_thick + crotch_width_back / 2 + leg_bone_thick[1] / 2), 0]) base_side(base_height);

    translate ([0, (crotch_width_back / 2 + leg_bone_thick[1] / 2), 0]) base_side(base_height);
}
//----------------------------------------------------------------------
module knee()
{
    // one side
    translate ([0, - (alu_sheet_10_thick + leg_bone_thick[1] / 2), 0]) knee_side();
// other side
    translate ([0, (crotch_width_back + leg_bone_thick[1] / 2), 0]) knee_side();
    // knee spacer
     color (aluminium_color) translate ([knee_side_simple_sizes[0] / 2, -0, knee_side_simple_sizes[2] / 2]) rotate ([0, 45, 0]) leg_spacer();
}
//----------------------------------------------------------------------
module leg_bone()
{
    //render(){
    
  //  translate ([0, 0, -rbearing_6001_housing_size_thicker[0] / 2]) 
        difference(){
            translate ([-leg_bone_thick[0] / 2, -leg_bone_thick[1] / 2, 0])
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
                        translate (rbearing_6001_housing_holes_position[i] - display_tolerance_z) cylinder (h = leg_bone_thick[1] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
                }
                
        }
}
//----------------------------------------------------------------------
module sheet_push_motor()
{
    difference(){
        translate ([-nema_17_width / 2, -nema_17_width / 2, 0]) cube([nema_17_width, nema_17_width, 3]);
        for (i = [0 : 3]){
            translate (nema_17_housing_base_holes[i] - display_tolerance_z) cylinder ( h = 3 + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
          }
    }
}
//----------------------------------------------------------------------
module linear_motor_with_top_shaft(stroke, current_position)
{
    rotate([0, 0, 180]) linear_dc_motor_simple(stroke);

    motor_base_length = 105 + stroke - 20;

    translate([0, 0, motor_base_length + 10]) 
      // perpendicular shaft
        translate ([0, -crotch_width_back / 2, current_position + 10]) rotate([-90, 0, 0]) cylinder(h = crotch_width_back, r = 4);
}
//----------------------------------------------------------------------
module half_leg(motor_position = 0, base_height = 40)
{
    motor_length = 42 + motor_position + leg_motor_max_stroke;
    
    dist_leg_base_to_leg_spacer_top = sqrt(leg_spacer * leg_spacer + distance_to_push_position * distance_to_push_position);
    echo(dist_leg_base_to_leg_spacer_top = dist_leg_base_to_leg_spacer_top);
    
    area = area_heron(motor_length, dist_to_push_motor_hole_in_base - dist_to_first_bone, dist_leg_base_to_leg_spacer_top);
    echo(area = area);
    h = 2 * area / (dist_to_push_motor_hole_in_base - dist_to_first_bone);
    
    echo(h = h);
    
    motor_angle_to_horizontal = asin( h / motor_length);
    echo(motor_angle_to_horizontal = motor_angle_to_horizontal);
    
    motor_projection_on_horizontal = motor_length * cos(motor_angle_to_horizontal);
    echo(motor_projection_on_horizontal = motor_projection_on_horizontal);
    
    gamma = atan(leg_spacer / distance_to_push_position);
    echo(gamma = gamma);
    
//    gama_plus_motor_angle_to_horizontal = asin(h / dist_leg_base_to_leg_spacer_top);
    gama_plus_motor_angle_to_horizontal = motor_projection_on_horizontal < dist_to_push_motor_hole_in_base - dist_to_first_bone ? asin(h / dist_leg_base_to_leg_spacer_top): 180 - asin(h / dist_leg_base_to_leg_spacer_top);

    
    echo(gama_plus_motor_angle_to_horizontal = gama_plus_motor_angle_to_horizontal);
    leg_angle_to_horizontal = gama_plus_motor_angle_to_horizontal - gamma;
    echo(leg_angle_to_horizontal = leg_angle_to_horizontal);
    
    // bottom sheet
    base(base_height);
    // back bone 1
    translate ([dist_to_second_bone, crotch_width_back / 2, dist_to_wrist_in_base])
    rotate ([0, 90 - leg_angle_to_horizontal, 0])
        translate ([0, 0, -rbearing_6001_housing_size_thicker[0] / 2])
    leg_bone()
    ;
    
    // back bone 2
    translate ([dist_to_second_bone, - crotch_width_back / 2, dist_to_wrist_in_base])
    rotate ([0, 90 - leg_angle_to_horizontal, 0])
        translate ([0, 0, -rbearing_6001_housing_size_thicker[0] / 2])
    leg_bone()
    ;
    
       // front bone 1
       
    translate ([dist_to_first_bone, crotch_width_front / 2, dist_to_wrist_in_base])
    rotate ([0, 90 - leg_angle_to_horizontal, 0])
    rotate ([0, 0, 180])
    translate ([0, 0, -rbearing_6001_housing_size_thicker[0] / 2])
    leg_bone()
    ;
    
       // front bone 2
    translate ([dist_to_first_bone, - crotch_width_front / 2, dist_to_wrist_in_base])
    rotate ([0, 90 - leg_angle_to_horizontal, 0])
    rotate ([0, 0, 180])
        translate ([0, 0, -rbearing_6001_housing_size_thicker[0] / 2])
    leg_bone();

    // bottom shaft front
    translate([dist_to_first_bone, -crotch_width_back / 2 - alu_sheet_10_thick - M12_nut_thick, dist_to_wrist_in_base]) rotate ([-90, 0, 0]) cylinder(crotch_width_back + 2 * alu_sheet_10_thick + 10, r = 6);
    
    // bottom shaft middle
    translate([dist_to_second_bone, -crotch_width_back / 2 - alu_sheet_10_thick - M12_nut_thick, dist_to_wrist_in_base]) rotate ([-90, 0, 0]) cylinder(crotch_width_back + 2 * alu_sheet_10_thick + 10, r = 6);

    // motor shaft
    translate([dist_to_push_motor_hole_in_base, -crotch_width_back / 2 - alu_sheet_10_thick - M12_nut_thick, dist_to_wrist_in_base]) rotate ([-90, 0, 0]) cylinder (h = crotch_width_back + 2 * alu_sheet_10_thick + 20, r = shaft_radius, $fn = 30);

    // linear motor
    
    
    translate([dist_to_push_motor_hole_in_base, 0, base_height - 8]) 
      rotate ([0, -(90 - motor_angle_to_horizontal), 0])
        linear_motor_with_top_shaft(leg_motor_max_stroke, motor_position);
        
// knee shaft - first bone    

    translate ([(leg_bone_length - (rbearing_6001_housing_size_thicker[0])) * sin(90 - leg_angle_to_horizontal) + dist_to_first_bone, 
    - crotch_width_back / 2 - alu_sheet_10_thick - M12_nut_thick, 
    (leg_bone_length - rbearing_6001_housing_size_thicker[0]) * cos(90 - leg_angle_to_horizontal) 
    + base_height - 8])
    rotate ([-90, 0, 0])
    M12_hexa(crotch_width_back + 2 * alu_sheet_10_thick + 10);
    
// knee shaft - second bone    
    translate ([(leg_bone_length - rbearing_6001_housing_size_thicker[0]) * sin(90 - leg_angle_to_horizontal) + dist_to_second_bone, 
    - crotch_width_back / 2 - alu_sheet_10_thick - M12_nut_thick, 
    (leg_bone_length - rbearing_6001_housing_size_thicker[0]) * cos(90 - leg_angle_to_horizontal) 
    + base_height - 8])
    rotate ([-90, 0, 0])
    M12_hexa(crotch_width_back + 2 * alu_sheet_10_thick + 10);
}
//----------------------------------------------------------------------
module complete_leg(motor_position = 0)
{
    motor_length = 42 + motor_position + leg_motor_max_stroke;
    dist_leg_base_to_leg_spacer_top = sqrt(leg_spacer * leg_spacer + distance_to_push_position * distance_to_push_position);
    area = area_heron(motor_length, dist_to_push_motor_hole_in_base - dist_to_first_bone, dist_leg_base_to_leg_spacer_top);
    h = 2 * area / (dist_to_push_motor_hole_in_base - dist_to_first_bone);
    motor_angle_to_horizontal = asin(h / motor_length);
    motor_projection_on_horizontal = motor_length * cos(motor_angle_to_horizontal);
    gamma = atan(leg_spacer / distance_to_push_position);
    gama_plus_motor_angle_to_horizontal = motor_projection_on_horizontal < dist_to_push_motor_hole_in_base - dist_to_first_bone ? asin(h / dist_leg_base_to_leg_spacer_top): 180 - asin(h / dist_leg_base_to_leg_spacer_top);
    leg_angle_to_horizontal = gama_plus_motor_angle_to_horizontal - gamma;
    
    // bottom half leg
    half_leg(motor_position, 40);

    // top half leg
    translate ([0, 0, 
    2 * ((leg_bone_length - rbearing_6001_housing_size_thicker[0]) * cos(90 - leg_angle_to_horizontal) + dist_to_wrist_in_base + 25)]) 
    mirror ([0, 0, 1]) half_leg(motor_position, 40);
        
    // knee
    translate ([(leg_bone_length - rbearing_6001_housing_size_thicker[0]) * sin(90 - leg_angle_to_horizontal) + dist_to_first_bone - 25 / 2, 
    - crotch_width_back / 2, 
    (leg_bone_length - rbearing_6001_housing_size_thicker[0]) * cos(90 - leg_angle_to_horizontal) 
    + dist_to_wrist_in_base - 10])
    knee()
    ;
}
//----------------------------------------------------------------------

complete_leg(leg_motor_position); // between 0 and 50

//translate ([0, 0, 30]) rotate ([0, 90, 0]) 
//leg_bone();

//linear_motor_with_top_shaft(100, 50);

//half_leg(motor_position = leg_motor_position);

//leg_bone_with_bearings();

//base();

//base_side(40); // 4x

//knee();

//knee_side();

//leg_spacer();
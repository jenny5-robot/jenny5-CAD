// Author: Mihai Oltean, (https://mihaioltean.github.io, mihai.oltean@gmail.com)
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

use <basic_components.scad>

include <params_motor_housing.scad>
include <params_screws_nuts_washers.scad>
use <screws_nuts_washers.scad>

use <potentiometer_support.scad>

include <config.scad>
include <tolerance.scad>

//--------------------------------------------------------------------
module nema_motor_housing(motor_offset_x, motor_offset_y, nema_width, motor_housing_interior_width, nema_height, base_height, nema_center_hole_radius, nema_holes_position, base_thick, motor_screw_holes_rotation_angle = 0, motor_play_x = 10)
{
   // render()
    
    {
        housing_length = nema_width + base_thick + motor_offset_x + motor_play_x;
        housing_width = motor_housing_interior_width + 2 * wall_thick_lateral_motor_housing + 2 * motor_housing_airflow_spacer + 2 * motor_offset_y;
        
        difference(){
            color(plastic_color) cube ([housing_length, housing_width, base_height]);
            // make the motor house rectangular hole
            translate ([base_thick, wall_thick_lateral_motor_housing, wall_thick_motor_housing]) cube ([nema_width + base_thick + motor_offset_x + motor_play_x + tolerance, motor_housing_interior_width + 2 * motor_housing_airflow_spacer + 2 * motor_offset_y, base_height]);
// cut at angle 
            translate ([base_thick, 0, base_height] - display_tolerance_y) rotate ([0, atan((base_height - base_thick)/ (housing_length - base_thick)), 0]) cube ([sqrt((housing_length - base_thick) * (housing_length - base_thick) + (base_height - 3) * (base_height - 3)), motor_housing_interior_width + 2 * motor_housing_airflow_spacer + 2 * display_tolerance + 2 * wall_thick_lateral_motor_housing + 2 * motor_offset_y, base_height]);
            
            translate([base_thick + motor_offset_x, wall_thick_lateral_motor_housing + motor_housing_airflow_spacer + motor_offset_y, 0] + [nema_width / 2, motor_housing_interior_width / 2, 0]- display_tolerance_z) {
                // center motor hole
                hull(){
                    translate (nema_holes_position[0]) cylinder ( h = base_thick + 2 * display_tolerance, r = nema_center_hole_radius, $fn = 50);
                    translate (nema_holes_position[0] + [motor_play_x, 0, 0]) cylinder ( h = base_thick + 2 * display_tolerance, r = nema_center_hole_radius, $fn = 50);
                }
              // screw holes for motor fixer
              for (i = [1 : 4]){
                rotate([0, 0, motor_screw_holes_rotation_angle]) 
                  hull(){
                    translate (nema_holes_position[i]) cylinder ( h = wall_thick_base_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
                    translate (nema_holes_position[i] + [motor_play_x, 0, 0]) cylinder ( h = wall_thick_base_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
                  }
               // rotate([0, 0, motor_screw_holes_rotation_angle]) translate (nema_holes_position[i]) cylinder ( h = m3_nut_thick, r2 = m3_screw_radius, r1 = m3_nut_radius, $fn = 20);
              }
           }
        }
    }
}
//--------------------------------------------------------------------
module nema_motor_housing_with_base_holes(motor_offset_x, motor_offset_y, nema_width, motor_housing_interior_width, nema_height, base_height, nema_center_hole_radius, nema_holes_position, base_thick, dist_to_base_holes_center_z, nema_housing_base_holes_H_distance, nema_housing_base_holes_V_distance, motor_screw_holes_rotation_angle = 0, sunken_base_holes = 0, motor_play_x = 10)
{
    //echo(motor_play_x = motor_play_x);
    housing_width = motor_housing_interior_width + 2 * wall_thick_lateral_motor_housing + 2 * motor_housing_airflow_spacer + 2 * motor_offset_y;
    
    difference(){
        nema_motor_housing(motor_offset_x, motor_offset_y, nema_width, motor_housing_interior_width, nema_height, base_height, nema_center_hole_radius, nema_holes_position, base_thick, motor_screw_holes_rotation_angle, motor_play_x);
        // holes base housing
 if (nema_housing_base_holes_H_distance != undef)
        translate ([0, 0, wall_thick_motor_housing] + [0, housing_width / 2, dist_to_base_holes_center_z] - display_tolerance_x)
          rotate([0, 90, 0])
            for (i = [[-1, -1], [-1, 1], [1, -1], [1, 1]]){
                echo(i);
            translate ([i[0] * nema_housing_base_holes_H_distance / 2, i[1] * nema_housing_base_holes_V_distance / 2, 0]) cylinder ( h = base_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
                if (sunken_base_holes == 1)
            translate ([i[0] * nema_housing_base_holes_H_distance / 2, i[1] * nema_housing_base_holes_V_distance / 2, 0] + [0, 0, base_thick - 0.99]) cylinder ( h = 2, r1 = m4_screw_radius, r2 = m4_nut_radius, $fn = 20);
            }
    }
}
//--------------------------------------------------------------------
module nema_motor_housing_with_belt_tensioner_bearing_based_x(motor_offset, belt_tensioner_offset, nema_width, motor_housing_interior_width, nema_height, base_height, nema_center_hole_radius, nema_holes_position, base_thick, dist_to_base_holes_center_z, nema_housing_base_holes_H_distance, nema_housing_base_holes_V_distance, motor_screw_holes_rotation_angle = 0, sunken_base_holes = 0, belt_tensioner_distance_between_holes = 30, motor_play_x = 10)
{    
    difference(){
        nema_motor_housing_with_base_holes(motor_offset + belt_tensioner_offset, 0, nema_width, motor_housing_interior_width, nema_height, base_height, nema_center_hole_radius, nema_holes_position, base_thick, dist_to_base_holes_center_z, nema_housing_base_holes_H_distance, nema_housing_base_holes_V_distance, motor_screw_holes_rotation_angle, sunken_base_holes, motor_play_x);
    
     // belt tensioner holes
      housing_width = nema_width + 2 * wall_thick_lateral_motor_housing + 2 * motor_housing_airflow_spacer;
        
      translate ([belt_tensioner_offset, housing_width / 2 - belt_tensioner_distance_between_holes / 2, 0] - display_tolerance_z) cylinder ( h = wall_thick_base_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
      translate ([belt_tensioner_offset, housing_width / 2 + belt_tensioner_distance_between_holes / 2, 0] - display_tolerance_z) cylinder ( h = wall_thick_base_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20); 
    }
}
//--------------------------------------------------------------------
module nema_motor_housing_with_belt_tensioner_bearing_based_y(motor_offset, belt_tensioner_offset, nema_width, nema_height, base_height, nema_center_hole_radius, nema_holes_position, base_thick, dist_to_first_hole_z, nema_housing_base_holes, _left, motor_screw_holes_rotation_angle = 0, sunken_base_holes = 0)
{
    housing_width = nema_width + 2 * wall_thick_lateral_motor_housing + 2 * motor_housing_airflow_spacer + 2 * motor_offset;
    
    difference(){
        nema_motor_housing_with_base_holes(2, motor_offset, nema_width, nema_height, base_height, nema_center_hole_radius, nema_holes_position, base_thick, dist_to_first_hole_z, nema_housing_base_holes, motor_screw_holes_rotation_angle, sunken_base_holes);
    
     // belt tensioner hole
//            echo(_left=_left);
    if (_left){
            hull(){
              translate ([base_thick + nema_width / 2 - 10, wall_thick_lateral_motor_housing + 7.5, 0] - display_tolerance_z) cylinder ( h = wall_thick_base_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
              translate ([base_thick + nema_width / 2 + 10, wall_thick_lateral_motor_housing + 7.5, 0] - display_tolerance_z) cylinder ( h = wall_thick_base_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
            }
        }
        
        else{// right
            hull(){
              translate ([base_thick + nema_width / 2 - 10, housing_width - wall_thick_lateral_motor_housing - 7.5, 0] - display_tolerance_z) cylinder ( h = wall_thick_base_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
              translate ([base_thick + nema_width / 2 + 10, housing_width - wall_thick_lateral_motor_housing - 7.5, 0] - display_tolerance_z) cylinder ( h = wall_thick_base_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
            }
        }
          
    }
}
//--------------------------------------------------------------------
/*
module nema_motor_housing_with_belt_tensioner_bearing_based_y_left_and_base_holes(motor_offset, belt_tensioner_offset, nema_width, nema_height, base_height, nema_center_hole_radius, nema_holes_position, base_thick, dist_to_first_hole_z, nema_housing_base_holes)
{
    housing_width = nema_width + 2 * wall_thick_lateral_motor_housing + 2 * airflow_spacer;
    
    difference(){
        nema_motor_housing_with_belt_tensioner_bearing_based_x(motor_offset, belt_tensioner_offset, nema_width, nema_height, base_height, nema_center_hole_radius, nema_holes_position, base_thick);
        // gauri perete baza
        translate ([0, 0, wall_thick_motor_housing] + [0, housing_width / 2, dist_to_first_hole_z] - display_tolerance_x)
          rotate([0, 90, 0])
            for (i = [0:3]){
            translate (nema_housing_base_holes[i]) cylinder ( h = base_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
          //  translate (nema_housing_base_holes[i] + [0, 0, base_thick - 0.99]) cylinder ( h = 2, r1 = m3_screw_radius, r2 = m4_nut_radius, $fn = 20);
            }
    }
}
*/
//--------------------------------------------------------------------
/*
module nema_motor_housing_with_base_holes(toleranta_x, toleranta_y, motor_deviation_x = 0, nema_width = nema_17_width, nema_height = nema_17_height, base_height = 43, nema_center_hole_radius = nema_17_motor_hole_radius_camiel, gauri_nema = nema_17_holes, nema_housing_base_holes = nema_17_housing_base_holes, dist_to_gauri_baza = 22, base_thick = 3)
{
    housing_width = nema_width + abs(toleranta_y) + 2 * wall_thick_lateral_motor_housing + 2 * airflow_spacer;
    difference(){
        nema_motor_housing(toleranta_x, toleranta_y, motor_deviation_x, nema_width, nema_height, base_height, nema_center_hole_radius, gauri_nema, base_thick);
    // gauri perete baza
        translate ([0, 0, wall_thick_motor_housing] + [0, housing_width / 2, dist_to_gauri_baza] - display_tolerance_x)
        rotate([0, 90, 0])
            for (i = [0:3]){
            translate (nema_housing_base_holes[i]) cylinder ( h = base_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
            translate (nema_housing_base_holes[i] + [0, 0, base_thick - 0.99]) cylinder ( h = 2, r1 = m3_screw_radius, r2 = m4_nut_radius, $fn = 20);
        }
    }
}
*/
//--------------------------------------------------------------------
module nema_motor_housing_with_base_holes_for_nuts(toleranta_x, toleranta_y, motor_deviation_x = 0, nema_width = nema_17_width, nema_height = nema_17_height, base_height = 43, nema_center_hole_radius = nema_17_motor_hole_radius_camiel, gauri_nema = nema_17_holes, nema_housing_base_holes = nema_17_housing_base_holes, dist_to_gauri_baza = 22, base_thick = 3, dist_between_nuts_y = 32, dist_to_nuts_x = 5.5, motor_screw_holes_rotation_angle = 0, sunken_base_holes = 0)
{
    difference(){
        nema_motor_housing_with_base_holes(toleranta_x, toleranta_y, motor_deviation_x, nema_width, nema_height, base_height, nema_center_hole_radius, gauri_nema, nema_housing_base_holes, dist_to_gauri_baza, base_thick, motor_screw_holes_rotation_angle, sunken_base_holes);
        
    // gauri perete baza
  
      {
      //  translate ([0, (housing_width - dist_between_nuts_y) / 2, dist_to_nuts_x] - display_tolerance_x) rotate([0, 90, 0])cylinder ( h = 7, r1 = 5, r2 = 3, $fn = 20);
      //  translate ([0, housing_width - (housing_width - dist_between_nuts_y) / 2, dist_to_nuts_x] - display_tolerance_x) rotate([0, 90, 0])cylinder ( h = 7, r1 = 5, r2 = 3, $fn = 20);
      }
    }
}
//--------------------------------------------------------------------
module nema_motor_housing_with_potentiometer_support(toleranta_x, toleranta_y, motor_deviation_x = 0, nema_width = nema_17_width, nema_height = nema_17_height, base_height = 43, nema_center_hole_radius = nema_17_motor_hole_radius_camiel, gauri_nema = nema_17_holes, nema_housing_base_holes = nema_17_housing_base_holes, dist_to_gauri_baza = 22, base_thick = 3, left = false, motor_screw_holes_rotation_angle = 0, sunken_base_holes = 0)
{   
    nema_motor_housing_with_base_holes(toleranta_x, toleranta_y, motor_deviation_x, nema_width, nema_height, base_height, nema_center_hole_radius, gauri_nema, nema_housing_base_holes, dist_to_gauri_baza, base_thick, motor_screw_holes_rotation_angle, sunken_base_holes );
// potentiometer support
    if (left)
        translate ([0, 2, 10]) rotate ([0, 0, -90]) potentiometer_support(30, 30, 6, 0); 
        else
   translate ([30, housing_width - 2, 10]) rotate ([0, 0, 90]) potentiometer_support(30, 30, 6, 0); 
}
//--------------------------------------------------------------------
module nema_14_motor_housing(toleranta_x, toleranta_y, motor_deviation_x, base_thick = 3)
{
    nema_motor_housing_with_base_holes_for_nuts(toleranta_x, toleranta_y, motor_deviation_x, nema_14_width, nema_14_height, 35, nema_14_motor_hole_radius, nema_17_holes, nema_11_housing_base_holes, 16, base_thick);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module nema_17_motor_housing(toleranta_x, toleranta_y, motor_deviation_x, base_thick = 3)
{
    nema_motor_housing_with_base_holes_for_nuts(toleranta_x, toleranta_y, motor_deviation_x, nema_17_width, nema_17_height, 43, nema_17_motor_hole_radius_camiel, nema_17_holes, nema_17_housing_base_holes, 22, base_thick);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module nema_23_motor_housing(toleranta_x, toleranta_y, motor_deviation_x, base_thick = 3)
{
    nema_motor_housing_with_base_holes_for_nuts(toleranta_x, toleranta_y, motor_deviation_x, nema_23_57BYGH603_width, nema_23_57BYGH603_height, 70, nema_23_57BYGH603_hole_radius, nema_17_holes, nema_17_housing_base_holes, 22, base_thick);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module nema_17_geared_motor_housing(toleranta_x, toleranta_y, motor_deviation_x, base_thick = 3)
{
    nema_motor_housing_with_base_holes_for_nuts(toleranta_x, toleranta_y, motor_deviation_x, nema_17_width, nema_17_height, 43, nema_17_gearbox_motor_hole_radius, gearbox_nema_17_holes_position, nema_17_housing_base_holes, 22, base_thick);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module nema_11_geared_motor_housing(toleranta_x, toleranta_y, motor_deviation_x, base_thick = 3)
{
    nema_motor_housing_with_base_holes_for_nuts(toleranta_x, toleranta_y, motor_deviation_x, nema_11_width, nema_11_height, 38, nema_11_motor_gearbox_radius, gearbox_nema_11_holes_position, nema_11_housing_base_holes, 20, base_thick);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module nema_17_motor_housing_with_potentiometer_support(toleranta_x, toleranta_y, motor_deviation_x, base_thick = 3, left = false)
{
    nema_motor_housing_with_potentiometer_support(toleranta_x, toleranta_y, motor_deviation_x, nema_17_width, nema_17_height, 43, nema_17_motor_hole_radius_camiel, nema_17_holes, nema_17_housing_base_holes, 22, base_thick, left);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module nema_11_motor_housing(toleranta_x = 0, toleranta_y = 0)
{
    nema_motor_housing_with_base_holes(toleranta_x, toleranta_y, 0, nema_11_width, nema_11_height, 38, nema_11_motor_hole_radius, nema_11_holes, nema_11_housing_base_holes, 20);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module nema_11_motor_housing_with_holled_base(toleranta_x = 0, toleranta_y = 0)
{
    nema_motor_housing_with_holled_base(toleranta_x, toleranta_y, 0, nema_11_width, nema_11_height, 20, nema_11_motor_hole_radius, nema_11_holes, 11, 10);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module stepper_motor_support_on_rectangular_axis(length, width, support_height, box_height, dist_to_pot = 0)
{
    hole_depth = 11.5;
    hole_width = 10.5;
    union(){
      translate ([0, 0, dist_to_pot]){ 
          difference(){
          potentiometer_support(length, width, support_height, 28, 0, 3);
         // gauri motor nema11
        translate ([28, width / 2, 0] + gearbox_nema_11_holes_position[0] - display_tolerance_z) cylinder (h = 3 + 2 * display_tolerance, r = nema_11_motor_gearbox_hole_radius, $fn = 50);
        for (i=[1:4])
         translate ([28, width / 2, 0] - display_tolerance_z) rotate ([0, 0, 45]) translate (gearbox_nema_11_holes_position[i]) cylinder (h = 3 + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
        
        
        // belt tensioner screw
        translate ([9, 9, 0] - display_tolerance_z) cylinder (h = 3 + 2 * display_tolerance, r = m4_screw_radius, $fn = 50);
    }

    } 
        translate ([-(hole_depth + 6), 0, 0]) 
            difference(){
              cube([hole_depth + 8, width, box_height]);
              translate([6, 0, 2] - display_tolerance_y) cube([hole_depth, width + 2 * display_tolerance, hole_width]); 
             translate([6, 5, 2]) cube([hole_depth, width -10, 20]); 
                
             // gaura surub   
              translate([0, width / 2, 9] - display_tolerance_x) rotate ([0, 90, 0]) cylinder (h = 10, r = m4_screw_radius, $fn = 20);
                translate([6 - m4_nut_thick, width / 2, 9] - display_tolerance_x) rotate ([0, 90, 0]) cylinder (h = 5, r = m4_nut_radius, $fn = 6);
            }
        }
}
//---------------------------------------------------------------------------
module stepper_motor_fixer(motor_height, motor_width, distance_between_motor_holes, width, wing_length = 2 * washer_4_12_radius)
{
    thick = 3;
    
    difference(){
        color(plastic_color)
        union(){
            cube([wing_length, 3, width]);
        
            translate([wing_length, 0, 0]) cube([thick, motor_height, width]);
            translate([wing_length, motor_height, 0]) cube([2 * thick + motor_width, thick, width]);
            translate([wing_length + thick + motor_width, 0, 0]) cube([thick, motor_height, width]);
            translate([wing_length + 2 * thick + motor_width, 0, 0]) cube([wing_length, 3, width]);   
        }
        // fixer holes
        translate ([washer_4_12_radius, 0, width / 2] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        translate ([2 * wing_length  - washer_4_12_radius + 2 * thick + motor_width, 0, width / 2] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
// motor holes
        translate ([wing_length + thick + motor_width / 2 - distance_between_motor_holes / 2, motor_height, width / 2] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = thick + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
        translate ([wing_length + thick + motor_width / 2 + distance_between_motor_holes / 2, motor_height, width / 2] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder(h = thick + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);

    }
}
//---------------------------------------------------------------------------
module nema_17_fixer()
{
  stepper_motor_fixer(nema_17_height, nema_17_width, nema_17_dist_between_screw_holes, 9, 25);
}
//---------------------------------------------------------------------------
//nema_motor_housing_with_belt_tensioner_bearing_based_x(15, 10, nema_17_width, nema_17_height, base_height = 40, nema_center_hole_radius = nema_17_gearbox_motor_hole_radius, gauri_nema = gearbox_nema_17_holes_position, base_thick = 3);

module nema_17_housing_with_belt_tensioner_bearing_based_x_and_base_holes(motor_offset, belt_tensioner_offset)
{
  nema_motor_housing_with_belt_tensioner_bearing_based_x(motor_offset, belt_tensioner_offset, nema_17_width, nema_17_height, base_height = 40, nema_center_hole_radius = nema_17_gearbox_motor_hole_radius, nema_holes_position = gearbox_nema_17_holes_position, base_thick = 3, dist_to_first_hole_z = 12, nema_housing_base_holes = nema_17_housing_large_base_holes);
}
//---------------------------------------------------------------------------
module nema_11_housing_with_belt_tensioner_bearing_based_x_and_base_holes(motor_offset, belt_tensioner_offset)
{
  nema_motor_housing_with_belt_tensioner_bearing_based_x(motor_offset, belt_tensioner_offset, nema_11_width, nema_11_height, base_height = 40, nema_center_hole_radius = nema_11_motor_gearbox_hole_radius, nema_holes_position = gearbox_nema_11_holes_position, base_thick = 3, dist_to_first_hole_z = 14, nema_housing_base_holes = nema_11_housing_base_holes, motor_screw_holes_rotation_angle = 0);
}
//---------------------------------------------------------------------------
module nema_17_housing_with_belt_tensioner_bearing_based_y_and_base_holes(motor_offset, belt_tensioner_offset, left = 1)
{
  nema_motor_housing_with_belt_tensioner_bearing_based_y(motor_offset, belt_tensioner_offset, nema_17_width, nema_17_height, base_height = 40, nema_center_hole_radius = nema_17_gearbox_motor_hole_radius, nema_holes_position = gearbox_nema_17_holes_position, base_thick = 3, dist_to_first_hole_z = 18, nema_housing_base_holes = nema_17_housing_large_base_holes, _left = left);
}
//---------------------------------------------------------------------------
module nema_23_motor_housing()
{
nema_motor_housing_x(10, nema_23_57BYGH603_width, nema_23_57BYGH603_height, 70, nema_23_57BYGH603_hole_radius, gearbox_nema_17_holes_position, 3);
}
//---------------------------------------------------------------------------
//nema_17_housing_with_belt_tensioner_bearing_based_x_and_base_holes(20, 5);

//nema_17_housing_with_belt_tensioner_bearing_based_y_and_base_holes(15, 0, 0);

//nema_17_housing_with_belt_tensioner_bearing_based_x_and_base_holes(15, 0);

//nema_23_motor_housing(10, 0, 0, 5);

//nema_17_fixer();

//nema_17_motor_housing_with_potentiometer_support(10, 0, 7, 3, false);

//nema_14_motor_housing(10, 0, 0); // motor #5

//nema_17_motor_housing(10, 0, 18); // motor #1

//nema_17_motor_housing(10, 0, 50, 5); //motor #2

//nema_17_motor_housing(0, 0, airflow_spacer); // motor #3

//nema_17_motor_housing(0, 15, airflow_spacer + 8); // platform motor 2x

//nema_17_geared_motor_housing(0, 0, 0); // platform motor 2x

//nema_11_geared_motor_housing(0, 0, 0); // platform motor #4

//nema_11_motor_housing_with_holled_base(4, 0);

//nema_motor_housing(0, 10, 0);

//nema_11_housing_with_belt_tensioner_bearing_based_x_and_base_holes(15, 0);

//nema_17_geared_motor_housing(toleranta_x = 0, toleranta_y = 0, motor_deviation_x = 0); // platform motor 2x

//stepper_motor_support_on_rectangular_axis(42, 36, 16, 16, 0);
//translate ([28, 18, 60]) mirror([0, 0, 1]) nema_11_with_gearbox();
//translate ([9, 9, 3]) washer_4_12();

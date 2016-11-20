// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
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


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module nema_motor_housing(toleranta_x, toleranta_y, motor_deviation_x = 0, nema_width = nema_17_width, nema_height = nema_17_height, base_height = 43, nema_center_hole_radius = nema_17_motor_hole_radius_camiel, gauri_nema = gauri_nema_17, base_thick = 3, belt_tensioner_position = 1, motor_deviation_y = 15)
{
    lungime = nema_width + base_thick + motor_deviation_x + toleranta_x;
    latime = nema_width + abs(toleranta_y) + 2 * perete_lateral_motor_housing + 2 * airflow_spacer + motor_deviation_y;
    echo(base_height=base_height);
    echo(nema_center_hole_radius=nema_center_hole_radius);
    
    //echo(nema_width=nema_width);
	difference(){
			color(plastic_color) cube ([lungime, latime, base_height]);
		//	echo(nema_height=nema_height);
		// make the motor house hole
		translate ([base_thick, perete_lateral_motor_housing, perete_motor_motor_housing]) cube ([nema_width + base_thick + motor_deviation_x + 2 * toleranta_x, nema_width + abs(toleranta_y) + 2 * airflow_spacer + motor_deviation_y, nema_height + perete_baza_motor_housing]);

        translate ([base_thick, 0, base_height] - display_tolerance_y) rotate ([0, atan((base_height) / lungime), 0]) cube ([lungime * sqrt(2), nema_width + abs(toleranta_y) + 2 * airflow_spacer + 2 * display_tolerance + motor_deviation_y + 2 * perete_lateral_motor_housing, base_height]);
        
// motor support - m3 screws
        
		translate([base_thick + motor_deviation_x, perete_lateral_motor_housing + airflow_spacer + motor_deviation_y, 0] + [nema_width / 2, nema_width / 2, 0]- display_tolerance_z) {
            // gauri motor
        hull(){
            translate (gauri_nema[0]) cylinder ( h = base_thick + 2 * display_tolerance, r = nema_center_hole_radius, $fn = 50);
           // translate (gauri_nema[0] + [toleranta_x, toleranta_y, 0]) cylinder ( h = base_thick + 2 * display_tolerance, r = nema_center_hole_radius, $fn = 50);
        }
        // gauri m3 prindere motor
        for (i = [1:4])
            hull(){
               // rotate ([0, 0, 45])
                translate (gauri_nema[i]) cylinder ( h = perete_baza_motor_housing + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
            //rotate ([0, 0, 45]) 
                translate (gauri_nema[i] + [toleranta_x, toleranta_y, 0]) cylinder ( h = perete_baza_motor_housing + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
            }
        }
            // belt tensioner hole
            
            if (belt_tensioner_position == 0){ // base
            hull(){
            translate ([- 7.5 - nema_width / 2, -10, 0] + [toleranta_x, toleranta_y, 0]) cylinder ( h = perete_baza_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
            translate ([- 7.5 - nema_width / 2, 10, 0] + [toleranta_x, toleranta_y, 0]) cylinder ( h = perete_baza_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
            }
        }
        else
            if (belt_tensioner_position == 1){ // left
            
            echo(perete_baza_motor_housing=perete_baza_motor_housing);
            hull(){
              translate ([base_thick + motor_deviation_x + nema_width / 2 - 10, perete_lateral_motor_housing + 7.5, 0] + [toleranta_x, toleranta_y, 0] - display_tolerance_z) cylinder ( h = perete_baza_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
              translate ([base_thick + motor_deviation_x + nema_width / 2 + 10, perete_lateral_motor_housing + 7.5, 0] + [toleranta_x, toleranta_y, 0] - display_tolerance_z) cylinder ( h = perete_baza_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
            }
            
        }
        else
            if (belt_tensioner_position == 2){ // right
            hull(){
              translate ([- 7.5 - nema_width / 2, -10, 0] + [toleranta_x, toleranta_y, 0]) cylinder ( h = perete_baza_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
              translate ([- 7.5 - nema_width / 2, 10, 0] + [toleranta_x, toleranta_y, 0]) cylinder ( h = perete_baza_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
            }
        }
          
    
	}
}
//--------------------------------------------------------------------
module nema_motor_housing(motor_offset_x, motor_offset_y, nema_width, nema_height, base_height, nema_center_hole_radius, nema_holes_position, base_thick, motor_screw_holes_rotation_angle = 0)
{
    lungime = nema_width + base_thick + motor_offset_x;
    latime = nema_width + 2 * perete_lateral_motor_housing + 2 * airflow_spacer + 2 * motor_offset_y;
    
	difference(){
		color(plastic_color) cube ([lungime, latime, base_height]);
		// make the motor house hole
		translate ([base_thick, perete_lateral_motor_housing, perete_motor_motor_housing]) cube ([nema_width + base_thick + motor_offset_x, nema_width + 2 * airflow_spacer + 2 * motor_offset_y, base_height]);

        translate ([base_thick, 0, base_height] - display_tolerance_y) rotate ([0, atan((base_height) / lungime), 0]) cube ([lungime * sqrt(2), nema_width + 2 * airflow_spacer + 2 * display_tolerance + 2 * perete_lateral_motor_housing + 2 * motor_offset_y, base_height]);
        
		translate([base_thick + motor_offset_x, perete_lateral_motor_housing + airflow_spacer + motor_offset_y, 0] + [nema_width / 2, nema_width / 2, 0]- display_tolerance_z) {
            // center motor hole
          translate (nema_holes_position[0]) cylinder ( h = base_thick + 2 * display_tolerance, r = nema_center_hole_radius, $fn = 50);
          // m3 screw holes
          for (i = [1:4]){
            rotate([0, 0, motor_screw_holes_rotation_angle]) translate (nema_holes_position[i]) cylinder ( h = perete_baza_motor_housing + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
            rotate([0, 0, motor_screw_holes_rotation_angle]) translate (nema_holes_position[i]) cylinder ( h = m3_nut_thick, r2 = m3_screw_radius, r1 = m3_nut_radius, $fn = 20);
          }
       }
	}
}
//--------------------------------------------------------------------
module nema_motor_housing_with_base_holes(motor_offset_x, motor_offset_y, nema_width, nema_height, base_height, nema_center_hole_radius, nema_holes_position, base_thick, dist_to_first_hole_z, nema_housing_base_holes, motor_screw_holes_rotation_angle = 0, sunken_base_holes = 0)
{
    latime = nema_width + 2 * perete_lateral_motor_housing + 2 * airflow_spacer + 2 * motor_offset_y;
    
    difference(){
        nema_motor_housing(motor_offset_x, motor_offset_y, nema_width, nema_height, base_height, nema_center_hole_radius, nema_holes_position, base_thick, motor_screw_holes_rotation_angle);
        // gauri perete baza
 
        translate ([0, 0, perete_motor_motor_housing] + [0, latime / 2, dist_to_first_hole_z] - display_tolerance_x)
          rotate([0, 90, 0])
            for (i = [0:3]){
            translate (nema_housing_base_holes[i]) cylinder ( h = base_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
                if (sunken_base_holes == 1)
            translate (nema_housing_base_holes[i] + [0, 0, base_thick - 0.99]) cylinder ( h = 2, r1 = m4_screw_radius, r2 = m4_nut_radius, $fn = 20);
            }
    }
}
//--------------------------------------------------------------------
module nema_motor_housing_with_belt_tensioner_bearing_based_x(motor_offset, belt_tensioner_offset, nema_width, nema_height, base_height, nema_center_hole_radius, nema_holes_position, base_thick, dist_to_first_hole_z, nema_housing_base_holes, motor_screw_holes_rotation_angle = 0, sunken_base_holes = 0)
{
    latime = nema_width + 2 * perete_lateral_motor_housing + 2 * airflow_spacer;
    
    
    difference(){
        nema_motor_housing_with_base_holes(motor_offset + belt_tensioner_offset, 0, nema_width, nema_height, base_height, nema_center_hole_radius, nema_holes_position, base_thick, dist_to_first_hole_z, nema_housing_base_holes, motor_screw_holes_rotation_angle, sunken_base_holes);
    
     // belt tensioner hole
            
        hull(){
            translate ([washer_5_15_external_radius + base_thick + belt_tensioner_offset, perete_lateral_motor_housing + washer_5_15_external_radius, 0] - display_tolerance_z) cylinder ( h = perete_baza_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
            translate ([washer_5_15_external_radius + base_thick + belt_tensioner_offset, latime - washer_5_15_external_radius - perete_lateral_motor_housing, 0] - display_tolerance_z) cylinder ( h = perete_baza_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        }
    }
}
//--------------------------------------------------------------------
module nema_motor_housing_with_belt_tensioner_bearing_based_y(motor_offset, belt_tensioner_offset, nema_width, nema_height, base_height, nema_center_hole_radius, nema_holes_position, base_thick, dist_to_first_hole_z, nema_housing_base_holes, _left, motor_screw_holes_rotation_angle = 0, sunken_base_holes = 0)
{
    latime = nema_width + 2 * perete_lateral_motor_housing + 2 * airflow_spacer + 2 * motor_offset;
    
    difference(){
        nema_motor_housing_with_base_holes(2, motor_offset, nema_width, nema_height, base_height, nema_center_hole_radius, nema_holes_position, base_thick, dist_to_first_hole_z, nema_housing_base_holes, motor_screw_holes_rotation_angle, sunken_base_holes);
    
     // belt tensioner hole
//            echo(_left=_left);
    if (_left){
            hull(){
              translate ([base_thick + nema_width / 2 - 10, perete_lateral_motor_housing + 7.5, 0] - display_tolerance_z) cylinder ( h = perete_baza_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
              translate ([base_thick + nema_width / 2 + 10, perete_lateral_motor_housing + 7.5, 0] - display_tolerance_z) cylinder ( h = perete_baza_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
            }
        }
        
        else{// right
            hull(){
              translate ([base_thick + nema_width / 2 - 10, latime - perete_lateral_motor_housing - 7.5, 0] - display_tolerance_z) cylinder ( h = perete_baza_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
              translate ([base_thick + nema_width / 2 + 10, latime - perete_lateral_motor_housing - 7.5, 0] - display_tolerance_z) cylinder ( h = perete_baza_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
            }
        }
          
    }
}
//--------------------------------------------------------------------
/*
module nema_motor_housing_with_belt_tensioner_bearing_based_y_left_and_base_holes(motor_offset, belt_tensioner_offset, nema_width, nema_height, base_height, nema_center_hole_radius, nema_holes_position, base_thick, dist_to_first_hole_z, nema_housing_base_holes)
{
    latime = nema_width + 2 * perete_lateral_motor_housing + 2 * airflow_spacer;
    
    difference(){
        nema_motor_housing_with_belt_tensioner_bearing_based_x(motor_offset, belt_tensioner_offset, nema_width, nema_height, base_height, nema_center_hole_radius, nema_holes_position, base_thick);
        // gauri perete baza
        translate ([0, 0, perete_motor_motor_housing] + [0, latime / 2, dist_to_first_hole_z] - display_tolerance_x)
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
module nema_motor_housing_with_base_holes(toleranta_x, toleranta_y, motor_deviation_x = 0, nema_width = nema_17_width, nema_height = nema_17_height, base_height = 43, nema_center_hole_radius = nema_17_motor_hole_radius_camiel, gauri_nema = gauri_nema_17, nema_housing_base_holes = nema_17_housing_base_holes, dist_to_gauri_baza = 22, base_thick = 3)
{
    latime = nema_width + abs(toleranta_y) + 2 * perete_lateral_motor_housing + 2 * airflow_spacer;
    difference(){
        nema_motor_housing(toleranta_x, toleranta_y, motor_deviation_x, nema_width, nema_height, base_height, nema_center_hole_radius, gauri_nema, base_thick);
    // gauri perete baza
        translate ([0, 0, perete_motor_motor_housing] + [0, latime / 2, dist_to_gauri_baza] - display_tolerance_x)
        rotate([0, 90, 0])
            for (i = [0:3]){
            translate (nema_housing_base_holes[i]) cylinder ( h = base_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
            translate (nema_housing_base_holes[i] + [0, 0, base_thick - 0.99]) cylinder ( h = 2, r1 = m3_screw_radius, r2 = m4_nut_radius, $fn = 20);
        }
    }
}
*/
//--------------------------------------------------------------------
module nema_motor_housing_with_base_holes_for_nuts(toleranta_x, toleranta_y, motor_deviation_x = 0, nema_width = nema_17_width, nema_height = nema_17_height, base_height = 43, nema_center_hole_radius = nema_17_motor_hole_radius_camiel, gauri_nema = gauri_nema_17, nema_housing_base_holes = nema_17_housing_base_holes, dist_to_gauri_baza = 22, base_thick = 3, dist_between_nuts_y = 32, dist_to_nuts_x = 5.5, motor_screw_holes_rotation_angle = 0, sunken_base_holes = 0)
{
    latime = nema_width + abs(toleranta_y) + 2 * perete_lateral_motor_housing + 2 * airflow_spacer;
    difference(){
        nema_motor_housing_with_base_holes(toleranta_x, toleranta_y, motor_deviation_x, nema_width, nema_height, base_height, nema_center_hole_radius, gauri_nema, nema_housing_base_holes, dist_to_gauri_baza, base_thick, motor_screw_holes_rotation_angle, sunken_base_holes);
        
    // gauri perete baza
  
      {
      //  translate ([0, (latime - dist_between_nuts_y) / 2, dist_to_nuts_x] - display_tolerance_x) rotate([0, 90, 0])cylinder ( h = 7, r1 = 5, r2 = 3, $fn = 20);
      //  translate ([0, latime - (latime - dist_between_nuts_y) / 2, dist_to_nuts_x] - display_tolerance_x) rotate([0, 90, 0])cylinder ( h = 7, r1 = 5, r2 = 3, $fn = 20);
      }
    }
}
//--------------------------------------------------------------------
module nema_motor_housing_with_potentiometer_support(toleranta_x, toleranta_y, motor_deviation_x = 0, nema_width = nema_17_width, nema_height = nema_17_height, base_height = 43, nema_center_hole_radius = nema_17_motor_hole_radius_camiel, gauri_nema = gauri_nema_17, nema_housing_base_holes = nema_17_housing_base_holes, dist_to_gauri_baza = 22, base_thick = 3, left = false, motor_screw_holes_rotation_angle = 0, sunken_base_holes = 0)
{
    latime = nema_width + abs(toleranta_y) + 2 * perete_lateral_motor_housing;
    
    nema_motor_housing_with_base_holes(toleranta_x, toleranta_y, motor_deviation_x, nema_width, nema_height, base_height, nema_center_hole_radius, gauri_nema, nema_housing_base_holes, dist_to_gauri_baza, base_thick, motor_screw_holes_rotation_angle, sunken_base_holes );
// potentiometer support
    if (left)
        translate ([0, 2, 10]) rotate ([0, 0, -90]) potentiometer_support(30, 30, 6, 0); 
        else
   translate ([30, latime - 2, 10]) rotate ([0, 0, 90]) potentiometer_support(30, 30, 6, 0); 
}
//--------------------------------------------------------------------
module nema_14_motor_housing(toleranta_x, toleranta_y, motor_deviation_x, base_thick = 3)
{
    nema_motor_housing_with_base_holes_for_nuts(toleranta_x, toleranta_y, motor_deviation_x, nema_14_width, nema_14_height, 35, nema_14_motor_hole_radius, gauri_nema_17, nema_11_housing_base_holes, 16, base_thick);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module nema_17_motor_housing(toleranta_x, toleranta_y, motor_deviation_x, base_thick = 3)
{
    nema_motor_housing_with_base_holes_for_nuts(toleranta_x, toleranta_y, motor_deviation_x, nema_17_width, nema_17_height, 43, nema_17_motor_hole_radius_camiel, gauri_nema_17, nema_17_housing_base_holes, 22, base_thick);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module nema_23_motor_housing(toleranta_x, toleranta_y, motor_deviation_x, base_thick = 3)
{
    nema_motor_housing_with_base_holes_for_nuts(toleranta_x, toleranta_y, motor_deviation_x, nema_23_57BYGH603_width, nema_23_57BYGH603_height, 70, nema_23_57BYGH603_hole_radius, gauri_nema_17, nema_17_housing_base_holes, 22, base_thick);
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
    nema_motor_housing_with_potentiometer_support(toleranta_x, toleranta_y, motor_deviation_x, nema_17_width, nema_17_height, 43, nema_17_motor_hole_radius_camiel, gauri_nema_17, nema_17_housing_base_holes, 22, base_thick, left);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module nema_11_motor_housing(toleranta_x = 0, toleranta_y = 0)
{
    nema_motor_housing_with_base_holes(toleranta_x, toleranta_y, 0, nema_11_width, nema_11_height, 38, nema_11_motor_hole_radius, gauri_nema_11, nema_11_housing_base_holes, 20);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module nema_11_motor_housing_with_holled_base(toleranta_x = 0, toleranta_y = 0)
{
    nema_motor_housing_with_holled_base(toleranta_x, toleranta_y, 0, nema_11_width, nema_11_height, 20, nema_11_motor_hole_radius, gauri_nema_11, 11, 10);
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
  nema_motor_housing_with_belt_tensioner_bearing_based_x(motor_offset, belt_tensioner_offset, nema_17_width, nema_17_height, base_height = 40, nema_center_hole_radius = nema_17_gearbox_motor_hole_radius, nema_holes_position = gearbox_nema_17_holes_position, base_thick = 3, dist_to_first_hole_z = 12, nema_housing_base_holes = nema_17_housing_base_holes_position);
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

nema_11_housing_with_belt_tensioner_bearing_based_x_and_base_holes(15, 0);

//nema_17_geared_motor_housing(toleranta_x = 0, toleranta_y = 0, motor_deviation_x = 0); // platform motor 2x

//stepper_motor_support_on_rectangular_axis(42, 36, 16, 16, 0);
//translate ([28, 18, 60]) mirror([0, 0, 1]) nema_11_with_gearbox();
//translate ([9, 9, 3]) washer_4_12();
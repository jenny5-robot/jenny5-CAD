// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------


use <basic_components.scad>


include <params_dc_motor_housing.scad>
include <params_screws_nuts_washers.scad>
include <params_dc_motors.scad>
use <screws_nuts_washers.scad>

include <config.scad>

airflow_spacer = 0;
//--------------------------------------------------------------------
module dc_motor_housing(motor_offset_x, motor_offset_y, motor_radius, motor_length, base_height, nema_center_hole_radius, nema_holes_position, base_thick)
{
    lungime = 2 * motor_radius + base_thick + motor_offset_x;
    latime = 2 * motor_radius + 2 * perete_lateral_motor_housing + 2 * airflow_spacer + 2 * motor_offset_y;
    
	difference(){
		color(plastic_color) cube ([lungime, latime, base_height]);
		// make the motor house hole
		translate ([base_thick, perete_lateral_motor_housing, perete_motor_motor_housing]) cube ([2 * motor_radius + base_thick + motor_offset_x, 2 * motor_radius + 2 * airflow_spacer + 2 * motor_offset_y, base_height + perete_baza_motor_housing]);

        translate ([base_thick, 0, base_height] - display_tolerance_y) rotate ([0, atan((base_height - 2) / lungime), 0]) cube ([lungime * sqrt(2), 2 * motor_radius + 2 * airflow_spacer+ 2 * perete_lateral_motor_housing + 2 * motor_offset_y, base_height] + 2 * display_tolerance_y );
        
// motor support - m4 screws
        
		translate([base_thick + motor_offset_x, perete_lateral_motor_housing + airflow_spacer + motor_offset_y, 0] + [motor_radius + 1, motor_radius, 0]- display_tolerance_z) {
            // center motor hole
          translate (nema_holes_position[0]) cylinder ( h = perete_motor_motor_housing + 2 * display_tolerance, r = nema_center_hole_radius, $fn = 50);
          // gauri m3 prindere motor
          for (i = [1:4]){
            translate (nema_holes_position[i]) cylinder ( h = perete_motor_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
         //   translate (nema_holes_position[i]) cylinder ( h = m3_nut_thick, r2 = m3_screw_radius, r1 = m3_nut_radius, $fn = 20);
          }
       }
	}
}
//--------------------------------------------------------------------
module dc_motor_housing_with_base_holes(motor_offset_x, motor_offset_y, motor_radius, motor_length, base_height, nema_center_hole_radius, nema_holes_position, base_thick, dist_to_first_hole_z, nema_housing_base_holes)
{
    latime = 2 * motor_radius + 2 * perete_lateral_motor_housing + 2 * airflow_spacer + 2 * motor_offset_y;
    
    difference(){
        dc_motor_housing(motor_offset_x, motor_offset_y, motor_radius, motor_length, base_height, nema_center_hole_radius, nema_holes_position, base_thick);
        // gauri perete baza
        translate ([0, 0, perete_motor_motor_housing] + [0, latime / 2, dist_to_first_hole_z] - display_tolerance_x)
          rotate([0, 90, 0])
            for (i = [0 : 3]){
            translate (nema_housing_base_holes[i]) cylinder ( h = base_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
            }
    }
}
//--------------------------------------------------------------------
module dc_motor_housing_with_belt_tensioner_bearing_based_y(motor_offset, belt_tensioner_offset, motor_radius, motor_length, base_height, nema_center_hole_radius, nema_holes_position, base_thick, dist_to_first_hole_z, nema_housing_base_holes, _left)
{
    latime = 2 * motor_radius + 2 * perete_lateral_motor_housing + 2 * airflow_spacer + 2 * motor_offset;
    
    difference(){
        dc_motor_housing_with_base_holes(2, motor_offset, motor_radius, motor_length, base_height, nema_center_hole_radius, nema_holes_position, base_thick, dist_to_first_hole_z, nema_housing_base_holes);
    
     // belt tensioner hole
//            echo(_left=_left);
    if (_left){
            hull(){
              translate ([base_thick + motor_radius - 10, perete_lateral_motor_housing + 7.5, 0] - display_tolerance_z) cylinder ( h = perete_motor_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
              translate ([base_thick + motor_radius + 10, perete_lateral_motor_housing + 7.5, 0] - display_tolerance_z) cylinder ( h = perete_motor_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
            }
        }
        
        else{// right
            hull(){
              translate ([base_thick + motor_radius - 10, latime - perete_lateral_motor_housing - 7.5, 0] - display_tolerance_z) cylinder ( h = perete_motor_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
              translate ([base_thick + motor_radius + 10, latime - perete_lateral_motor_housing - 7.5, 0] - display_tolerance_z) cylinder ( h = perete_motor_motor_housing + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
            }
        }
          
    }
}
//--------------------------------------------------------------------

module motor_gr_ep_45_housing_with_belt_tensioner_bearing_based_y_and_base_holes(motor_offset, belt_tensioner_offset, left = 1)
{
  dc_motor_housing_with_belt_tensioner_bearing_based_y(motor_offset, belt_tensioner_offset, motor_gr_ep_45_radius, 50, base_height = 40, nema_center_hole_radius = motor_gr_ep_45_shaft_cilinder_radius, nema_holes_position = motor_gr_ep_45_holes, base_thick = 3, dist_to_first_hole_z = 18, nema_housing_base_holes = motor_gr_ep_45_housing_large_base_holes, _left = left);
}
//---------------------------------------------------------------------------

motor_gr_ep_45_housing_with_belt_tensioner_bearing_based_y_and_base_holes(15, 0, 0);


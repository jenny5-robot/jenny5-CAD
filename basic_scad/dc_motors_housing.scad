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


//--------------------------------------------------------------------
module dc_motor_housing(motor_offset_x, motor_offset_y, motor_radius, motor_length, base_height, motor_center_hole_radius, motor_holes_position, base_thick)
{
    housing_length = 2 * motor_radius + base_thick + motor_offset_x + airflow_spacer_x;
    housing_width = 2 * motor_radius + 2 * side_wall_dc_motor_housing_thick + 2 * airflow_spacer_y + 2 * motor_offset_y;
    
	difference(){
		color(plastic_color) cube ([housing_length, housing_width, base_height]);
		// make the motor house hole
		translate ([base_thick, side_wall_dc_motor_housing_thick, motor_wall_dc_motor_housing_thick]) cube ([2 * motor_radius + base_thick + motor_offset_x, 2 * motor_radius + 2 * airflow_spacer_y + 2 * motor_offset_y, base_height + base_wall_dc_motor_housing_thick]);

        translate ([base_thick, 0, base_height] - display_tolerance_y) rotate ([0, atan((base_height - 2) / housing_length), 0]) cube ([housing_length * sqrt(2), 2 * motor_radius + 2 * airflow_spacer_y + 2 * side_wall_dc_motor_housing_thick + 2 * motor_offset_y, base_height] + 2 * display_tolerance_y );
  
        
		translate([base_thick + motor_offset_x, side_wall_dc_motor_housing_thick + airflow_spacer_y + motor_offset_y, 0] + [motor_radius + airflow_spacer_x, motor_radius, 0]- display_tolerance_z) {
            // center motor hole
          translate (motor_holes_position[0]) cylinder ( h = motor_wall_dc_motor_housing_thick + 2 * display_tolerance, r = motor_center_hole_radius, $fn = 50);
          // M4 screw holes for fixing the motor
          for (i = [1 : 4]){
            translate (motor_holes_position[i]) cylinder ( h = motor_wall_dc_motor_housing_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
              // sunken screw holes
            translate (motor_holes_position[i]) cylinder ( h = m4_nut_thick, r2 = m4_screw_radius, r1 = m4_nut_radius, $fn = 20);
          }
       }
	}
}
//--------------------------------------------------------------------
module dc_motor_housing_with_base_holes(motor_offset_x, motor_offset_y, motor_radius, motor_length, base_height, motor_center_hole_radius, motor_holes_position, base_thick, motor_housing_base_holes)
{
    housing_width = 2 * motor_radius + 2 * side_wall_dc_motor_housing_thick + 2 * airflow_spacer_y + 2 * motor_offset_y;
    
    dist_to_first_hole_z = (base_height - motor_wall_dc_motor_housing_thick) / 2; 
    difference(){
        dc_motor_housing(motor_offset_x, motor_offset_y, motor_radius, motor_length, base_height, motor_center_hole_radius, motor_holes_position, base_thick);
        // base wall holes
        translate ([0, 0, motor_wall_dc_motor_housing_thick] + [0, housing_width / 2, dist_to_first_hole_z] - display_tolerance_x)
          rotate([0, 90, 0])
            for (i = [0 : 3]){
            translate (motor_housing_base_holes[i]) cylinder ( h = base_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
                // sunken screw holes
                translate (motor_housing_base_holes[i] + [0, 0, 1]) cylinder ( h = m4_nut_thick, r2 = m4_nut_radius, r1 = m4_screw_radius, $fn = 20);
            }
    }
}
//--------------------------------------------------------------------
module dc_motor_housing_with_belt_tensioner_bearing_based_y(motor_offset, belt_tensioner_offset, motor_radius, motor_length, base_height, motor_center_hole_radius, motor_holes_position, base_thick, motor_housing_base_holes, _left)
{
    housing_width = 2 * motor_radius + 2 * side_wall_dc_motor_housing_thick + 2 * airflow_spacer_y + 2 * motor_offset;
    
    difference(){
        dc_motor_housing_with_base_holes(0, motor_offset, motor_radius, motor_length, base_height, motor_center_hole_radius, motor_holes_position, base_thick,  motor_housing_base_holes);
    
     // belt tensioner hole
//            echo(_left=_left);
    if (_left){
            hull(){
              translate ([base_thick + motor_radius - 10, side_wall_dc_motor_housing_thick + 7.5, 0] - display_tolerance_z) cylinder ( h = motor_wall_dc_motor_housing_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
              translate ([base_thick + motor_radius + 10, side_wall_dc_motor_housing_thick + 7.5, 0] - display_tolerance_z) cylinder ( h = motor_wall_dc_motor_housing_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
            }
        }
        
        else{// right
            hull(){
              translate ([base_thick + motor_radius - 10, housing_width - side_wall_dc_motor_housing_thick - 7.5, 0] - display_tolerance_z) cylinder ( h = motor_wall_dc_motor_housing_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
              translate ([base_thick + motor_radius + 10, housing_width - side_wall_dc_motor_housing_thick - 7.5, 0] - display_tolerance_z) cylinder ( h = motor_wall_dc_motor_housing_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
            }
        }
          
    }
}
//--------------------------------------------------------------------

module motor_gr_ep_45_housing_with_belt_tensioner_bearing_based_y_and_base_holes(motor_offset, belt_tensioner_offset, left = 1)
{
  dc_motor_housing_with_belt_tensioner_bearing_based_y(motor_offset, belt_tensioner_offset, motor_gr_ep_45_radius, base_height = motor_gr_ep_45_housing_with_belt_tensioner_size[2], motor_center_hole_radius = motor_gr_ep_45_shaft_cilinder_radius, motor_holes_position = motor_gr_ep_45_holes, base_thick = 3, motor_housing_base_holes = motor_gr_ep_45_housing_large_base_holes, _left = left);
}
//---------------------------------------------------------------------------
module motor_gr_ep_45_housing_with_base_holes()
{
  dc_motor_housing_with_base_holes(0, 0, motor_gr_ep_45_radius, base_height = motor_gr_ep_45_housing_size[2], motor_center_hole_radius = motor_gr_ep_45_shaft_cilinder_radius, motor_holes_position = motor_gr_ep_45_holes, base_thick = 3, motor_housing_base_holes = motor_gr_ep_45_housing_small_base_holes);
}
//---------------------------------------------------------------------------

motor_gr_ep_45_housing_with_base_holes();

//motor_gr_ep_45_housing_with_belt_tensioner_bearing_based_y_and_base_holes(15, 0, 1);
// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_basic_components.scad>
include <params_dc_motors.scad>

    airflow_spacer_y = 1;
    airflow_spacer_x = 2;
    
	side_wall_dc_motor_housing_thick = wall_thick_3;
	base_wall_dc_motor_housing_thick = wall_thick_3;
	motor_wall_dc_motor_housing_thick = wall_thick_4;
	
	distance_holes_base_motor_housing_gr_ep_45_x = 16;
    distance_holes_base_motor_housing_gr_ep_45_y = motor_gr_ep_45_radius - 6;
	distance_holes_large_base_motor_housing_gr_ep_45_y = 30;
	
	motor_gr_ep_45_housing_large_base_holes = [
	[distance_holes_base_motor_housing_gr_ep_45_x, distance_holes_large_base_motor_housing_gr_ep_45_y, 0],
	[distance_holes_base_motor_housing_gr_ep_45_x, -distance_holes_large_base_motor_housing_gr_ep_45_y, 0],
	[-distance_holes_base_motor_housing_gr_ep_45_x, distance_holes_large_base_motor_housing_gr_ep_45_y, 0],
	[-distance_holes_base_motor_housing_gr_ep_45_x, -distance_holes_large_base_motor_housing_gr_ep_45_y, 0]
	];
    
	motor_gr_ep_45_housing_small_base_holes = [
	[distance_holes_base_motor_housing_gr_ep_45_x, distance_holes_base_motor_housing_gr_ep_45_y, 0],
	[distance_holes_base_motor_housing_gr_ep_45_x, -distance_holes_base_motor_housing_gr_ep_45_y, 0],
	[-distance_holes_base_motor_housing_gr_ep_45_x, distance_holes_base_motor_housing_gr_ep_45_y, 0],
	[-distance_holes_base_motor_housing_gr_ep_45_x, -distance_holes_base_motor_housing_gr_ep_45_y, 0]
	];

    motor_gr_ep_45_housing_size = [2 * motor_gr_ep_45_radius + base_wall_dc_motor_housing_thick, 2 * motor_gr_ep_45_radius + 2 * side_wall_dc_motor_housing_thick + 2 * airflow_spacer_y, 50];
    
    motor_gr_ep_45_housing_with_belt_tensioner_size = [2 * motor_gr_ep_45_radius + base_wall_dc_motor_housing_thick, 2 * motor_gr_ep_45_radius + 2 * side_wall_dc_motor_housing_thick + 2 * 15, 50];
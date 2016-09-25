// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_basic_components.scad>
include <params_dc_motors.scad>

	perete_lateral_motor_housing = wall_thick_3;
	perete_baza_motor_housing = wall_thick_3;
	perete_motor_motor_housing = wall_thick_4;

	//motor_housing_width = nema_17_width + 2 * perete_lateral_motor_housing;
	//motor_housing_height = perete_motor_motor_housing + 40; //perete_baza_motor_housing + 40;
    //motor_housing_length = nema_17_width + 2 * perete_lateral_motor_housing;
	
	distanta_gauri_baza_motor_housing_gr_ep_45_x = 12;
    distanta_gauri_baza_motor_housing_gr_ep_45_y = 15;
	distanta_gauri_large_baza_motor_housing_gr_ep_45_y = 30;
	
	motor_gr_ep_45_housing_large_base_holes = [
	[distanta_gauri_baza_motor_housing_gr_ep_45_x, distanta_gauri_large_baza_motor_housing_gr_ep_45_y, 0],
	[distanta_gauri_baza_motor_housing_gr_ep_45_x, -distanta_gauri_large_baza_motor_housing_gr_ep_45_y, 0],
	[-distanta_gauri_baza_motor_housing_gr_ep_45_x, distanta_gauri_large_baza_motor_housing_gr_ep_45_y, 0],
	[-distanta_gauri_baza_motor_housing_gr_ep_45_x, -distanta_gauri_large_baza_motor_housing_gr_ep_45_y, 0]
	];
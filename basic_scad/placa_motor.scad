// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_placa_motor.scad>
include <params_screws_nuts_washers.scad>
include <params_stepper_motors.scad>
include <params_basic_components.scad>
use <stepper_motors_utils.scad>
include <config.scad>

//----------------------------------------------------------------------------
module gauri_placa_motor(length, width, adancime, radius1 = 1.5, radius2 = 1.5, tolerance_x, tolerance_y)
{
	radius = m4_screw_radius;
    //dist_between_screw_holes_x = length - 2 * (8 + 0);
    //dist_between_screw_holes_y = width - 2 * (6 + 0);
   
    placa_motor_holes = f_placa_motor_holes(length, width);
        
    translate (placa_motor_holes[0] - display_tolerance_z) cylinder (h = adancime  + 2 * display_tolerance, r = nema_17_motor_hole_radius_camiel, $fn = 50);

    for (i = [1:4])
        hull(){
            translate (placa_motor_holes[i] - [tolerance_x, tolerance_y, 0] - display_tolerance_z) cylinder (h = adancime  + 2 * display_tolerance, r = radius, $fn = 50);
            translate (placa_motor_holes[i] + [tolerance_x, tolerance_y, 0] - display_tolerance_z) cylinder (h = adancime  + 2 * display_tolerance, r = radius, $fn = 50);
        }
}
//---------------------------------------------------------------------------
module placa_motor_trunchi(motor_housing_tolerance)
{
    difference(){
        color (plastic_color)
        translate ([-placa_motor_trunchi_size[0] / 2, -placa_motor_trunchi_size[1] / 2, 0]) my_cube_rounded2(placa_motor_trunchi_size);
        //translate ([- nema_17_width / 2, - nema_17_width / 2, 0]) gauri_nema17_with_motor_hole(placa_motor_trunchi_size[2], 1.5, 2.7);
        for (i =[0:4]){
            translate (gauri_nema_17[i]) cylinder (h = placa_motor_trunchi_size[2], r = 1.5, $fn = 20);
            translate (gauri_nema_17[i] + [0, 0, placa_motor_trunchi_size[2] - 2]) cylinder (h = 2, r1 = 1.5, r2 = 2.7, $fn = 20);
        }
        
        gauri_placa_motor(placa_motor_trunchi_size[0], placa_motor_trunchi_size[1], placa_motor_trunchi_size[2], 2.1, 2.1, motor_housing_tolerance, 0);
    }
}
//---------------------------------------------------------------------------


placa_motor_trunchi(7);
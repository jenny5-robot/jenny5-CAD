// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------
include <../basic_scad/params_basic_components.scad>
use <../basic_scad/potentiometer_support.scad>
use <../basic_scad/potentiometers.scad>
include <../basic_scad/params_potentiometers.scad>

//--------------------------------------------------------------
module potentiometer_support_shoulder_vertical()
{
    potentiometer_support_squared_with_screw_holes(length = 25, width = 48, height = 14, dist_between_support_holes = 30, dist_to_support_holes = 6);
}
//---------------------------------------------------------------------------
module potentiometer_support_motor1()
{
    length = pot_92R1A_J22_L15L_base_width + 2 * wall_thick_2;
}
//---------------------------------------------------------------------------
module elbow_potentiometer_support()
{
    potentiometer_support_on_rectangular_axis(length = 25, width = 23.3, potentiometer_height = 4, box_height = 15, vertical_distance_to_potentiometer = 7, _stopper_shift = -0.9);
}
//---------------------------------------------------------------------------
module shoulder_potentiometer_support()
{
potentiometer_support_squared_with_screw_holes(length = 25, width = 42, height = 13, dist_between_support_holes = 30, dist_to_support_holes = 5, stopper_shift = 0);
}
//---------------------------------------------------------------------------

potentiometer_support_shoulder_vertical();
elbow_potentiometer_support();
// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_worm_gear_motor.scad>
include <tolerance.scad>

//---------------------------------------------------------------
module worm_gear_motor(gear_box_size,
    motor_radius,
    motor_length,
    shaft_length,
    shaft_radius,
    shaft_position_x,
    shaft_position_y)
{
    color("grey"){
        // gear reduction
        cube(gear_box_size);
        // motor
        translate ([gear_box_size[0], gear_box_size[1] / 2, gear_box_size[2] / 2]) rotate ([0, 90, 0]) cylinder(h = motor_length, r = motor_radius);
        // shaft
        translate ([shaft_position_x, shaft_position_y, gear_box_size[2]])cylinder(h = shaft_length, r = shaft_radius);
    }
}

//---------------------------------------------------------------
module worm_gear_motor_600JSX()
{
    worm_gear_motor(
    worm_600JSX_gear_box_size,
worm_600JSX_motor_radius,
worm_600JSX_motor_length,
worm_600JSX_shaft_length,
worm_600JSX_shaft_radius,
worm_600JSX_shaft_position_x,
worm_600JSX_shaft_postion_y
);
}
//---------------------------------------------------------------
module worm_gear_motor_GR_WM2()
{
    worm_gear_motor(
    worm_GR_WM2_gear_box_size,
worm_GR_WM2_motor_radius,
worm_GR_WM2_motor_length,
worm_GR_WM2_shaft_length,
worm_GR_WM2_shaft_radius,
worm_GR_WM2_shaft_position_x,
worm_GR_WM2_shaft_position_y
);
}
//---------------------------------------------------------------
//worm_gear_motor_600JSX();

worm_gear_motor_GR_WM2();
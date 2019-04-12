// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------
include <params_laptop.scad>

module laptop13(lid_angle = 10)
{
    color ("LightCyan") cube(laptop13_size);
    color ("LightCyan") translate ([0, 0, laptop13_size[2] + 1]) rotate ([lid_angle, 0, 0]) cube([laptop13_size[0], laptop13_size[1], 3]);
}

laptop13(10);
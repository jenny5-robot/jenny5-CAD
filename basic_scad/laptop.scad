// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------
include <params_laptop.scad>

module laptop13(lid_angle = 10)
{
    color ("LightCyan") cube(laptop13_size);
    color ("LightCyan") translate ([0, 0, laptop13_size[2] + 1]) rotate ([lid_angle, 0, 0]) cube([laptop13_size[0], laptop13_size[1], 3]);
}

laptop13(10);
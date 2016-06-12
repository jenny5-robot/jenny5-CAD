// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------
include <params_webcam.scad>

module c920()
{
    color ("black") cube(c920_size);
    // cable
    color ("black") translate([c920_length - c920_dist_to_cable, c920_depth, c920_height / 2]) rotate([-90, 0, 0]) cylinder (h = 30, r = 2, $fn = 10);
}

c920();
// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
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
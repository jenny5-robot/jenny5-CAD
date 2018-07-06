// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <as5147_params.scad>
include <tolerance.scad>


//--------------------------------------------------------------
module as5147()
{
    difference(){
        color ("green") cube(as5147_board_size);
        for (i = [0 : 3])
            translate (as5147_holes_position[i] - display_tolerance_z) cylinder (h = as5147_board_size[2] + 2 * display_tolerance, r = 1.3, $fn = 10);
    }
}
//--------------------------------------------------------------


as5147();
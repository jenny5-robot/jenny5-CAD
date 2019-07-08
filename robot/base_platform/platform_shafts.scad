// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// License: MIT  
//--------------------------------------------------------------

include <base_platform_params.scad>
use <../../basic_scad/basic_components.scad>
include <../../basic_scad/config.scad>

//--------------------------------------------------------------

module first_shaft()
{
    difference(){
        translate ([0, 0, -platform_shaft_length / 2])
       color (aluminium_color) rectangular_tube(length = platform_shaft_edge_size, width = platform_shaft_edge_size, wall_thick = 2, height = platform_shaft_length);
    }
}
//--------------------------------------------------------------
module second_shaft()
{
    difference(){
       color (aluminium_color)  translate ([0, 0, -platform_shaft_length / 2]) rectangular_tube(length = platform_shaft_edge_size, width = platform_shaft_edge_size, wall_thick = 2, height = platform_shaft_length);
    }    
}
//--------------------------------------------------------------
module third_shaft()
{
    difference(){
        color (aluminium_color) translate ([0, 0, -platform_shaft_length / 2]) rectangular_tube(length = platform_shaft_edge_size, width = platform_shaft_edge_size, wall_thick = 2, height = platform_shaft_length);
    }
}
//--------------------------------------------------------------

first_shaft();
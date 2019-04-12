// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_ultrasonic.scad>
include <params_screws_nuts_washers.scad>
use <basic_components.scad>



//--------------------------------------------------------------
module hc_sr04()
{
  color("blue") cube(hc_sr04_sizes);
  color("silver") translate ([hc_sr04_sizes[1] / 2, hc_sr04_sizes[1] / 2, hc_sr04_sizes[2]]) cylinder_empty (12, hc_sr04_sizes[1] / 2, hc_sr04_sizes[1] / 2 - 1,40);  
    color("silver") translate ([hc_sr04_sizes[0] - hc_sr04_sizes[1] / 2, hc_sr04_sizes[1] / 2, hc_sr04_sizes[2]]) cylinder_empty (12, hc_sr04_sizes[1] / 2, hc_sr04_sizes[1] / 2 - 1, 40);  
}
//--------------------------------------------------------------

hc_sr04();
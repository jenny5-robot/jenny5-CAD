
// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------


include <../../basic_scad/params_screws_nuts_washers.scad>

include <../../basic_scad/config.scad>

include <body_params.scad>
include <../../basic_scad/as5147_params.scad>
use <../../basic_scad/sensor_support.scad>


//--------------------------------------------------------------
module body_sensor_support()
{
    as5147_sensor_support(distance_between_screws = 43, width = body_sheet_size[0] / 2 + as5147_space_between_holes_length / 2 + 2 + 1);
}
//---------------------------------------------------------------------------
body_sensor_support();
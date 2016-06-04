// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_stepper_motors.scad>
include <params_tera_ranger_one.scad>


use <tera_ranger_one.scad>
use <stepper_motors.scad>
use <buttons.scad>
use <stepper_motors_housing.scad>


//---------------------------------------------------------------------
module tera_ranger_one_on_motor()
{
    nema_17();
    rotate ([0, 0, 90]) translate ([-tera_ranger_one_sizes[0] / 2, 5.5, nema_17_height + 5]) rotate ([90, 0, 0]){ 
      translate ([10, 40, -3]) rotate ([-90, 0, 0]) import("TR1_spider.stl");
      tera_ranger_one_support();
    }
    
    translate ([-nema_17_width / 2, -nema_17_width / 2, nema_17_height])
    button_on_support();
    
    translate ([-nema_17_width, nema_17_width - 2 * 9, 0]) rotate ([90, 0, 0]) nema_17_fixer();
}
//---------------------------------------------------------------------

tera_ranger_one_on_motor();
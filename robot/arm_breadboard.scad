// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_breadboards.scad>
use <../basic_scad/breadboards.scad>

include <arm_breadboard_params.scad>

include <../basic_scad/params_electronic_components.scad>

use <../basic_scad/electronic_components.scad>

//--------------------------------------------------
module WBU_202_breadboard_with_components()
{
    WBU_202_breadboard();
    
    for (i = [0 : 5])
        translate ([i * 28, 20, WBU_202_breadboard_size[2]]) a4988();
}
//--------------------------------------------------
module arms_breadboard()
{
    // base
    translate ([WBU_202_breadboard_size[1] / 2, WBU_202_breadboard_size[2], 0]) rotate ([0, 0, 90]) rotate ([0, -90, 0]) WBU_202_breadboard();
    // lateral
    translate ([-WBU_202_breadboard_size[1] / 2 + WBU_202_breadboard_size[2], -WBU_202_breadboard_size[1], 0]) rotate ([0, -90, 0]) WBU_202_breadboard_with_components();
    
    // base
    translate ([WBU_202_breadboard_size[1] / 2 - WBU_202_breadboard_size[2], -WBU_202_breadboard_size[1], 0]) rotate ([0, -90, 0]) mirror([0, 0, 1]) WBU_202_breadboard_with_components();
}
//--------------------------------------------------


//WBU_202_breadboard();

arms_breadboard();
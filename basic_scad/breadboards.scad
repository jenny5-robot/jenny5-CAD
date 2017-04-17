// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------


include <params_breadboards.scad>

//--------------------------------------------------
module WBU_502_breadboard()
{
    cube(WBU_502_breadboard_size);
}
//--------------------------------------------------
module WBU_202_breadboard()
{
    cube(WBU_202_breadboard_size);
}
//--------------------------------------------------
module arms_breadboard()
{
    translate ([WBU_202_breadboard_size[1] / 2, WBU_202_breadboard_size[2], 0]) rotate ([0, 0, 90]) rotate ([0, -90, 0]) WBU_202_breadboard();
    translate ([-WBU_202_breadboard_size[1] / 2 + WBU_202_breadboard_size[2], -WBU_202_breadboard_size[1], 0]) rotate ([0, -90, 0]) WBU_202_breadboard();
    translate ([WBU_202_breadboard_size[1] / 2, -WBU_202_breadboard_size[1], 0]) rotate ([0, -90, 0]) WBU_202_breadboard();
}
//--------------------------------------------------

arms_breadboard();
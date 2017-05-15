// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_batteries.scad>

//---------------------------------------------------
module multistar_4s_16000()
{
    color("green") cube(multistar_4s_16000_size);
}
//---------------------------------------------------
module multistar_3s_1400()
{
    color ("blue") cube(multistar_3s_1400_size);
}
//---------------------------------------------------
module multistar_4s_20000()
{
    color("green") cube(multistar_4s_20000_size);
}
//---------------------------------------------------
module LiFePO4_20Ah()
{
    cube(LiFePO4_20Ah);
}
//---------------------------------------------------
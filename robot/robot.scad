// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_basic_components.scad>
use <../basic_scad/basic_components.scad>

include <../basic_scad/params_screws_nuts_washers.scad>
use <../basic_scad/screws_nuts_washers.scad>

include <../basic_scad/config.scad>


use <../basic_scad/masa.scad>
use <../basic_scad/spacer.scad>

include <params_robot.scad>

include <params_leg.scad>
use <leg.scad>

include <params_base_platform.scad>
use <base_platform.scad>

use <head.scad>

include <params_body.scad>
use <body.scad>
   
//---------------------------------------------------------------------------
module body_with_head()
{
    body();
    // head
    translate ([0, -latura_L / 2 - 1, chest_height + 37]) mirror ([0, 1, 0]) head();
    // spacers for linking head with body
    translate ([29, -latura_L, chest_height + 30]) rotate ([0, 90, 0]) spacer_with_1_hole(30, 37, 11);
    translate ([-40, -latura_L, chest_height + 30]) rotate ([0, 90, 0]) spacer_with_1_hole(30, 37, 11);
}
//---------------------------------------------------------------------------
module platform_foot()
{
    translate ([0, 0, base_platform_size[2]]) long_leg(angle_knee);
    // mobile platform
    translate ([-70, -base_platform_size[1] / 2, 0]) platform();
}
//---------------------------------------------------------------------------
module robot()
{
    long_leg_height = 2 * ((leg_bone_length - 2 * dist_to_incheietura) * cos(angle_knee) + (dist_to_incheietura_talpa + dist_to_incheietura_talpa_os));
    
    echo(long_leg_height = long_leg_height);
    
    translate ([50, 0, long_leg_height + 10]) rotate ([0, 0, 90]) body_with_head();
    platform_foot();
}
//---------------------------------------------------------------------------
module robot_with_kitchen_table()
{
    robot();
    translate ([-800, 0, 0]) masa_rotunda(750, 400);
}
//---------------------------------------------------------------------------

module gear_motor1()
{
    difference(){
      pulley(54, 32, 0, 0, 8, 4, 0, 0);// motor #1
        cylinder( h = 5, r = m8_nut_radius, $fn = 6);
    }
}
//---------------------------------------------------------------------------
//robot_with_kitchen_table();
robot();

//platform_foot();

//arm();

//body_with_head();

//belt_tensioner_base();


//body();

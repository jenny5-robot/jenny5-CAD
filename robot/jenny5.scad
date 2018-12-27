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


use <../basic_scad/spacer.scad>
use <../basic_scad/func_3d.scad>
include <../basic_scad/params_alu_profiles.scad>

include <leg_params.scad>
use <leg.scad>

include <base_platform_params.scad>
use <base_platform.scad>

use <head.scad>

include <body_params.scad>
use <body.scad>

include <../basic_scad/tolerance.scad>
   
//---------------------------------------------------------------------------
module body_with_head()
{
    //body_with_rotation(linear_motor_position = body_rotation_linear_motor_position);
    body_with_arms();
    // head
    translate ([0, -0, body_height + 3 * body_shaft_radius]) mirror ([0, 1, 0]) head();

}
//---------------------------------------------------------------------------
module platform_foot()
{
    // mobile platform
    translate ([0, -base_platform_size[1] / 2, 0]) platform();
    // leg
    translate ([leg_postion_on_platform, 0, base_platform_size[2]]) complete_leg(leg_angle);
}
//---------------------------------------------------------------------------
module robot()
{
    platform_foot();


    
    complete_leg_height = 2 * ((leg_bone_length - rbearing_6001_housing_size_thicker[0]) * cos(90 - leg_angle) + (dist_to_wrist_in_base + knee_side_simple_sizes[2] / 2 - 10));
    
    echo(complete_leg_height = complete_leg_height);
    
    translate ([leg_postion_on_platform + dist_to_first_bone, 0, complete_leg_height + base_platform_size[2] + 10]) rotate ([0, 0, 90]) body_with_head();
}
//---------------------------------------------------------------------------
module robot_with_kitchen_table()
{
    robot();
    translate ([-800, 0, 0]) rounded_table(750, 400);
}
//---------------------------------------------------------------------------
//robot_with_kitchen_table();

robot();

//platform_foot();

//body_with_head();


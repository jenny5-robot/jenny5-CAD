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

use <../basic_scad/table.scad>
use <../basic_scad/spacer.scad>
use <../basic_scad/func_3d.scad>
include <../basic_scad/params_alu_profiles.scad>

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
    body_with_rotation(linear_motor_position = body_rotation_linear_motor_position);
    // head
    translate ([0, -L_profile_40x20_short_size - 1, chest_height + 37]) mirror ([0, 1, 0]) head();
    // spacers for linking head with body
    translate ([29, -L_profile_40x20_long_size, chest_height + 30]) rotate ([0, 90, 0]) spacer_with_1_hole(30, 37, 11);
    translate ([-40, -L_profile_40x20_long_size, chest_height + 30]) rotate ([0, 90, 0]) spacer_with_1_hole(30, 37, 11);
}
//---------------------------------------------------------------------------
module platform_foot()
{
    // mobile platform
    translate ([0, -base_platform_size[1] / 2, 0]) platform();
    // leg
    translate ([leg_postion_on_platform, 0, base_platform_size[2]]) long_leg(leg_motor_position);
}
//---------------------------------------------------------------------------
module robot()
{
    platform_foot();

    h = 2 * area_heron(leg_base_length - 8 - dist_to_first_bone, leg_motor_max_stroke + 105 + leg_motor_position, distance_to_push_position) / (leg_base_length - 8 - dist_to_first_bone);
   
    leg_angle = 90 - asin( h / distance_to_push_position) + 11;
    
    long_leg_height = 2 * ((leg_bone_length - 2 * dist_to_wrist_in_bone) * cos(leg_angle) + (dist_to_wrist_in_base + knee_side_simple_sizes[2] / 2 - 8));
    
    echo(long_leg_height = long_leg_height);
    
    translate ([leg_postion_on_platform + dist_to_first_bone, 0, long_leg_height + base_platform_size[2] + 58]) rotate ([0, 0, 90]) body_with_head();
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


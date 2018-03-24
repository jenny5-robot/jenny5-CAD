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

include <params_robot.scad>

include <params_leg.scad>
use <leg.scad>

include <params_base_platform.scad>
use <base_platform.scad>

use <head.scad>

include <params_body.scad>
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
    translate ([leg_postion_on_platform, 0, base_platform_size[2]]) long_leg(leg_motor_position);
}
//---------------------------------------------------------------------------
module robot()
{
    platform_foot();

    motor_length = 105 + leg_motor_position + leg_motor_max_stroke;
    dist_leg_base_to_leg_spacer_top = sqrt(leg_spacer * leg_spacer + distance_to_push_position * distance_to_push_position);
    area = area_heron(motor_length, dist_to_push_motor_hole_in_base - dist_to_first_bone, dist_leg_base_to_leg_spacer_top);
    h = 2 * area / (dist_to_push_motor_hole_in_base - dist_to_first_bone);
    motor_angle_to_horizontal = asin(h / motor_length);
    motor_projection_on_horizontal = motor_length * cos(motor_angle_to_horizontal);
    gamma = atan(leg_spacer / distance_to_push_position);
    gama_plus_motor_angle_to_horizontal = motor_projection_on_horizontal < dist_to_push_motor_hole_in_base - dist_to_first_bone ? asin(h / dist_leg_base_to_leg_spacer_top): 180 - asin(h / dist_leg_base_to_leg_spacer_top);
    leg_angle_to_horizontal = gama_plus_motor_angle_to_horizontal - gamma;
    
    long_leg_height = 2 * ((leg_bone_length + 4 * (rb_6000_external_radius + 2) - 2 * dist_to_wrist_in_bone) * cos(90 - leg_angle_to_horizontal) + (dist_to_wrist_in_base + knee_side_simple_sizes[2] / 2 - 8));
    
    echo(long_leg_height = long_leg_height);
    
    translate ([leg_postion_on_platform + dist_to_first_bone, 0, long_leg_height + base_platform_size[2] + 10 + 30]) rotate ([0, 0, 90]) body_with_head();
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


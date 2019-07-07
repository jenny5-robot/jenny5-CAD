// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
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

include <leg/leg_params.scad>
use <leg/leg.scad>

include <base_platform/base_platform_params.scad>
use <base_platform/base_platform.scad>

use <head/head.scad>

include <body/body_params.scad>
use <body/body.scad>

include <arm/arm_params.scad>
use <arm/arm.scad>

include <../basic_scad/tolerance.scad>
use <../basic_scad/tube_bracket.scad>

use <../basic_scad/table.scad>

   
//---------------------------------------------------------------------------
module body_with_arms()
{
    body_with_rotation();
    
    // left arm
    translate ([(body_width / 2 - dist_edge_to_body_shaft), 0, body_arm_bone_size + body_height / 2])
        rotate ([0, 0, angle_body_arm])  
        translate ([0, -body_arm_offset, 0]) 
        translate ([body_arm_bone_size, 0, 0]) 
        rotate ([0, 90, 0]) 
        arm(side = 1)
        ;

/////////////////////////////////////////////////////////////////////////
    // right arm
    translate ([-body_width / 2 + dist_edge_to_body_shaft, 0, body_arm_bone_size + body_height / 2]) 
        rotate ([0, 0, -angle_body_arm]) 
           translate ([0, -body_arm_offset, 0]) 
    
    translate ([-body_arm_bone_size, 0, 0]) 
    mirror([1, 0, 0])
    rotate ([0, 90, 0]) 
    arm(side = 1)
    ;
        
}
//---------------------------------------------------------------------------

module body_with_head()
{
    //body_with_rotation(linear_motor_position = body_rotation_linear_motor_position);
    body_with_arms();
    // head
  //  translate ([0, -0, body_height + 3 * body_shaft_radius]) mirror ([0, 1, 0]) head();

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
    
    translate ([leg_postion_on_platform +100, 0, complete_leg_height + base_platform_size[2] + 25]) rotate ([0, 0, 90]) body_with_head();
}
//---------------------------------------------------------------------------
module robot_with_kitchen_table()
{
    robot();
    translate ([-800, 0, 0]) rounded_table(750, 400);
}
//---------------------------------------------------------------------------
robot_with_kitchen_table();

//robot();

//platform_foot();

//body_with_head();

//body_with_arms();

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

include <platform/base_platform_params.scad>
use <platform/base_platform.scad>

use <head/head.scad>

include <body/body_params.scad>
use <body/body.scad>

include <arm/arm_params.scad>
use <arm/arm.scad>

include <../basic_scad/tolerance.scad>
use <../basic_scad/tube_bracket.scad>
   
//---------------------------------------------------------------------------
module body_with_arms()
{
    body_with_rotation();
    
    // left arm
    translate ([(body_width / 2 - dist_edge_to_body_shaft), 0, body_shaft_radius + body_height / 2])
        rotate ([0, 0, angle_body_arm])  
        translate ([0, -body_arm_offset, 0]) 
        translate ([body_shaft_radius, 0, 0]) 
        rotate ([0, 90, 0]) 
        arm(side = 1)
        ;

// body brackets
// top
        translate ([(body_width / 2 - dist_edge_to_body_shaft), 0, body_shaft_radius + body_height / 2 + plate_body_size[0] / 2])    
    rotate ([0, 0, angle_body_arm])
    translate ([0, 0, -body_arm_bracket_thick / 2]) 
    rotate ([0, 90, 0]) 
    tube_bracket_long_one_hole(bracket_thick = body_arm_bracket_thick, tube_radius = body_shaft_radius)
    ;
// bottom
        translate ([(body_width / 2 - dist_edge_to_body_shaft), 0, body_shaft_radius + body_height / 2 - plate_body_size[0] / 2])    
    rotate ([0, 0, angle_body_arm])
    translate ([0, 0, body_arm_bracket_thick / 2]) 
    rotate ([0, 90, 0]) 
    tube_bracket_long_one_hole(bracket_thick = body_arm_bracket_thick, tube_radius = body_shaft_radius)
    ;
/////////////////////////////////////////////////////////////////////////
    // right arm
    translate ([-body_width / 2 + dist_edge_to_body_shaft, 0, body_shaft_radius + body_height / 2]) 
        rotate ([0, 0, -angle_body_arm]) 
           translate ([0, -body_arm_offset, 0]) 
    
    translate ([-body_shaft_radius, 0, 0]) 
    mirror([1, 0, 0])
    rotate ([0, 90, 0]) 
    arm(side = 1)
    ;
    
    // brackets
    // top
        translate ([-(body_width / 2 - dist_edge_to_body_shaft), 0, body_shaft_radius + body_height / 2 + plate_body_size[0] / 2])    
    rotate ([0, 0, -angle_body_arm])
    translate ([0, 0, -body_arm_bracket_thick / 2]) 
    rotate ([0, -90, 0]) 
    tube_bracket_long_one_hole(bracket_thick = body_arm_bracket_thick, tube_radius = body_shaft_radius)
    ;
// bottom
   
        translate ([-(body_width / 2 - dist_edge_to_body_shaft), 0, body_shaft_radius + body_height / 2 - plate_body_size[0] / 2])   
    rotate ([0, 0, -angle_body_arm])
    translate ([0, 0, body_arm_bracket_thick / 2]) 
    rotate ([0, -90, 0]) 
    tube_bracket_long_one_hole(bracket_thick = body_arm_bracket_thick, tube_radius = body_shaft_radius)
    ;

// screws & nuts for brackets
    bracket_holes = f_tube_bracket_single_hole(body_arm_bracket_thick, body_shaft_radius);
    bracket_width = f_bracket_width(body_shaft_radius);
    translate ([-(body_width / 2 - dist_edge_to_body_shaft), 0, body_shaft_radius + body_height / 2 + plate_body_size[0] / 2])    
        rotate ([0, 0, -angle_body_arm])
            translate ([0, 0, -body_arm_bracket_thick / 2] + [body_shaft_radius + 4 + m4_nut_thick, 0, 0]) 
                rotate ([0, -90, 0]) 
                    for (i = [0 : 1]){
                        translate ([0, -bracket_width / 2, 0] + [0, bracket_holes[i][1], 0]){ 
                        M4_hexa(40);
                        translate ([0, 0, 38]) M4_autolock_nut();
                        }
         //               translate ([plate_body_size[0] - body_arm_bracket_thick, -bracket_width / 2 + body_arm_offset, 0] + holes[i]) M4_hexa(40);
                    }    
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
//robot_with_kitchen_table();

robot();

//platform_foot();

//body_with_head();

//body_with_arms();

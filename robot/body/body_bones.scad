// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

use <../../basic_scad/basic_components.scad>
include <../../basic_scad/config.scad>

include <body_params.scad>

//---------------------------------------------------------------------------
module body_arm_bone(bone_length)
{
    echo("body arm bone length = ", bone_length);
    
    color(aluminium_color)
    rectangular_tube(body_arm_bone_size, body_arm_bone_size, 2, bone_length);
}
//---------------------------------------------------------------------------


body_arm_bone(body_arm_shaft_length);
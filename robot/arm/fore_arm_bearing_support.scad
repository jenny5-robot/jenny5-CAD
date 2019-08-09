// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------
include <../../basic_scad/material_colors.scad>
include <../../basic_scad/tolerance.scad>

include <arm_params.scad>

//---------------------------------------------------------------------------
module fore_arm_bearing_support()
{
    difference(){
        echo(fore_arm_bearing_support_size = fore_arm_bearing_support_size);
        color(plastic_color)
            cube(fore_arm_bearing_support_size);
        // screw holes
        translate([6, 0, fore_arm_bearing_support_size[2] / 2] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h = fore_arm_bearing_support_size[1] + 2 * display_tolerance, r = 2);
        
        translate([fore_arm_bearing_support_size[0] - elbow_pulley_holes_dist_x, 0, fore_arm_bearing_support_size[2] / 2] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h = fore_arm_bearing_support_size[1] + 2 * display_tolerance, r = 2);
        
       translate([fore_arm_bearing_support_size[0] - 3 * elbow_pulley_holes_dist_x, 0, fore_arm_bearing_support_size[2] / 2] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h = fore_arm_bearing_support_size[1] + 2 * display_tolerance, r = 2);
        
      // elbow pulley holes
        hole_length = 34;
      translate([fore_arm_bearing_support_size[0] - hole_length, fore_arm_bearing_support_size[1] - elbow_pulley_thick / 2, 0] - display_tolerance_z) cube([hole_length, elbow_pulley_thick / 2, fore_arm_bearing_support_size[2]] + 2 * display_tolerance_xyz); 
       
       // shaft hole
        translate([fore_arm_bearing_support_size[0] - (elbow_pulley_radius + rb_6907_external_radius + 1.5 - 10), fore_arm_bearing_support_size[1], 0] - display_tolerance_z)
        cylinder (h = fore_arm_bearing_support_size[2] + 2 * display_tolerance, r = rb_6907_external_radius - 2);
        
        // bearing hole
        
         translate([fore_arm_bearing_support_size[0] - (elbow_pulley_radius + rb_6907_external_radius + 1.5 - 10), fore_arm_bearing_support_size[1], 2])
        cylinder (h = rb_6907_thick, r = rb_6907_external_radius, $fn = 80);
        
    }
}
//---------------------------------------------------------------------------
module fore_arm_bearing_support_with_bearing_holes()
{
    difference(){
     fore_arm_bearing_support();
                // 6907 bearing size
        for (i = [1 : 4])
             translate ([fore_arm_bearing_support_size[0] - (elbow_pulley_radius + rb_6907_external_radius + 1.5 - 10), fore_arm_bearing_support_size[1], 0] - display_tolerance_z)  translate (rbearing_6907_housing_holes_position[i])  cylinder (h = 20, r = 2, $fn = 10); 
    }
}
//---------------------------------------------------------------------------
//fore_arm_bearing_support();
fore_arm_bearing_support_with_bearing_holes();
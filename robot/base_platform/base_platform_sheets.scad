// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License  
//--------------------------------------------------------------
include <base_platform_params.scad>
include <../../basic_scad/config.scad>
include <../../basic_scad/tolerance.scad>
include <../../basic_scad/params_radial_bearings_u_housing.scad>

//--------------------------------------------------------------------
module platform_sheet()
{
  difference(){    
      echo(base_platform_size = base_platform_size);
      
    translate ([0, - base_platform_size[1] / 2, 0]) 
      color(wood_color)
        cube(base_platform_size);
    
    // holes  
    // LEFT SIDE
      echo("LEFT SIDE");
    // first wheel, first bearing
    for (i = [0 : 1]){

        translate ([rbearing_6909_vertical_housing_size_half[0] / 2 + platform_motor_bearing_offset_x,  base_platform_size[1] / 2 - platform_motor_bearing_offset_y, 0] + rbearing_6909_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        echo("first shaft first bearing",  [rbearing_6909_vertical_housing_size_half[0] / 2 + platform_motor_bearing_offset_x,  base_platform_size[1] / 2 - platform_motor_bearing_offset_y, 0] + rbearing_6909_enclosed_housing_holes_position[i]);
    }
    
    // RIGHT SIDE
    echo("RIGHT SIDE");
    for (i = [0 : 1]){
        translate ([rbearing_6909_vertical_housing_size_half[0] / 2 + platform_motor_bearing_offset_x,  -base_platform_size[1] / 2 + platform_motor_bearing_offset_y, 0] + rbearing_6909_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        echo("first shaft first bearing",  [rbearing_6909_vertical_housing_size_half[0] / 2 + platform_motor_bearing_offset_x,  -base_platform_size[1] / 2 + platform_motor_bearing_offset_y, 0] + rbearing_6909_enclosed_housing_holes_position[i]);
    }   
    

    /*
    // leg support holes - first spacer
    translate([leg_postion_on_platform + dist_to_first_bone, base_platform_size[1] / 2 - dist_to_foot_spacer_hole, 0] - display_tolerance_z) cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m8_screw_radius, $fn = 10);
    translate([leg_postion_on_platform + dist_to_first_bone, base_platform_size[1] / 2 + dist_to_foot_spacer_hole, 0] - display_tolerance_z) cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m8_screw_radius, $fn = 10);
    
    // leg support holes - second spacer
    translate([leg_postion_on_platform + dist_to_second_bone, base_platform_size[1] / 2 - dist_to_foot_spacer_hole, 0] - display_tolerance_z) cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m8_screw_radius, $fn = 10);
    translate([leg_postion_on_platform + dist_to_second_bone, base_platform_size[1] / 2 + dist_to_foot_spacer_hole, 0] - display_tolerance_z) cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m8_screw_radius, $fn = 10);
    */
  }  
}

//------------------------------------------------------
module base_motor_support_sheet()
{
    cube(base_motor_support_sheet_size);
}
//------------------------------------------------------

platform_sheet();
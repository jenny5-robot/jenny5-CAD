// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License  
//--------------------------------------------------------------

include <base_platform_params.scad>

use <../../basic_scad/pulleys.scad>
include <../../basic_scad/params_screws_nuts_washers.scad>
use <../../basic_scad/screws_nuts_washers.scad>

include <../../basic_scad/config.scad>

use <../../basic_scad/belt.scad>

use <../../basic_scad/batteries.scad>
include <../../basic_scad/params_batteries.scad>

include <../../basic_scad/params_radial_bearings_u_housing.scad>
use <../../basic_scad/radial_bearing_u_housing.scad>
use <../../basic_scad/radial_bearings.scad>

use <../../basic_scad/basic_components.scad>

use <../../basic_scad/dc_motors.scad>

include <../../basic_scad/params_dc_motors.scad>

use <../../basic_scad/point_transformations_3d.scad>

use <../../basic_scad/involute_gears.scad>
use <../../basic_scad/alu_profiles.scad>

include <../../basic_scad/tolerance.scad>

use <platform_gears.scad>
use <tracks.scad>
use <base_platform_sheets.scad>

//--------------------------------------------------------------------
module base_motor_with_housing()
{ 
    translate ([-motor_gr_ep_45_radius, -motor_gr_ep_45_radius, motor_gr_ep_45_188_1_length]) base_motor_support_sheet();
    
    motor_gr_ep_45_188_1();
    
    translate ([0, 0, motor_gr_ep_45_188_1_length + motor_gr_ep_45_shaft_length]) mirror ([0, 0, 1])
    motor_gear();
}

//-------------------------------------------------------
module platform()
{
  platform_sheet();
    
    // reinforcement aluminium L profiles
    // left side
    translate ([0, -2, 2 + base_platform_size[2]]) 
    rotate ([-90, 0, 0]) 

    color(aluminium_color) U(length = base_platform_size[0], base = 20, height = 20, wall_thick = 2);

    // right side
    translate ([0, base_platform_size[1] + 2, -2]) 
        rotate ([90, 0, 0]) 
                color(aluminium_color) U(length = base_platform_size[0], base = 20, height = 20, wall_thick = 2);
    
  // motor right
    
  translate ([rb_6909_external_radius + 10, motor_gr_ep_45_188_1_length - 2, +rb_6909_external_radius + base_platform_size[2] + 4]) 
    rotate([90, 180, 0])
        base_motor_with_housing()
    ;
    
    // motor left
  translate ([rb_6909_external_radius + 10, base_platform_size[1] - motor_gr_ep_45_188_1_length + 2, rb_6909_external_radius + base_platform_size[2] + 4])
      rotate([-90, 180, 0])
        rotate([0, 0, 180]) 
          base_motor_with_housing()
          ;
    
    // motor bearing support left side
    // bottom
    translate ([rbearing_6909_vertical_housing_size_half[0] / 2 + platform_motor_bearing_offset_x, platform_motor_bearing_offset_y, base_platform_size[2]]) rbearing_6909_vertical_housing_half();
    // top
    translate ([rbearing_6909_vertical_housing_size_half[0] / 2 + platform_motor_bearing_offset_x, platform_motor_bearing_offset_y, base_platform_size[2] + 2 * rbearing_6909_vertical_housing_size_half[2]]) mirror([0, 0, 1]) rbearing_6909_vertical_housing_half();
    // bearing
    translate ([rbearing_6909_vertical_housing_size_half[0] / 2 + platform_motor_bearing_offset_x, platform_motor_bearing_offset_y + rb_6909_thick / 2, base_platform_size[2] + rbearing_6909_vertical_housing_size_half[2]]) rotate([90, 0, 0])
    6909rs();

    // motor bearing support right side
    // bottom
    translate ([rbearing_6909_vertical_housing_size_half[0] / 2 + platform_motor_bearing_offset_x, base_platform_size[1] - platform_motor_bearing_offset_y, base_platform_size[2]]) rbearing_6909_vertical_housing_half();
    // top
    translate ([rbearing_6909_vertical_housing_size_half[0] / 2 + platform_motor_bearing_offset_x, base_platform_size[1] -platform_motor_bearing_offset_y, base_platform_size[2] + 2 * rbearing_6909_vertical_housing_size_half[2]]) mirror([0, 0, 1]) rbearing_6909_vertical_housing_half();
    // bearing
    translate ([rbearing_6909_vertical_housing_size_half[0] / 2 + platform_motor_bearing_offset_x, base_platform_size[1] -platform_motor_bearing_offset_y + rb_6909_thick / 2, base_platform_size[2] + rbearing_6909_vertical_housing_size_half[2]]) rotate([90, 0, 0])
    6909rs();

// wheels
    
    translate ([0, -track_wheel_thick / 2 - tracks_offset - wheel_gear_thick, 0]) {
            
    //first wheel
        translate ([first_wheel_offset, 0, -12.5 - 2]) rotate([-90, 0, 0]) first_wheel();
    
    //second wheel
        translate ([third_wheel_offset, 0, -12.5 - 2]) rotate([-90, 0, 0]) wheel();

        // rubber tracks
   translate ([first_wheel_offset, track_width / 2 + wheel_gear_thick, -12.5 - 2])
        rotate([90, 0, 0]) 
         color ("black") belt_on_2_pulleys(r1 = wheel_radius +9 , r2 = wheel_radius + 9, distance_between_pulleys = third_wheel_offset - first_wheel_offset, belt_width = 50, belt_thick = 18)
        ;
    }

// other side

   

    translate([0, base_platform_size[1] + track_width / 2 + tracks_offset + wheel_gear_thick, 0]){
    // first wheel
        translate ([first_wheel_offset, 0, -12.5 - 2]) rotate([90, 0, 0]) first_wheel();
    // second wheel
        translate ([third_wheel_offset, 0, -12.5 - 2]) mirror([0, 1, 0]) rotate([-90, 0, 0]) wheel();

    // rubber tracks
        translate ([first_wheel_offset, 0, -12.5 - 2]) 
            rotate([90, 0, 0])
            color ("black") belt_on_2_pulleys(r1 = wheel_radius + 9, r2 = wheel_radius + 9, distance_between_pulleys = third_wheel_offset - first_wheel_offset, belt_width = 50, belt_thick = 10);
    }


// first shaft
color(aluminium_color) translate ([first_wheel_offset, - 75, -2 - 12.5]) rotate ([-90, 0, 0]) rectangular_tube(length = platform_shaft_edge_size, width = platform_shaft_edge_size, wall_thick = 2, height = base_platform_size[1] + 150);

// second shaft
color(aluminium_color) translate ([third_wheel_offset, - 75, -2 - 12.5]) rotate ([-90, 0, 0]) rectangular_tube(length = platform_shaft_edge_size, width = platform_shaft_edge_size, wall_thick = 2, height = base_platform_size[1] + 150);

    // lidar

  // translate([lidar_position, base_platform_size[1] / 2, base_platform_size[2]]) rotate([0, 0, 90]) tera_ranger_one_lidar();

// batteries
   //translate([base_platform_size[0] - laptop13_size[1], 0, base_platform_size[2]]) multistar_4s_16000();
   // translate([base_platform_size[0] - laptop13_size[1], base_platform_size[1] - multistar_4s_16000_size[1], base_platform_size[2]]) multistar_4s_16000(); 
}
//--------------------------------------------------------------------


platform();

//platform_sheet(); 

//motor_gear();
//platform_wheel_gear();

//wheel();
//first_wheel();

//base_motor_with_housing();

//wheel_extension_with_teeth(radius = 54.66 * 0.955,  height = 10, steps = 20);

//wheel_wall(radius = 54.66 * 0.955, height = 4);

//wheel_middle_external(external_radius = 54.66 * 0.955);

//wheel_middle_internal(external_radius = 54.66 * 0.955);

//wheel_middle_with_bearing_hole(external_radius = 54.66 * 0.955);

//wheel_middle_with_bearing(external_radius = 54.66 * 0.955);

//tooth2(height = 10, length = 9, thick = 9);

//laptop_fixer_corner_left();

//laptop_fixer_corner_right();
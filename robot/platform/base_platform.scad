// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License  
//--------------------------------------------------------------

use <../../basic_scad/pulleys.scad>
include <../../basic_scad/params_screws_nuts_washers.scad>
include <base_platform_params.scad>

include <../../basic_scad/config.scad>

use <../../basic_scad/screws_nuts_washers.scad>
use <../../basic_scad/belt.scad>


use <../../basic_scad/batteries.scad>
include <../../basic_scad/params_batteries.scad>

include <../../basic_scad/params_radial_bearings_u_housing.scad>
use <../../basic_scad/radial_bearing_u_housing.scad>

use <../../basic_scad/basic_components.scad>

use <../../basic_scad/dc_motors.scad>

include <../../basic_scad/params_dc_motors.scad>

use <../../basic_scad/point_transformations_3d.scad>

use <../../basic_scad/involute_gears.scad>
use <../../basic_scad/alu_profiles.scad>

include <../../basic_scad/tolerance.scad>

use <tracks.scad>
use <tracks_small.scad>
//------------------------------------------------------
module motor_gear()
{
    extra_length =  10;
    
    difference(){
        rotate ([0, 0, 7.5])
        color(plastic_color)
            gear (number_of_teeth = 25,
					circular_pitch = 500,
					bore_diameter = 10,
					hub_diameter = 30,
					rim_width = 4,
					hub_thickness = motor_gear_height + extra_length,
					rim_thickness = motor_gear_height,
					gear_thickness = motor_gear_height,
					pressure_angle = 31);
        // motor shaft hole
        //translate (-display_tolerance_z) cylinder (h = motor_gear_height + extra_length + 2 * display_tolerance, r = 5, $fn = 30);
        
        // 1st screw hole
        translate ([0, 0, motor_gear_height / 2]) rotate ([0, 90, 0]) cylinder(h = 50, r = m4_screw_radius, $fn = 20);
        // 1st nut hole
        hull(){
            translate ([7, 0, motor_gear_height / 2]) rotate ([0, 90, 0]) cylinder(h = 2 * m4_nut_thick, r = m4_nut_radius, $fn = 6);
            translate ([7, 0, 0]) rotate ([0, 90, 0]) cylinder(h = 2 * m4_nut_thick, r = m4_nut_radius, $fn = 6);
        }
        // 2nd screw hole
        translate ([0, 0, motor_gear_height + extra_length / 2]) rotate ([0, 90, 0]) cylinder(h = 50, r = m4_screw_radius, $fn = 20);
        // 2nd nut hole
        hull(){
            translate ([7, 0, motor_gear_height + extra_length / 2]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick, r = m4_nut_radius, $fn = 6);
            translate ([7, 0, motor_gear_height + extra_length]) rotate ([0, 90, 0]) cylinder(h = m4_nut_thick, r = m4_nut_radius, $fn = 6);
        }
    }
}
//--------------------------------------------------------------------
module base_motor_support_sheet()
{
    cube(base_motor_support_sheet_size);
}
//--------------------------------------------------------------------
module base_motor_with_housing()
{ 
    translate ([-motor_gr_ep_45_radius, -motor_gr_ep_45_radius, motor_gr_ep_45_188_1_length]) base_motor_support_sheet();
    
    motor_gr_ep_45_188_1();
    
    translate ([0, 0, motor_gr_ep_45_188_1_length + motor_gr_ep_45_shaft_length]) mirror ([0, 0, 1])
    motor_gear();
}
//--------------------------------------------------------------------
module platform_sheet()
{
  difference(){    
    cube(base_platform_size);
    
    // holes  
    // LEFT SIDE
      echo("LEFT SIDE");
    // first wheel, first bearing
    for (i = [0 : 1]){
        translate ([first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_1_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        echo("first shaft first bearing",  [first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_1_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i]);
    }
    // first wheel, second bearing
       for (i = [0 : 1]){
    translate ([first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_2_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        echo("first shaft second bearing",  [first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_2_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i]);
    }
    // second wheel, first bearing
    for (i = [0 : 1]){
        translate ([first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2 + distance_between_wheels, wheels_bearing_housing_1_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        echo("second shaft first bearing",  [first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2 + distance_between_wheels, wheels_bearing_housing_1_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i]);
    }
    // second gear, second bearing
    for (i = [0 : 1]){
        translate ([first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2 + distance_between_wheels, wheels_bearing_housing_2_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        echo("second shaft second bearing",  [first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2 + distance_between_wheels, wheels_bearing_housing_2_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i]);
    }
    
    // RIGHT SIDE
    echo("RIGHT SIDE");
     // first gear, first bearing
    for (i = [0 : 1]){
        translate ([0, base_platform_size[1], 0]) mirror([0, 1, 0]) translate ([first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_1_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        echo("first shaft first bearing",  [0, base_platform_size[1], 0] + mirror_y([first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_1_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i]));
    }
  
    // first gear, second bearing
    for (i = [0 : 1]){
        translate ([0, base_platform_size[1], 0]) mirror([0, 1, 0]) translate ([first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_2_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        echo("first shaft second bearing",  [0, base_platform_size[1], 0] + mirror_y([first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_2_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i]));
    }
    
    /// second gear, first bearing
    for (i = [0 : 1]){
        translate ([0, base_platform_size[1], 0]) mirror([0, 1, 0]) translate ([first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2 + distance_between_wheels, wheels_bearing_housing_1_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        echo("second shaft first bearing",  [0, base_platform_size[1], 0] + mirror_y([first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2 + distance_between_wheels, wheels_bearing_housing_1_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i]));
    }
    // second gear, second bearing
    for (i = [0 : 1]){
        translate ([0, base_platform_size[1], 0]) mirror([0, 1, 0]) translate ([first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2 + distance_between_wheels, wheels_bearing_housing_2_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        echo("second shaft second bearing",  [0, base_platform_size[1], 0] + mirror_y([first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2 + distance_between_wheels, wheels_bearing_housing_1_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i]));
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
//-------------------------------------------------------
module laptop_fixer_corner_left()
{
  difference(){
    color (plastic_color) corner(40, 40, 40, 3);
    hull(){
        translate ([3 + 5, 10, 0] - display_tolerance_z) cylinder(h = 3 + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        translate ([3 + 5, 40 - (6), 0] - display_tolerance_z) cylinder(h = 3 + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
    }
  }
}
//--------------------------------------------------------------------
module laptop_fixer_corner_right()
{
  difference(){
    color (plastic_color) corner(40, 40, 40, 3);
    hull(){
        translate ([10, 3 + 5, 0] - display_tolerance_z) cylinder(h = 3 + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        translate ([40 - 6, 3 + 5, 0] - display_tolerance_z) cylinder(h = 3 + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
    }
  }
}
//--------------------------------------------------------------------
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
    
  translate ([rb_6909_external_radius + 10, motor_gr_ep_45_188_1_length, +rb_6909_external_radius + base_platform_size[2] + 4]) 
    rotate([90, 0, 0])
        base_motor_with_housing()
    ;
    
    // motor left
  translate ([rb_6909_external_radius + 10, base_platform_size[1] - motor_gr_ep_45_188_1_length, rb_6909_external_radius + base_platform_size[2] + 4])
      rotate([-90, 0, 0])
        rotate([0, 0, 180]) 
          base_motor_with_housing()
          ;
    

// wheels
    
    translate ([0, -track_wheel_thick / 2 - tracks_offset - wheel_gear_thick, 0]) {
            
    //first gear
        translate ([first_tracks_offset, 0, -12.5 - 2]) rotate([-90, 0, 0]) first_wheel();
    
    //second gear
        translate ([first_tracks_offset + distance_between_wheels, 0, -12.5 - 2]) rotate([-90, 0, 0]) wheel();

        // rubber tracks
   translate ([first_tracks_offset, track_width / 2 + wheel_gear_thick, -12.5 - 2])
        rotate([90, 0, 0]) 
         color ("black") belt_on_2_pulleys(r1 = wheel_radius +9 , r2 = wheel_radius + 9, distance_between_pulleys = distance_between_wheels, belt_width = 50, belt_thick = 18)
        ;
    }
    /*
    // wheel extension front
    translate ([first_tracks_offset, -70, -12.5 - 2]) rotate ([0, -(180 - small_tracks_angle), 0]) 
    translate ([-small_tracks_wheel_distance_to_shaft, 0, -small_tracks_sheet_size[1] / 2]) 
    rotate([90, 0, 0]) small_track();

    // wheel extension back
    translate ([first_tracks_offset + distance_between_wheels, -10, -12.5 - 2]) rotate ([0, -small_tracks_angle, 0]) 
    translate ([-small_tracks_wheel_distance_to_shaft, 0, -small_tracks_sheet_size[1] / 2]) 
    rotate([90, 0, 0]) small_track();
*/
// other side

   

    translate([0, base_platform_size[1] + track_width / 2 + tracks_offset + wheel_gear_thick, 0]){
    // first wheel
        translate ([first_tracks_offset, 0, -12.5 - 2]) rotate([90, 0, 0]) first_wheel();
    // second wheel
        translate ([first_tracks_offset + distance_between_wheels, 0, -12.5 - 2]) mirror([0, 1, 0]) rotate([-90, 0, 0]) wheel();

    // rubber tracks
        translate ([first_tracks_offset, 0, -12.5 - 2]) 
            rotate([90, 0, 0])
            color ("black") belt_on_2_pulleys(r1 = wheel_radius + 9, r2 = wheel_radius + 9, distance_between_pulleys = distance_between_wheels, belt_width = 50, belt_thick = 10);
    }
    /*
    // wheel extension front
    translate ([first_tracks_offset, base_platform_size[1] + track_width + tracks_offset + wheel_gear_thick, -12.5 - 2]) rotate ([0, -(180 - small_tracks_angle), 0]) 
        translate ([-small_tracks_wheel_distance_to_shaft, 0, -small_tracks_sheet_size[1] / 2]) 
            rotate([90, 0, 0]) small_track();

    // wheel extension back
    translate ([first_tracks_offset + distance_between_wheels, base_platform_size[1] + 20, -12.5 - 2]) rotate ([0, -small_tracks_angle, 0]) 
        translate ([-small_tracks_wheel_distance_to_shaft, 0, -small_tracks_sheet_size[1] / 2]) 
            rotate([90, 0, 0]) small_track();
*/
// first shaft
color(aluminium_color) translate ([first_tracks_offset, - 75, -2 - 12.5]) rotate ([-90, 0, 0]) rectangular_tube(length = platform_shaft_edge, width = platform_shaft_edge, wall_thick = 2, height = base_platform_size[1] + 150);

// second shaft
color(aluminium_color) translate ([first_tracks_offset + distance_between_wheels, - 75, -2 - 12.5]) rotate ([-90, 0, 0]) rectangular_tube(length = platform_shaft_edge, width = platform_shaft_edge, wall_thick = 2, height = base_platform_size[1] + 150);

    // back wheel
    
   // translate ([base_platform_size[0] + 100, base_platform_size[1]/2, -rb_6201_external_radius - tracks_wheel_radius - track_height + chair_wheel_radius]) rotate ([0, 0, 90]) chair_wheel();
    
    // laptop
//translate ([base_platform_size[0] - laptop13_size[1], laptop13_size[0] / 2 + base_platform_size[1] / 2, 50]) rotate ([0, 0, 0]) rotate ([0, 0, -90]) translate ([0, 0, base_platform_size[2]]) laptop13();

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
// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_radial_bearings.scad>
use <../basic_scad/radial_bearings.scad>

include <../basic_scad/params_basic_components.scad>

use <../basic_scad/pulleys.scad>
include <../basic_scad/params_screws_nuts_washers.scad>
include <params_base_platform.scad>

include <../basic_scad/params_laptop.scad>
use <../basic_scad/laptop.scad>

include <../basic_scad/params_chair_wheel.scad>
use <../basic_scad/chair_wheel.scad>

include <../basic_scad/config.scad>

include <../basic_scad/params_stepper_motors.scad>

use <../basic_scad/stepper_motors.scad>
use <../basic_scad/stepper_motors_housing.scad>
use <../basic_scad/lidar.scad>

use <../basic_scad/screws_nuts_washers.scad>
use <../basic_scad/belt.scad>

use <../basic_scad/belt_tensioner.scad>

use <../basic_scad/batteries.scad>
include <../basic_scad/params_batteries.scad>

include <../basic_scad/params_radial_bearings_housing.scad>
use <../basic_scad/radial_bearing_housing.scad>

use <../basic_scad/basic_components.scad>

include <params_leg.scad>

use <../basic_scad/dc_motors.scad>
use <../basic_scad/dc_motors_housing.scad>

include <../basic_scad/params_dc_motors.scad>
include <../basic_scad/params_dc_motor_housing.scad>

use <../basic_scad/point_transformations_3d.scad>

use <../basic_scad/involute_gears.scad>
use <../basic_scad/alu_profiles.scad>

use <../basic_scad/worm_gear_motor.scad>
include <../basic_scad/params_worm_gear_motor.scad>

use <../basic_scad/screw_hub.scad>

use <tracks.scad>
include <params_tracks.scad>
include <../basic_scad/tolerance.scad>

//--------------------------------------------------------------------
module motor_gear()
{
    extra_length =  0;
    
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
        
     }
}
//--------------------------------------------------------------------
module base_motor_with_housing()
{
    motor_gr_ep_45_housing_with_base_holes();
   
    translate ([motor_gr_ep_45_radius + base_wall_dc_motor_housing_thick + 2, motor_gr_ep_45_radius + side_wall_dc_motor_housing_thick, motor_gr_ep_45_188_1_length + 3]) mirror([0, 0, 1]) motor_gr_ep_45_188_1();
    
    // motor hob
    translate ([motor_gr_ep_45_radius + base_wall_dc_motor_housing_thick + 2, motor_gr_ep_45_radius + side_wall_dc_motor_housing_thick, -17])
    
    screw_hub(internal_radius = 5, large_external_radius = 20, small_external_radius = 10, large_cylinder_thick = 6, small_cylinder_thick = 8, screws_hole_radius = 2.5, distance_between_screws_hole = 22);
    
    translate ([motor_gr_ep_45_radius + base_wall_dc_motor_housing_thick + 2, motor_gr_ep_45_radius + side_wall_dc_motor_housing_thick, -20]) motor_gear();
    
    
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
        translate ([first_tracks_offset - rbearing_6005_enclosed_housing_size[0] / 2, wheels_bearing_housing_1_offset_y, 0] + rbearing_6005_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        echo("first shaft first bearing",  [first_tracks_offset - rbearing_6005_enclosed_housing_size[0] / 2, wheels_bearing_housing_1_offset_y, 0] + rbearing_6005_enclosed_housing_holes_position[i]);
    }
    // first wheel, second bearing
       for (i = [0 : 1]){
    translate ([first_tracks_offset - rbearing_6005_enclosed_housing_size[0] / 2, wheels_bearing_housing_2_offset_y, 0] + rbearing_6005_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        echo("first shaft second bearing",  [first_tracks_offset - rbearing_6005_enclosed_housing_size[0] / 2, wheels_bearing_housing_2_offset_y, 0] + rbearing_6005_enclosed_housing_holes_position[i]);
    }
    // second wheel, first bearing
    for (i = [0 : 1]){
        translate ([first_tracks_offset - rbearing_6005_enclosed_housing_size[0] / 2 + distance_between_tracks, wheels_bearing_housing_1_offset_y, 0] + rbearing_6005_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        echo("second shaft first bearing",  [first_tracks_offset - rbearing_6005_enclosed_housing_size[0] / 2 + distance_between_tracks, wheels_bearing_housing_1_offset_y, 0] + rbearing_6005_enclosed_housing_holes_position[i]);
    }
    // second gear, second bearing
    for (i = [0 : 1]){
        translate ([first_tracks_offset - rbearing_6005_enclosed_housing_size[0] / 2 + distance_between_tracks, wheels_bearing_housing_2_offset_y, 0] + rbearing_6005_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        echo("second shaft second bearing",  [first_tracks_offset - rbearing_6005_enclosed_housing_size[0] / 2 + distance_between_tracks, wheels_bearing_housing_2_offset_y, 0] + rbearing_6005_enclosed_housing_holes_position[i]);
    }
    
    // holes for motor housing
    for (i = [0 : 3]){
        echo("motor housing holes = ", [motor_gr_ep_45_housing_size[1] / 2, (motor_gr_ep_45_housing_size[2] - motor_wall_dc_motor_housing_thick)/ 2 + motor_wall_dc_motor_housing_thick, 0] + rotate_z(90, motor_gr_ep_45_housing_small_base_holes[i]));
        translate ([motor_gr_ep_45_housing_size[1] / 2, (motor_gr_ep_45_housing_size[2] - motor_wall_dc_motor_housing_thick) / 2 + motor_wall_dc_motor_housing_thick, 0]) rotate ([0, 0, 90]) translate (motor_gr_ep_45_housing_small_base_holes[i] - display_tolerance_z) cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
    }
        
    // RIGHT SIDE
    echo("RIGHT SIDE");
     // first gear, first bearing
    for (i = [0 : 1]){
        translate ([0, base_platform_size[1], 0]) mirror([0, 1, 0]) translate ([first_tracks_offset - rbearing_6005_enclosed_housing_size[0] / 2, wheels_bearing_housing_1_offset_y, 0] + rbearing_6005_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        echo("first shaft first bearing",  [0, base_platform_size[1], 0] + mirror_y([first_tracks_offset - rbearing_6005_enclosed_housing_size[0] / 2, wheels_bearing_housing_1_offset_y, 0] + rbearing_6005_enclosed_housing_holes_position[i]));
    }
  
    // first gear, second bearing
    for (i = [0 : 1]){
        translate ([0, base_platform_size[1], 0]) mirror([0, 1, 0]) translate ([first_tracks_offset - rbearing_6005_enclosed_housing_size[0] / 2, wheels_bearing_housing_2_offset_y, 0] + rbearing_6005_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        echo("first shaft second bearing",  [0, base_platform_size[1], 0] + mirror_y([first_tracks_offset - rbearing_6005_enclosed_housing_size[0] / 2, wheels_bearing_housing_2_offset_y, 0] + rbearing_6005_enclosed_housing_holes_position[i]));
    }
    
    /// second gear, first bearing
    for (i = [0 : 1]){
        translate ([0, base_platform_size[1], 0]) mirror([0, 1, 0]) translate ([first_tracks_offset - rbearing_6005_enclosed_housing_size[0] / 2 + distance_between_tracks, wheels_bearing_housing_1_offset_y, 0] + rbearing_6005_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        echo("second shaft first bearing",  [0, base_platform_size[1], 0] + mirror_y([first_tracks_offset - rbearing_6005_enclosed_housing_size[0] / 2 + distance_between_tracks, wheels_bearing_housing_1_offset_y, 0] + rbearing_6005_enclosed_housing_holes_position[i]));
    }
    // second gear, second bearing
    for (i = [0 : 1]){
        translate ([0, base_platform_size[1], 0]) mirror([0, 1, 0]) translate ([first_tracks_offset - rbearing_6005_enclosed_housing_size[0] / 2 + distance_between_tracks, wheels_bearing_housing_2_offset_y, 0] + rbearing_6005_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        echo("second shaft second bearing",  [0, base_platform_size[1], 0] + mirror_y([first_tracks_offset - rbearing_6005_enclosed_housing_size[0] / 2 + distance_between_tracks, wheels_bearing_housing_1_offset_y, 0] + rbearing_6005_enclosed_housing_holes_position[i]));
    }
    
    // holes for motor housing
    for (i = [0 : 3]){
        echo("motor housing holes = ", [0, base_platform_size[1], 0] + mirror_y([motor_gr_ep_45_housing_size[1] / 2, (motor_gr_ep_45_housing_size[2] - motor_wall_dc_motor_housing_thick) / 2 + motor_wall_dc_motor_housing_thick, 0] + rotate_z(90, motor_gr_ep_45_housing_small_base_holes[i])) );
        translate ([0, base_platform_size[1], 0]) mirror([0, 1, 0]) translate ([motor_gr_ep_45_housing_size[1] / 2, (motor_gr_ep_45_housing_size[2] - motor_wall_dc_motor_housing_thick) / 2 + motor_wall_dc_motor_housing_thick, 0]) rotate ([0, 0, 90]) translate (motor_gr_ep_45_housing_small_base_holes[i] - display_tolerance_z) cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
    }
    
/*    
    // leg support holes - first spacer
    translate([leg_postion_on_platform + dist_to_first_spacer, base_platform_size[1] / 2 - dist_to_foot_spacer_hole, 0] - display_tolerance_z) cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m8_screw_radius, $fn = 10);
    translate([leg_postion_on_platform + dist_to_first_spacer, base_platform_size[1] / 2 + dist_to_foot_spacer_hole, 0] - display_tolerance_z) cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m8_screw_radius, $fn = 10);
    
    // leg support holes - second spacer
    translate([leg_postion_on_platform + dist_to_second_spacer, base_platform_size[1] / 2 - dist_to_foot_spacer_hole, 0] - display_tolerance_z) cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m8_screw_radius, $fn = 10);
    translate([leg_postion_on_platform + dist_to_second_spacer, base_platform_size[1] / 2 + dist_to_foot_spacer_hole, 0] - display_tolerance_z) cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m8_screw_radius, $fn = 10);
    */
  }  
}
//-------------------------------------------------------
module radial_bearing_housing_with_bearing_platform()
{
    radial_bearing_6005_vertical_housing(0);
    translate ([0, radial_bearing_vertical_housing_grosime_perete_lateral_latime, rb_6005_external_radius + radial_bearing_vertical_housing_base_wall_thick ]) rotate ([-90, 0, 0]) 6005rs();
}
//--------------------------------------------------------------------
module worm_gear_motor_with_pinion()
{
    worm_gear_motor_GR_WM2();
    
    translate ([worm_GR_WM2_shaft_position_x, worm_GR_WM2_shaft_position_y, worm_GR_WM2_gear_box_size[2] + 3])
    gear (number_of_teeth = 20,
					circular_pitch = _circular_pitch,
					bore_diameter = 12,
					hub_diameter = 0,
					rim_width = 4,
					hub_thickness = 4,
					rim_thickness = wheel_gear_height,
					gear_thickness = wheel_gear_height,
					pressure_angle = 31
    );
}
//--------------------------------------------------------------------
module platform()
{
  platform_sheet();
    
    // reinforcement aluminium L profiles
    // left side
    translate ([0, -3, 3 + base_platform_size[2]]) rotate ([180, 0, 0]) rotate ([0, 0, -90]) L_profile(base_platform_size[0], edge_1_width = 25, edge_2_width = 25, wall_thick = 3);
    // right side
    translate ([0, base_platform_size[1] + 3, 3 + base_platform_size[2]]) rotate ([90, 0, 0]) rotate ([0, 0, -90]) L_profile(base_platform_size[0], edge_1_width = 25, edge_2_width = 25, wall_thick = 3);

    
// first track    
    // first radial bearing housing
    translate ([first_tracks_offset, wheels_bearing_housing_1_offset_y, -rbearing_6005_enclosed_housing_size[2] - tracks_offset_z]) radial_bearing_housing_with_bearing_platform();
   
    // second radial bearing housing
    translate ([first_tracks_offset, wheels_bearing_housing_2_offset_y, -rbearing_6005_enclosed_housing_size[2] - tracks_offset_z]) radial_bearing_housing_with_bearing_platform();

// second track
    // first radial bearing housing
    translate ([first_tracks_offset + distance_between_tracks, wheels_bearing_housing_1_offset_y, -rbearing_6005_enclosed_housing_size[2] - tracks_offset_z]) radial_bearing_housing_with_bearing_platform();
   
    // second radial bearing housing
    translate ([first_tracks_offset + distance_between_tracks, wheels_bearing_housing_2_offset_y, -rbearing_6005_enclosed_housing_size[2] - tracks_offset_z]) radial_bearing_housing_with_bearing_platform();

// bearing housings

    translate ([0, base_platform_size[1], 0])
        mirror([0, 1, 0]){  
        // first radial bearing housing
            translate ([first_tracks_offset, wheels_bearing_housing_1_offset_y, -rbearing_6005_enclosed_housing_size[2] - tracks_offset_z]) radial_bearing_6005_vertical_housing(0);
   
    // second radial bearing housing
            translate ([first_tracks_offset, wheels_bearing_housing_2_offset_y, -rbearing_6005_enclosed_housing_size[2] - tracks_offset_z]) radial_bearing_6005_vertical_housing(0);
        
// second shaft
    // first radial bearing housing
            translate ([first_tracks_offset + distance_between_tracks, wheels_bearing_housing_1_offset_y, -rbearing_6005_enclosed_housing_size[2] - tracks_offset_z]) radial_bearing_housing_with_bearing_platform();
   
    // second radial bearing housing
            translate ([first_tracks_offset + distance_between_tracks, wheels_bearing_housing_2_offset_y, -rbearing_6005_enclosed_housing_size[2] - tracks_offset_z]) radial_bearing_housing_with_bearing_platform();
        }
        
// traction motors

// front
    translate ([motor_offset_x, motor_offset_y, 0]) rotate ([-90, 0, 0]) rotate ([0, 0, 90]) base_motor_with_housing();        

// back

    translate ([base_platform_size[0] - motor_offset_x + motor_gr_ep_45_housing_size[1], base_platform_size[1] - motor_offset_y, 0]) mirror ([0, 1, 0]) rotate ([-90, 0, 0]) rotate ([0, 0, 90]) base_motor_with_housing();       
//////////////////////////////////////////////////////
// tracks rotation motors
        translate([worm_gear_motor_with_pinion_offset, base_platform_size[1] - worm_GR_WM2_gear_box_size[2]  + wall_thick_3, base_platform_size[2] + worm_GR_WM2_gear_box_size[1] + wall_thick_3]) rotate ([-90, 0, 0]) worm_gear_motor_with_pinion();

// tracks
        
    translate ([first_tracks_offset, -track_width - tracks_offset_y, -rb_6005_external_radius - tracks_offset_z]) {
        rotate([0, front_tracks_angle, 0])
        rotate([0, 180, 0])
        track_with_move_gear();
    }

    translate([first_tracks_offset, base_platform_size[1] + tracks_offset_y + track_width, -rb_6005_external_radius - tracks_offset_z]){
        mirror([0, 1, 0])
        rotate([0, front_tracks_angle, 0])
        rotate([0, 180, 0])
        track_with_rotation_gear();
    }
    
// back side

    translate ([base_platform_size[0] - first_tracks_offset, -track_width - tracks_offset_y, -rb_6005_external_radius - tracks_offset_z]) {
        rotate([0, -back_tracks_angle, 0])
        track_with_rotation_gear();
    }
    translate([base_platform_size[0] - first_tracks_offset, base_platform_size[1] + tracks_offset_y + track_width, -rb_6005_external_radius - tracks_offset_z]){
        mirror([0, 1, 0])
        rotate([0, -back_tracks_angle, 0])
        track_with_move_gear();
    }

// belt for connecting front with back tracks
    translate ([first_tracks_offset, shaft_pulley_offset - (track_width + tracks_offset_y) + 10, -rb_6005_external_radius - tracks_offset_z]) 
        rotate ([-90, 0, 0]) 
            belt_on_2_pulleys(r1 = 20, r2 = 20, distance_between_pulleys = base_platform_size[0] - 2 * first_tracks_offset, belt_width = 6, belt_thick = 3);
// belt for connecting front with back tracks
    translate ([first_tracks_offset, base_platform_size[1] - (shaft_pulley_offset - (track_width + tracks_offset_y)) - 16, -rb_6005_external_radius - tracks_offset_z]) 
        rotate ([-90, 0, 0]) 
            belt_on_2_pulleys(r1 = 20, r2 = 20, distance_between_pulleys = base_platform_size[0] - 2 * first_tracks_offset, belt_width = 6, belt_thick = 3);
// tracks rotation motor
    translate([base_platform_size[0] - worm_gear_motor_with_pinion_offset, worm_GR_WM2_gear_box_size[2] - wall_thick_3, base_platform_size[2] + worm_GR_WM2_gear_box_size[1] + wall_thick_3]) rotate ([0, 180, 0]) rotate ([90, 0, 0]) worm_gear_motor_with_pinion();



    // laptop
   //    translate ([base_platform_size[0] - laptop13_size[1], laptop13_size[0] / 2 + base_platform_size[1] / 2, 65]) rotate ([0, 0, 0]) rotate ([0, 0, -90]) translate ([0, 0, base_platform_size[2]]) laptop13();

    // lidar

    translate([lidar_position, base_platform_size[1] / 2, base_platform_size[2]]) rotate([0, 0, 90]) tera_ranger_one_lidar();



// batteries

 //   translate([base_platform_size[0] - laptop13_size[1], 0, base_platform_size[2]]) multistar_4s_16000();
   // translate([base_platform_size[0] - laptop13_size[1], base_platform_size[1] - multistar_4s_16000_size[1], base_platform_size[2]]) multistar_4s_16000(); 
}
//--------------------------------------------------------------------


platform();

//track();


//platform_sheet(); 

//motor_gear();
//wheel_gear();

//second_wheel_with_shaft(num_tracks_per_circle, tracks_wheel_radius);

//first_wheel_with_shaft(num_tracks_per_circle, tracks_wheel_radius);

//base_motor_pulley();

//motor_housing_with_components();

//base_motor_with_housing();

//tracks_on_half_wheel(num_tracks_per_circle, tracks_wheel_radius);

//tracks_on_2_wheels(num_tracks_per_circle, tracks_wheel_radius, 200);

//string_of_tracks (10);

//wheel_traction_pulley();

//wheel_with_teeths(tracks_wheel_radius, num_tracks_per_circle);

//wheel_extension(tracks_wheel_radius, 12, 18, 6); // 4x

//wheel_extension(tracks_wheel_radius, 12, 18, 20); // 4x

//tracks_on_2_wheels(12, 42.5, 200);

//laptop_fixer_corner_left();

//laptop_fixer_corner_right();

//tracks_tensioner(); // 2x

//motor_gr_ep_45_housing_with_base_holes(); // 2x

//radial_bearing_housing_with_bearing();

//worm_gear_motor_with_pinion();
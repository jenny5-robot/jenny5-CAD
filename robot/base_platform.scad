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

include <params_tracks.scad>
use <tracks.scad>

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
//--------------------------------------------------------------------
module wheel_with_teeths(radius = 84, steps = 24)// radius = 42, steps = 12
{
    thick = 12;
    screw_length = radius - 24;
    angle_step = 360/steps;
    
	difference(){
      // traction teeth
      union(){
		color (plastic_color) cylinder (r = radius, h = thick, $fn = 100, center = true);
		for ( i = [0 : 1 : steps] )	
    			rotate([i * angle_step + 16, 90, 0])
                translate ([0, 0, radius - 0.1])
               color("red") cylinder(h = 8, r2 = 1.5, r1 = 5.5, $fn = 30, center = false);

      }
      // holes for saving material
	  for ( i = [0 : 1 : steps] )	
		rotate([2 * i * angle_step, 90, 0]){
          translate ([0, 0, radius - screw_length - 8]){
          hull(){
            translate ([thick / 2, 0, 0])         
                    cylinder(h = screw_length - 2, r1 = 4, r2 = 14, $fn = 6, center = false);
            translate ([-thick / 2, 0, 0])         
                    cylinder(h = screw_length - 2, r1 = 4, r2 = 14, $fn = 6, center = false);
                }
            }
        }

// 4 holes for fixing the part to the next ones	
		for ( i = [0 : 1 : 4] ){
			translate([(radius - 5) * sin(i * 90), (radius - 5) * cos(i * 90), 0] - display_tolerance_z) cylinder(h = thick + 2 * display_tolerance, r = 2, $fn = 30, center = true);
			//translate([(20) * sin(i*90+16), (20) * cos(i*90+16), 0]) cylinder(h=thick, r = 2, $fn = 20, center = true);
		}
        // gaura centru
        cylinder (r = 6, h = thick + 1, $fn = 100, center = true);
        translate ([0, 0, -thick / 2]) cylinder (r = M12_nut_radius, h = M12_nut_thick - 1, $fn = 6, center = false);
	}
}
//--------------------------------------------------------------------
module wheel_with_teeths_bearing(radius = 42.5, steps = 12, bearing_external_radius, bearing_thick)
{
    thick = 12;
    screw_length = 14;
    angle_step = 360/steps;
    
	difference(){
		union(){
		color (plastic_color) 
            cylinder (r = radius, h = thick, $fn = 100, center = true);
            
            // teeth
		for ( i = [0 : 1 : steps] )	
    			rotate([i * angle_step + 16, 90, 0])
                translate ([0, 0, radius - 0.5])
               color("red") cylinder(h = 8, r2 = 1.5, r1 = 5.5, $fn = 30, center = false);
      }
	
      if (radius > bearing_external_radius + 20){
            // holes for saving material
	  for ( i = [0 : 1 : steps] )	
		rotate([2 * i * angle_step, 90, 0]){
          translate ([0, 0, radius - screw_length - 8]){
          hull(){
            translate ([thick / 2, 0, 0])         
                    cylinder(h = screw_length - 2, r1 = 4, r2 = 14, $fn = 6, center = false);
            translate ([-thick / 2, 0, 0])         
                    cylinder(h = screw_length - 2, r1 = 4, r2 = 14, $fn = 6, center = false);
                }
            }
        }
    }
		for ( i = [0 : 1 : 4] ){
            // connection with extensions
			translate([(radius - 5) * sin(i * 90), (radius - 5) * cos(i * 90), 0]) cylinder(h = thick + 2 * display_tolerance, r = 2, $fn = 30, center = true);
            // fixing the bearing
			translate([(bearing_external_radius + 3) * sin(i * 90 + 45), (bearing_external_radius + 3) * cos(i * 90 + 45), 0]) cylinder(h = thick + 2 * display_tolerance, r = 2, $fn = 20, center = true);
		}
        // gaura centru
        translate(-display_tolerance_z) cylinder (r = bearing_external_radius - 2, h = thick, $fn = 100, center = true);
        translate ([0, 0, thick - bearing_thick]) cylinder (r = bearing_external_radius, h = thick, $fn = 100, center = true);
	}
}
//--------------------------------------------------------------------
module wheel_extension(radius = 42.5, _h = 8, thumb_thick = 5)
{
	difference(){
        union(){
            cylinder (r = radius, h = _h, $fn = 100);
            for (i = [0 : 3])
                translate([(radius - 5) * sin(i * 90), (radius - 5) * cos(i * 90), _h]) cylinder(h = thumb_thick, r = 5, $fn = 30);
        }
		translate (-display_tolerance_z) cylinder (r = radius - 10, h = _h + 2 * display_tolerance, $fn = 100);
		for (i = [0 : 3])
			translate([(radius - 5) * sin(i * 90), (radius - 5) * cos(i * 90), 0] - display_tolerance_z) cylinder(h = _h + thumb_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
	}
}
//--------------------------------------------------------------------
module wheel_traction_pulley()
{
  difference(){
      color (plastic_color)
     union(){
         
       pulley_with_shaft(profile = 56, num_teeth = 44, pulley_b_ht = 0, pulley_b_dia = 0, pulley_t_ht = 8, shaft_radius = 6, nut_radius = 0, nut_height = 0);
         
          cylinder (h = 20, r = 18);
     }
     //  fi 12 hole
     cylinder (h = 12, r = 6, $fn = 50);
     // M12 nut hole
     translate ([0, 0, 6]) cylinder (h = 20, r = M12_nut_radius, $fn = 6);
  }
}
//--------------------------------------------------------------------
module tracks_on_half_wheel(num_tracks_per_circle, wheel_radius, start_angle = 0)
{
    step = 360 / num_tracks_per_circle;
    
    tracks_on_circle(num_tracks_per_circle, wheel_radius, start_angle, num_tracks_per_circle / 2 + 1);
}
//--------------------------------------------------------------------
module traction_wheel(num_tracks_per_circle, wheel_radius)
{
    space_between_wheels = 23;
    // screw axis
    translate ([0, 0, -6]) 
      M12_hexa(140);
    // traction wheel
    wheel_with_teeths(wheel_radius, num_tracks_per_circle);
    // bottom extension wheel
    translate ([0, 0, -6 -8 -space_between_wheels])
    wheel_extension(wheel_radius, 8, 5);
    // top extension wheel
    translate ([0, 0, 6 + 8 + space_between_wheels])
    mirror([0, 0, 1])
    wheel_extension(wheel_radius, 8, 5);
    
    // screws for glueing plastic parts
    
    for (i = [0 : 3]){
      translate([(wheel_radius - 5) * sin(i * 90), (wheel_radius - 5) * cos(i * 90), -6 - 8 - space_between_wheels - m4_nut_thick]) M4_hexa(80);
      translate([(wheel_radius - 5) * sin(i * 90), (wheel_radius - 5) * cos(i * 90), 6 + 8 + space_between_wheels]) M4_autolock_nut();
    }
    
    // spacer
    translate ([0, 0, 6])
    M12_washer();
    // nut
    translate ([0, 0, 6 + washer_12_thick]) M12_nut();
    // long nut
   translate ([0, 0, 6 + washer_12_thick]) M12_long_nut();
    // traction pulley
    translate ([0, 0, 6 + washer_12_thick + M12_long_long_nut_thick - 2 + 14]) mirror ([0, 0, 1]) wheel_traction_pulley();
// washer
    translate ([0, 0, 6 + washer_12_thick + M12_long_nut_thick - 2 + 14])
    M12_washer();
    // autolock nut
    translate ([0, 0, 6 + washer_12_thick + M12_long_nut_thick + 12]) M12_autolock_nut();
}
//--------------------------------------------------------------------
module tracks_on_2_wheels(num_tracks_per_half_circle, wheel_radius, distance_between_wheels)
{
    rotate ([90, 0, 0]) tracks_on_half_wheel(num_tracks_per_half_circle, wheel_radius);
    translate ([-distance_between_wheels, 0, 0]) mirror([1, 0, 0]) rotate ([90, 0, 0]) tracks_on_half_wheel(num_tracks_per_half_circle, wheel_radius);
    
    translate ([-distance_between_wheels - 12, -track_size[0] / 2, -wheel_radius - track_size[2]]) string_of_tracks(9);
    translate ([-distance_between_wheels - 12, -track_size[0] / 2, wheel_radius + track_size[2]]) mirror([0, 0, 1]) string_of_tracks(9);
}
//--------------------------------------------------------------------
module second_gear()
{
  // screw axis
    translate ([0, 0, 6 - M12_nut_thick - rb_6001_thick]) 
      M12_hexa(150);
    // ear
    wheel_with_teeths_bearing(tracks_wheel_radius, num_tracks_per_circle, rb_6001_external_radius, rb_6001_thick);
    // bottom extension wheel
    translate ([0, 0, -6 - 8 - 5])
    wheel_extension(tracks_wheel_radius, 8, 5);
    // top extension wheel
    translate ([0, 0, 6 + 8 + 5])
    mirror([0, 0, 1])
    wheel_extension(tracks_wheel_radius, 8, 5);
    
    // screws for glueing plastic parts
    
    for (i = [0 : 3]){
      translate([(tracks_wheel_radius - 5) * sin(i * 90), (tracks_wheel_radius - 5) * cos(i * 90), -6-8-5-m4_nut_thick]) M4x45_hexa();
      translate([(tracks_wheel_radius - 5) * sin(i * 90), (tracks_wheel_radius - 5) * cos(i * 90), +6+8+5]) M4_autolock_nut();
    }
    
    translate ([0, 0, 6 - rb_6001_thick]) 
    6001rs();
    // spacer
    translate ([0, 0, 6])
    M12_washer();
    // long nut
    translate ([0, 0, 6 + washer_12_thick])
    M12_long_nut();
// washer
    translate ([0, 0, 6 + washer_12_thick + M12_long_nut_thick])
    M12_nut();
    // nut
    translate ([0, 0, 6 + washer_12_thick + M12_long_nut_thick + M12_nut_thick])
    M12_nut();
    translate ([0, 0, 6 + washer_12_thick + M12_long_nut_thick + 2 * M12_nut_thick])
    M12_washer();
}
//--------------------------------------------------------------------
module base_motor_housing_left()
{
    motor_gr_ep_45_housing_with_belt_tensioner_bearing_based_y_and_base_holes(15, 0, 0);
}
//--------------------------------------------------------------------
module base_motor_housing_right()
{
    motor_gr_ep_45_housing_with_belt_tensioner_bearing_based_y_and_base_holes(15, 0, 1);
}
//--------------------------------------------------------------------
module base_motor_with_housing_left()
{
    motor_gr_ep_45_housing_with_belt_tensioner_bearing_based_y_and_base_holes(15, 0, 0);
    translate ([nema_17_width / 2 + 3 + 2, nema_17_width / 2 + 3 + 15, motor_gr_ep_45_length + 3]) mirror([0, 0, 1]) motor_gr_ep_45();
}
//--------------------------------------------------------------------
module base_motor_with_housing_right()
{
    motor_gr_ep_45_housing_with_belt_tensioner_bearing_based_y_and_base_holes(15, 0, 1);
    translate ([nema_17_width / 2 + 3 + 2, nema_17_width / 2 + 3 + 15, motor_gr_ep_45_length + 3]) mirror([0, 0, 1]) motor_gr_ep_45();
}
//--------------------------------------------------------------------
module platform_sheet()
{
  difference(){    
    cube(base_platform_size);
    // holes for
    // first gear, bearing with flaps
    translate ([10, 10, 0] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
    
    // first gear, bearing with flaps
    translate ([30, 10, 0] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);

    // second gear, first bearing
    for (i=[0:1]){
    translate ([second_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_1_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        echo("1st holes second shaft",  [second_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_1_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i]);
    }
    // second gear, second bearing
       for (i=[0:1]){
    translate ([second_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_2_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        echo("2nd holes second shaft",  [second_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_2_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i]);
    }
    // third gear, first bearing
    for (i=[0:1]){
    translate ([second_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2 + distance_between_wheels, wheels_bearing_housing_1_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        echo("1st holes third shaft",  [second_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2 + distance_between_wheels, wheels_bearing_housing_1_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i]);
    }
    
        // holes for fixing the bone to the platform
        for (i=[0:3])
            translate (foot_spacer_holes[i] + [135, base_platform_size[1] / 2, 0] - display_tolerance_z) cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m8_screw_radius, $fn = 30);
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
module base_motor_pulley()
{  
  pulley_t_ht = 8;	// length of toothed part of pulley
  pulley_base_height = 1.5;
  difference(){    
    rotate ([0, 0, 10.8]) pulley_with_shaft(62, 15, 0, 0, 8, 5, 0, 0);
        
        // M4 screws
        
    translate ([0, 0, pulley_t_ht / 2 + pulley_base_height]) rotate ([-90, 0, 0]) cylinder (h = 40, r = m4_screw_radius, $fn = 25);
        
        // M4 nut
    translate ([0, 3.6, pulley_t_ht / 2 + pulley_base_height]) rotate ([-90, 30, 0]) cylinder (h = m4_nut_thick + 0.2 + 1.4, r = m4_nut_radius + 0.1, $fn = 6);
  }
}
//--------------------------------------------------------------------
module platform()
{
  platform_sheet();

  // motor right
    
  translate ([leg_postion_on_platform + 10, base_platform_size[1], base_platform_size[2]]) 
    rotate([90, 0, 0])
      rotate([0, 0, 90]) 
        base_motor_with_housing_right();
    
    // motor left
  translate ([leg_postion_on_platform - motor_gr_ep_45_housing_size[1] + 10, 0, base_platform_size[2]])
    //rotate([0, 0, 180])
      rotate([-90, 0, 0])
        rotate([0, 0, -90]) 
          base_motor_with_housing_left();
    
// second shaft    
    // first radial bearing housing
    translate ([second_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_1_offset_y, -rbearing_6201_enclosed_housing_size[2]]) radial_bearing_6201_vertical_housing(0);
   
    // second radial bearing housing
    translate ([second_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_2_offset_y, -rbearing_6201_enclosed_housing_size[2]]) radial_bearing_6201_vertical_housing(0);

// traction shaft
    // first radial bearing housing
    translate ([second_tracks_offset + distance_between_wheels - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_1_offset_y, -rbearing_6201_enclosed_housing_size[2]]) radial_bearing_6201_vertical_housing(0);
   
    // second radial bearing housing
    translate ([second_tracks_offset + distance_between_wheels - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_2_offset_y, -rbearing_6201_enclosed_housing_size[2]]) radial_bearing_6201_vertical_housing(0);

// gears
    left_tracks_offset = -5;
    translate ([0, -track_size[0] / 2 - 15, 0]) {
            
    //second gear
        translate ([second_tracks_offset, left_tracks_offset, -rb_6001_external_radius]) rotate([-90, 0, 0]) second_gear();
    
    //traction gear
        translate ([second_tracks_offset + distance_between_wheels, left_tracks_offset, -rb_6201_external_radius]) rotate([-90, 0, 0]) traction_wheel(num_tracks_per_circle, tracks_wheel_radius);

        //tracks
    translate ([200 + second_tracks_offset, left_tracks_offset, -rb_6201_external_radius]) 
        tracks_on_2_wheels(num_tracks_per_circle, tracks_wheel_radius, distance_between_wheels);
        //tracks_on_3_wheels(num_tracks_per_half_circle = [5, 16, 16], wheels_radius = [20, 58.8, 58.8], wheels_position = [[-100, 0], [0, 0], [distance_between_wheels, 0]]);
    }

// belt    
    
    distance_between_motor_and_traction_wheel = sqrt((motor_gr_ep_45_radius + 3 + 3 + base_platform_size[2] + rb_6201_external_radius)*(motor_gr_ep_45_radius + 3 + 3 + base_platform_size[2] + rb_6201_external_radius) + (second_tracks_offset + distance_between_wheels- leg_postion_on_platform + motor_gr_ep_45_housing_size[1] / 2 - 5) * (second_tracks_offset + distance_between_wheels- leg_postion_on_platform + motor_gr_ep_45_housing_size[1] / 2 - 5));
    // 
    
    translate ([second_tracks_offset + distance_between_wheels, left_tracks_offset, -rb_6201_external_radius]) rotate ([0, -155, 0]) rotate ([90, 0, 0]) belt_on_2_pulleys(35, 10, distance_between_motor_and_traction_wheel);
    


// other side

    right_tracks_offset = 5;
  
    translate([0, base_platform_size[1] + track_size[0] / 2 + 15, 0]){
    // second gear
        translate ([second_tracks_offset, right_tracks_offset, -rb_6201_external_radius]) rotate([90, 0, 0]) second_gear();
    // traction gear
        translate ([second_tracks_offset + distance_between_wheels, right_tracks_offset, -rb_6001_external_radius]) mirror([0, 1, 0]) rotate([-90, 0, 0]) traction_wheel(num_tracks_per_circle, tracks_wheel_radius);

    //tracks
    translate ([distance_between_wheels + second_tracks_offset, right_tracks_offset, -rb_6201_external_radius]) 
        tracks_on_2_wheels(num_tracks_per_circle, tracks_wheel_radius, distance_between_wheels);
      // belt
    translate ([second_tracks_offset + distance_between_wheels, right_tracks_offset - 47, -rb_6201_external_radius]) rotate ([0, -155, 0]) rotate ([90, 0, 0]) belt_on_2_pulleys(35, 10, distance_between_motor_and_traction_wheel);
    
}
    // back wheel
    
    translate ([base_platform_size[0] + 100, base_platform_size[1]/2, -rb_6201_external_radius - tracks_wheel_radius - track_size[2] + chair_wheel_radius]) rotate ([0, 0, 90]) chair_wheel();
    
    // laptop
    translate ([base_platform_size[0] - laptop13_size[1], laptop13_size[0] / 2 + base_platform_size[1] / 2, 110]) rotate ([0, 15, 0]) rotate ([0, 0, -90]) translate ([0, 0, base_platform_size[2]]) laptop13();

    // lidar

    translate([50, base_platform_size[1] / 2, base_platform_size[2]]) rotate([0, 0, 90]) tera_ranger_one_lidar();

// battery
  //  translate([160, multistar_4s_20000_size[2], base_platform_size[2]]) rotate ([90, 0, 0]) multistar_4s_20000();
}
//--------------------------------------------------------------------


platform();

distance_between_wheels = 200;

//tracks_on_3_wheels(num_tracks_per_half_circle = 16, wheels_radius = [58.8, 58.8, 20], wheels_position = [[0, 0], [distance_between_wheels, 0], [distance_between_wheels / distance_between_wheels, distance_between_wheels]]);

//base_motor_housing_left(); // 1x
//base_motor_housing_right(); // 1x

//platform_sheet(); 

//base_motor_pulley();

//motor_housing_with_components();

//base_motor_with_housing();

//tracks_on_half_wheel(num_tracks_per_circle, tracks_wheel_radius);

//first_gear();

//second_gear(num_tracks_per_circle, tracks_wheel_radius);

//tracks_on_2_wheels(num_tracks_per_circle, tracks_wheel_radius, 200);

//string_of_tracks (10);

//wheel_traction_pulley();

//wheel_with_teeths_bearing();

//rotate([0, 0, 16]) wheel_with_teeths(tracks_wheel_radius, num_tracks_per_circle);

//wheel_extension(42.5, 12);

//wheel_extension(22, 12, 5);

//traction_wheel(num_tracks_per_circle, tracks_wheel_radius);

//tracks_on_2_wheels(12, 42.5, 200);

//laptop_fixer_corner_left();

//laptop_fixer_corner_right();

//tracks_tensioner(); // 2x
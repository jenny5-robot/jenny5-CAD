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
       my_pulley(56, 44, 0, 18, 8, 0);
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
    // screw axis
    translate ([0, 0, -6]) 
      M12_hexa(150);
    // traction wheel
    wheel_with_teeths(wheel_radius, num_tracks_per_circle);
    // bottom extension wheel
    translate ([0, 0, -6 -8 -5])
    wheel_extension(wheel_radius, 8, 5);
    // top extension wheel
    translate ([0, 0, 6+8+5])
    mirror([0, 0, 1])
    wheel_extension(wheel_radius, 8, 5);
    
    // screws for glueing plastic parts
    
    for (i = [0 : 3]){
      translate([(wheel_radius - 5) * sin(i * 90), (wheel_radius - 5) * cos(i * 90), -6 - 8 - 5 - m4_nut_thick]) M4x45_hexa();
      translate([(wheel_radius - 5) * sin(i * 90), (wheel_radius - 5) * cos(i * 90), 6 + 8 + 5]) M4_autolock_nut();
    }
    
    // spacer
    translate ([0, 0, 6])
    M12_washer();
    // long nut
    M12_long_nut();
    // traction pulley
    translate ([0, 0, 6 + washer_12_thick + M12_long_nut_thick - 2])
    mirror ([0, 0, 1]) wheel_traction_pulley();
// washer
    translate ([0, 0, 6 + washer_12_thick + M12_long_nut_thick - 2])
    M12_washer();
    // autolock nut
    translate ([0, 0, 6 + washer_12_thick + M12_long_nut_thick])
    M12_autolock_nut();
}
//--------------------------------------------------------------------
module tracks_on_2_wheels(num_tracks_per_half_circle, wheel_radius, distance_between_wheels)
{
    rotate ([90, 0, 0]) tracks_on_half_wheel(num_tracks_per_half_circle, wheel_radius);
    translate ([-distance_between_wheels, 0, 0]) mirror([1, 0, 0]) rotate ([90, 0, 0]) tracks_on_half_wheel(num_tracks_per_half_circle, wheel_radius);
    
    translate ([-distance_between_wheels - 12, -track_size[0] / 2, -wheel_radius - track_size[2]]) string_of_tracks(8);
    translate ([-distance_between_wheels - 12, -track_size[0] / 2, wheel_radius + track_size[2]]) mirror([0, 0, 1]) string_of_tracks(8);
}
//--------------------------------------------------------------------
module first_gear()
{
    wheel_with_teeths_bearing(22, 7, rb_608_external_radius, rb_608_thick);
}
//--------------------------------------------------------------------
module second_gear()
{
    num_tracks_per_circle = 12;
    wheel_radius = 42.5;

  // screw axis
    translate ([0, 0, 6 - M12_nut_thick - rb_6001_thick]) 
      M12_hexa(150);
    // ear
    wheel_with_teeths_bearing(42.5, 12, rb_6001_external_radius, rb_6001_thick);
    // bottom extension wheel
    translate ([0, 0, -6 - 8 - 5])
    wheel_extension(wheel_radius, 8, 5);
    // top extension wheel
    translate ([0, 0, 6 + 8 + 5])
    mirror([0, 0, 1])
    wheel_extension(wheel_radius, 8, 5);
    
    // screws for glueing plastic parts
    
    for (i = [0 : 3]){
      translate([(wheel_radius - 5) * sin(i * 90), (wheel_radius - 5) * cos(i * 90), -6-8-5-m4_nut_thick]) M4x45_hexa();
      translate([(wheel_radius - 5) * sin(i * 90), (wheel_radius - 5) * cos(i * 90), +6+8+5]) M4_autolock_nut();
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
module base_motor_with_support()
{
    nema_23_motor_housing();
    translate ([nema_23_57BYGH603_width / 2 + 5 + 10, nema_23_57BYGH603_width / 2 + 3, nema_23_57BYGH603_height + 3]) mirror([0, 0, 1]) nema_23_57BYGH603();
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
module platform()
{

  platform_sheet();

    // motor left
    translate ([70, 0, base_platform_size[2]]) 
    rotate([-90, 0, 0])
    rotate([0, 0, -90]) 
    base_motor_with_support();
    
// belt tensioner left
    translate ([130, 0, base_platform_size[2]]) 
    belt_tensioner(30, 0);
    
    // motor right
    translate ([70, base_platform_size[1], base_platform_size[2]])
    mirror([0, 1, 0]) 
    rotate([-90, 0, 0])
    rotate([0, 0, -90]) 
    base_motor_with_support();
    

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
    translate ([0, -track_size[0] / 2 - 15, 0]) {
    
        //first gear
        translate ([first_tracks_offset, 0, base_platform_size[2] / 2]) rotate([-90, 0, 0]) first_gear();
        
    //traction gear
        translate ([second_tracks_offset + distance_between_wheels, 0, -rb_6201_external_radius]) rotate([-90, 0, 0]) traction_wheel(12, 42.5);

    //third gear
        translate ([second_tracks_offset, 0, -rb_6001_external_radius]) rotate([-90, 0, 0]) second_gear();
    
        //tracks
 //       translate ([200 + second_tracks_offset, 0, -rb_6201_external_radius]) tracks_on_2_wheels(12, 42.5, 200);
    }

// belt    
    translate ([second_tracks_offset + distance_between_wheels, -5, -rb_6201_external_radius]) rotate ([0, -154, 0]) rotate ([90, 0, 0]) belt_on_2_pulleys(35, 10, sqrt(31000));

// other side
  translate([0, base_platform_size[1] + track_size[0] / 2 + 15, 0]){
     //first gears
        translate ([first_tracks_offset, 0, base_platform_size[2] / 2]) rotate([-90, 0, 0]) mirror([0, 1, 0]) first_gear();
// second gear
    translate ([second_tracks_offset, 0, -rb_6201_external_radius]) rotate([90, 0, 0]) second_gear();
// traction gear
    translate ([second_tracks_offset + distance_between_wheels, 0, -rb_6001_external_radius]) mirror([0, 1, 0]) rotate([-90, 0, 0]) traction_wheel(12, 42.5);

    //tracks
    //translate ([200 + second_tracks_offset, 0, -rb_6201_external_radius]) tracks_on_2_wheels(12, 42.5, 200);
    
}
translate([-rb_608_external_radius - 7, 12 + 4, 9])
rotate([90, 0, 0]) 
        rotate([0, 0, -90])
        bearing_housing_with_flaps(18, rb_608_external_radius, rb_608_thick);

    // first shaft
    translate ([first_tracks_offset, -track_size[0] - 10, base_platform_size[2] / 2]) rotate([-90, 0, 0]) cylinder (h = 390, r = 6, $fn = 20);

    // second shaft
  //  translate ([second_tracks_offset, -track_size[0] - 10, -rb_6001_external_radius]) rotate([-90, 0, 0]) cylinder (h = 390, r = 6, $fn = 20);
    
    // chair wheels
    
    translate ([base_platform_size[0] - 30, 30, -(chair_wheel_height - chair_wheel_radius + 5)]) rotate ([0, 0, 90]) chair_wheel();
    translate ([base_platform_size[0] - 30, base_platform_size[1] - 30, -(chair_wheel_height - chair_wheel_radius + 5)]) rotate ([0, 0, 90]) chair_wheel();
    
    // laptop
    translate ([base_platform_size[0] - laptop13_size[1], laptop13_size[0] / 2 + base_platform_size[1] / 2, 0]) rotate ([0, 0, -90]) translate ([0, 0, base_platform_size[2]]) laptop13();

    // lidar

    translate([50, base_platform_size[1] / 2, base_platform_size[2]]) rotate([0, 0, 90]) tera_ranger_one_lidar();

// battery
    translate([160, multistar_4s_20000_size[2], base_platform_size[2]]) rotate ([90, 0, 0]) multistar_4s_20000();
}
//--------------------------------------------------------------------
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


platform();

//platform_sheet();

//base_motor_with_support();

//tracks_on_half_wheel(12, 42.5);

//first_gear();

//second_gear(12, 42.5);

//tracks_on_2_wheels(12, 42.5, 200);

//string_of_tracks (10);

//tracks_on_half_wheel(12, 42.5);

//wheel_traction_pulley();

//wheel_with_teeths_bearing();

//wheel_with_teeths(42.5, 12);

//wheel_extension(42.5, 12);

//wheel_extension(22, 12, 5);

//traction_wheel(12, 42.5);

//tracks_on_2_wheels(12, 42.5, 200);

//laptop_fixer_corner_left();

//laptop_fixer_corner_right();
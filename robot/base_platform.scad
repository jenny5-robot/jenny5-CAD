// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_radial_bearings.scad>
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

//--------------------------------------------------------------------
module wheel_with_teeths_simple(radius = 84, steps = 24)// radius = 42, steps = 12
{
    thick = 15;
    screw_length = radius - 29;
    angle_step = 360/steps;
    
	difference(){
      // traction teeth
      union(){
		color (plastic_color) cylinder (r = radius, h = thick, $fn = 100, center = true);
		for ( i = [0 : 1 : steps] )	
    			rotate([i * angle_step + 16, 90, 0])
                translate ([0, 0, radius - 1])
               color("red") cylinder(h = 5, r2 = 1, r1 = 3, $fn = 30, center = false);

      }
      
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
			translate([(radius - 5) * sin(i * 90 + 16), (radius - 5) * cos(i * 90 + 16), 0]) cylinder(h = thick, r = 2, $fn = 30, center = true);
			//translate([(20) * sin(i*90+16), (20) * cos(i*90+16), 0]) cylinder(h=thick, r = 2, $fn = 20, center = true);
		}
        // gaura centru
        cylinder (r = 6, h = thick + 1, $fn = 100, center = true);
        translate ([0, 0, -thick / 2]) cylinder (r = m12_nut_radius, h = m12_nut_thick, $fn = 6, center = false);
	}
}
//--------------------------------------------------------------------
module wheel_with_teeths_bearing()
{
    thick = 10;
    screw_length = 16;
    
	difference(){
		cylinder (r = radius, h = thick, $fn = 100, center = true);
		for ( i = [0 : 1 : steps] )	
            
			rotate([i*angle_step, 90, 0]){
                translate ([0, 0, radius - 10])
                cylinder(h=10, r = 2.1, $fn = 30, center = false);
                translate ([0, 0, radius - screw_length - 4]){
                    cylinder(h=screw_length, r = 4, $fn = 6, center = false);
                hull(){
            translate ([thick/2, 0, 0])         
                    cylinder(h=screw_length - 2, r = 4, $fn = 6, center = false);
            translate ([-thick/2, 0, 0])         
                    cylinder(h=screw_length - 2, r = 4, $fn = 6, center = false);
                }
            }
            }
	
		for ( i = [0 : 1 : 4] ){
			translate([(radius-5) * sin(i*90+16), (radius-5) * cos(i*90+16), 0]) cylinder(h=thick, r = 2, $fn = 30, center = true);
			translate([(17) * sin(i*90+16), (17) * cos(i*90+16), 0]) cylinder(h=thick, r = 2, $fn = 20, center = true);
		}
        // gaura centru
        cylinder (r = rb_6001_external_radius - 2, h = thick, $fn = 100, center = true);
        translate ([0, 0, 2]) cylinder (r = rb_6001_external_radius, h = thick, $fn = 100, center = true);
	}
}
//--------------------------------------------------------------------
module ring(radius = 84)
{
	difference(){
		cylinder (r = radius, h = 8, $fn = 100, center = true);
		cylinder (r = radius - 10, h = 8, $fn = 100,center = true);
		for ( i = [0 : 1 : 4] ){
			translate([(radius-5) * sin(i*90+16), (radius-5) * cos(i*90+16), 0]) cylinder(h=8, r = m4_screw_radius, $fn = 30, center = true);
		//	translate([(radius-5) * sin(i*90+16), (radius-5) * cos(i*90+16), 0]) cylinder(h=4, r = m4_nut_radius, $fn = 6, center = false);
		}
	}
}
//--------------------------------------------------------------------
module full_wheel()
{
	difference(){		
		cylinder (r = radius, h = 8, $fn = 100, center = true);
		translate ([0,0,2]) cylinder (r = radius - 10, h = 4, $fn = 100,center = true);
		cylinder (r = 13, h = 8, $fn = 100,center = true);
		for ( i = [0 : 1 : 4] ){
			translate([(radius-5) * sin(i*90+16), (radius-5) * cos(i*90+16), 0]) cylinder(h=8, r = 2, $fn = 30, center = true);
			translate([(radius-5) * sin(i*90+16), (radius-5) * cos(i*90+16), 0]) cylinder(h=4, r = nut_radius, $fn = 30, center = false);
		}
		for ( i = [0 : 1 : 4] ){
			translate([20 * sin(i*90), 20 * cos(i*90), 0]) cylinder(h=8, r = 2, $fn = 30, center = true);
//			translate([20 * sin(i*90), 20 * cos(i*90), 0]) cylinder(h=4, r = nut_radius, $fn = 30, center = false);
		}
	}
}
//--------------------------------------------------------------------
module bearing_support()
{
	difference(){		
		cylinder (r = 25, h = 12, $fn = 100, center = true);
		translate([0,0,1])cylinder (r = 16.2, h = 10, $fn = 100, center = true);
		cylinder (r = 13, h = 12, $fn = 100, center = true);
		for ( i = [0 : 1 : 4] ){
			translate([20 * sin(i*90), 20 * cos(i*90), 0]) cylinder(h=12, r = 2, $fn = 30, center = true);
			translate([20 * sin(i*90), 20 * cos(i*90),-6]) cylinder(h=3, r = nut_radius, $fn = 6, center = false);
		}
		
	}
}
//--------------------------------------------------------------------
module m12_screw_support()
{
	difference(){		
		cylinder (r = 25, h = 8, $fn = 100, center = true);
		cylinder (r = 6, h = 8, $fn = 100, center = true);
		translate ([0,0,-1]) cylinder (r = 11, h = 5, $fn = 6, center = false);
		for ( i = [0 : 1 : 4] ){
			translate([20 * sin(i*90), 20 * cos(i*90), 0]) cylinder(h=8, r = 2, $fn = 30, center = true);
			translate([20 * sin(i*90), 20 * cos(i*90), 1]) cylinder(h=3, r = m4_nut_radius, $fn = 6, center = false);
		}
		
	}
}
//--------------------------------------------------------------------
module wheel_traction_pulley()
{
    difference(){
        
        my_pulley(20, 101, 0, 0, 0, 0);
        // gaura fi 12
        cylinder (h = 10, r = 6, $fn = 50);
        // surub M3
        
        translate ([0, 0, 5]) rotate ([-90, 0, 0]) cylinder (h = 40, r = 1.5, $fn = 20);
        // gaura cap surub M3
        translate ([0, 20, 4.5]) rotate ([-90, 0, 0]) cylinder (h = 40, r = m3_nut_radius, $fn = 20);
        
        // gaura piulitza M3
        hull(){
            translate ([0, 10, 0]) rotate ([-90, 30, 0]) cylinder (h = m3_nut_thick, r = m3_nut_radius, $fn = 6);
            translate ([0, 10, 9]) rotate ([-90, 30, 0]) cylinder (h = m3_nut_thick, r = m3_nut_radius, $fn = 6);
        }
    }
}
//--------------------------------------------------------------------
module wheel_pulley()
{
    difference(){
        
        my_pulley(17, 20, 0, 0, 0, 0);
        // gaura fi 12
        cylinder (h = 10, r = 6, $fn = 50);
        // surub M3
        
        translate ([0, 0, 5]) rotate ([-90, 0, 0]) cylinder (h = 40, r = 1.5, $fn = 20);
        // gaura cap surub M3
        translate ([0, 20, 4.5]) rotate ([-90, 0, 0]) cylinder (h = 40, r = m3_nut_radius, $fn = 20);
        
        // gaura piulitza M3
        hull(){
            translate ([0, 10, 0]) rotate ([-90, 30, 0]) cylinder (h = m3_nut_thick, r = m3_nut_radius, $fn = 6);
            translate ([0, 10, 9]) rotate ([-90, 30, 0]) cylinder (h = m3_nut_thick, r = m3_nut_radius, $fn = 6);
        }
        
    }
}
//--------------------------------------------------------------------
module tracks_on_half_wheel(num_tracks_per_half_circle, wheel_radius, start_angle = 0)
{
    step = 360 / num_tracks_per_half_circle;
    
    tracks_on_half_circle(num_tracks_per_half_circle, wheel_radius, start_angle);
    rotate ([0, 0, step / 2])  wheel_with_teeths_simple(wheel_radius, num_tracks_per_half_circle);
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
module first_gear_tracks()
{
    wheel_with_teeths_simple(30.3, 9);
}
//--------------------------------------------------------------------
module platform()
{
    cube(base_platform_size);
    
    fist_tracks_offset = -rb_608_external_radius;
    second_tracks_offset = 70;
    distance_between_wheels = 200;
    
    //tracks
 //   translate([distance_between_wheels + tracks_offset, -track_size[0] / 2 - 10, -rb_6001_external_radius]) tracks_on_2_wheels(12, 42.5, distance_between_wheels);
 //   translate([distance_between_wheels + tracks_offset, base_platform_size[1] + track_size[0] / 2 + 10, -rb_6001_external_radius]) tracks_on_2_wheels(12, 42.5, distance_between_wheels);
   
    translate([0, -track_size[0] / 2 - 10, 0]){
    //first gears
        translate ([fist_tracks_offset, 0, base_platform_size[2] / 2]) rotate([-90, 0, 0]) first_gear_tracks();
    
    //second gears
        translate ([second_tracks_offset, 0, -rb_6001_external_radius]) rotate([-90, 0, 0]) wheel_with_teeths_simple(42.5, 12);

    //third gears
        translate ([second_tracks_offset + distance_between_wheels, 0, -rb_6001_external_radius]) rotate([-90, 0, 0]) wheel_with_teeths_simple(42.5, 12);
    
    //tracks
// front gear    
        translate ([fist_tracks_offset, 0, base_platform_size[2] / 2]) rotate([-90, 0, 0])tracks_on_circle(9, 30.3, 180, 4);
// last gear
        translate ([second_tracks_offset + distance_between_wheels, 0, -rb_6001_external_radius]) rotate([-90, 0, 0]) tracks_on_circle(12, 42.5, 0, 7);

//top string of tracks
        translate ([0, -track_size[0] / 2, 45 + track_size[2]]) rotate ([0, 4, 0]) mirror ([0, 0, 1]) string_of_tracks(10);
// bottom tracks
        translate ([57, -track_size[0] / 2, -rb_6001_external_radius - track_size[2] - 42.5]) string_of_tracks(8);
// front tracks
        translate ([-32, -track_size[0] / 2, -10]) rotate ([0, 27, 0]) mirror ([0, 0, 1]) string_of_tracks(4);
    }
// other side
translate([0, base_platform_size[1] + track_size[0] / 2 + 10, 0]){
// first gear
    translate ([fist_tracks_offset, 0, base_platform_size[2] / 2]) rotate([-90, 0, 0]) first_gear_tracks();
// second gear
    translate ([second_tracks_offset, 0, -rb_6001_external_radius]) rotate([-90, 0, 0]) wheel_with_teeths_simple(42.5, 12);
// third gear
    translate ([second_tracks_offset + distance_between_wheels, 0, -rb_6001_external_radius]) rotate([-90, 0, 0]) wheel_with_teeths_simple(42.5, 12);
    //tracks
// front gear    
        translate ([fist_tracks_offset, 0, base_platform_size[2] / 2]) rotate([-90, 0, 0])tracks_on_circle(9, 30.3, 180, 4);
// last gear
        translate ([second_tracks_offset + distance_between_wheels, 0, -rb_6001_external_radius]) rotate([-90, 0, 0]) tracks_on_circle(12, 42.5, 0, 7);

//top string of tracks
        translate ([0, -track_size[0] / 2, 45 + track_size[2]]) rotate ([0, 4, 0]) mirror ([0, 0, 1]) string_of_tracks(10);
// bottom tracks
        translate ([57, -track_size[0] / 2, -rb_6001_external_radius - track_size[2] - 42.5]) string_of_tracks(8);
// front tracks
        translate ([-32, -track_size[0] / 2, -10]) rotate ([0, 27, 0]) mirror ([0, 0, 1]) string_of_tracks(4);
    
}
    // shafts
    translate ([fist_tracks_offset, -track_size[0] - 10, base_platform_size[2] / 2]) rotate([-90, 0, 0]) cylinder (h = 390, r = 6, $fn = 20);
    translate ([second_tracks_offset, -track_size[0] - 10, -rb_6001_external_radius]) rotate([-90, 0, 0]) cylinder (h = 390, r = 6, $fn = 20);
    translate ([distance_between_wheels + second_tracks_offset, -track_size[0] - 10, -rb_6001_external_radius]) rotate([-90, 0, 0]) cylinder (h = 390, r = 6, $fn = 20);
    
    // chair wheels
    
    translate ([base_platform_size[0] - 30, 30, -(chair_wheel_height - chair_wheel_radius + 5)]) rotate ([0, 0, 90]) chair_wheel();
    translate ([base_platform_size[0] - 30, base_platform_size[1] - 30, -(chair_wheel_height - chair_wheel_radius + 5)]) rotate ([0, 0, 90]) chair_wheel();
    
    // laptop
    translate ([base_platform_size[0] - laptop13_size[1], laptop13_size[0] / 2 + base_platform_size[1] / 2, 0]) rotate ([0, 0, -90]) translate ([0, 0, base_platform_size[2]]) laptop13();
}
//--------------------------------------------------------------------
//tracks_on_half_wheel(12, 42.5);

//first_gear_tracks();

platform();

//tracks_on_2_wheels(12, 42.5, 200);

//string_of_tracks (10);

//platform();

//tracks_on_half_wheel(42.5);

//wheel_pulley();

//wheel_with_teeths_bearing();

//wheel_with_teeths_simple(42, 12);
//wheel_with_teeths_simple(84, 24);
//wheel_with_teeths_simple(75, 20);

//ring(75);

//full_wheel();

//bearing_support();

//m12_screw_support();
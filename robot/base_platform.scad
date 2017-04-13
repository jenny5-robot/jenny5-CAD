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

use <../basic_scad/point_transformations_3d.scad>
//--------------------------------------------------------------------
module wheel_with_teeths(external_radius = 84, steps = 24)// radius = 42, steps = 12
{
    height = 12;
    screw_length = external_radius - 24;
    angle_step = 360/steps;
    diametral_thickness = 12;
    
	difference(){
      // traction teeth
      union(){
		color (plastic_color) cylinder (r = external_radius, h = height, $fn = 100, center = true);
		for ( i = [0 : 1 : steps] )	
    		rotate([i * angle_step + 16, 90, 0])
                translate ([0, 0, external_radius - 0.3])
                    color("red") cylinder(h = 8, r2 = 1.5, r1 = 5.5, $fn = 30, center = false);

      }
      num_spokes = 8;
      spoke_angle = 360 / num_spokes;
      // holes for saving material
	  for ( i = [0 : 1 : num_spokes] )	
		rotate([i * spoke_angle, 90, 0]){
          translate ([0, 0, external_radius - screw_length - 8]){
          hull(){
            translate ([height / 2, 0, 0])         
                    cylinder(h = screw_length - 2, r1 = 4, r2 = 14, $fn = 6, center = false);
            translate ([-height / 2, 0, 0])         
                    cylinder(h = screw_length - 2, r1 = 4, r2 = 14, $fn = 6, center = false);
                }
            }
        }

// 4 holes for fixing the part to the next ones	
		for ( i = [0 : 1 : 4] ){
			rotate ([0, 0, spoke_angle / 2]) translate([(external_radius - diametral_thickness / 2) * sin(i * 90), (external_radius - diametral_thickness / 2) * cos(i * 90), 0]) cylinder(h = height + 2 * display_tolerance, r = 2, $fn = 30, center = true);
			//translate([(20) * sin(i*90+16), (20) * cos(i*90+16), 0]) cylinder(h=thick, r = 2, $fn = 20, center = true);
		}
        // centre hole
        cylinder (r = 6, h = height + 1, $fn = 100, center = true);
        translate ([0, 0, height / 2 - M12_nut_thick]) cylinder (r = M12_nut_radius, h = M12_nut_thick + display_tolerance, $fn = 6, center = false);
	}
}
//--------------------------------------------------------------------
module wheel_extension(radius = 42.5, _h = 8, thumb_height = 18, num_faces_nut_holes = 6)
{
    diametral_thickness = 12;
	difference(){
        union(){
            cylinder (r = radius, h = _h, $fn = 100);
            // extensions
            for (i = [0 : 3])
                translate([(radius - diametral_thickness / 2) * sin(i * 90), (radius - diametral_thickness / 2) * cos(i * 90), _h]) cylinder(h = thumb_height, r = diametral_thickness / 2, $fn = 30);
        }
		translate (-display_tolerance_z) cylinder (r = radius - diametral_thickness, h = _h + 2 * display_tolerance, $fn = 100);
		// screw holes
        for (i = [0 : 3])
			translate([(radius - diametral_thickness / 2) * sin(i * 90), (radius - diametral_thickness / 2) * cos(i * 90), 0] - display_tolerance_z) cylinder(h = _h + thumb_height + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
        // nuts holes
        for (i = [0 : 3])
			translate([(radius - diametral_thickness / 2) * sin(i * 90), (radius - diametral_thickness / 2) * cos(i * 90), 0] - display_tolerance_z) rotate ([0, 0, 30 * (i % 2)]) cylinder(h = m4_nut_thick + display_tolerance, r = m4_nut_radius, $fn = num_faces_nut_holes);
        
	}
}
//--------------------------------------------------------------------
module wheel_traction_pulley()
{
  difference(){
    color (plastic_color)
      union(){  
        pulley_with_shaft(profile = 67, num_teeth = 63, pulley_b_ht = 0, pulley_b_dia = 0, pulley_t_ht = 8, shaft_radius = 6, nut_radius = 0, nut_height = 0);
         
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
    space_between_wheels = 18;
    // screw axis
    translate ([0, 0, -6]) 
      M12_hexa(140);
    // traction wheel
    wheel_with_teeths(wheel_radius, num_tracks_per_circle);
    // bottom extension wheel
    translate ([0, 0, -6 -8 -space_between_wheels])
    wheel_extension(tracks_wheel_radius, 12, 18, 6);
    // top extension wheel
    translate ([0, 0, 6 + 8 + space_between_wheels])
    mirror([0, 0, 1])
    wheel_extension(tracks_wheel_radius, 12, 18, 6);
    
    // screws for glueing plastic parts
    
    for (i = [0 : 3]){
      translate([(wheel_radius - 5) * sin(i * 90), (wheel_radius - 5) * cos(i * 90), -6 - 8 - space_between_wheels - m4_nut_thick]) M4_hexa(70);
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
module first_gear(num_tracks_per_circle, wheel_radius)
{
    space_between_wheels = 18;
    // screw axis
    translate ([0, 0, -6]) 
      M12_hexa(140);
    // traction wheel
    wheel_with_teeths(wheel_radius, num_tracks_per_circle);
    // bottom extension wheel
    translate ([0, 0, -6 -8 -space_between_wheels])
    wheel_extension(tracks_wheel_radius, 12, 18, 6);
    // top extension wheel
    translate ([0, 0, 6 + 8 + space_between_wheels])
    mirror([0, 0, 1])
    wheel_extension(tracks_wheel_radius, 12, 18, 6);
    
    // screws for glueing plastic parts
    
    for (i = [0 : 3]){
      translate([(wheel_radius - 5) * sin(i * 90), (wheel_radius - 5) * cos(i * 90), -6 - 8 - space_between_wheels - m4_nut_thick]) M4_hexa(70);
      translate([(wheel_radius - 5) * sin(i * 90), (wheel_radius - 5) * cos(i * 90), 6 + 8 + space_between_wheels]) M4_autolock_nut();
    }
    
    // spacer
    translate ([0, 0, 6])
    M12_washer();
    // nut
    translate ([0, 0, 6 + washer_12_thick]) M12_nut();
    // long nut
   translate ([0, 0, 6 + washer_12_thick]) M12_long_nut();
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
    translate ([motor_gr_ep_45_radius + base_wall_dc_motor_housing_thick + 2, motor_gr_ep_45_radius + side_wall_dc_motor_housing_thick + 15, motor_gr_ep_45_188_1_length + 3]) mirror([0, 0, 1]) motor_gr_ep_45_188_1();
}
//--------------------------------------------------------------------
module base_motor_with_housing_right()
{
    motor_gr_ep_45_housing_with_belt_tensioner_bearing_based_y_and_base_holes(15, 0, 1);
    translate ([motor_gr_ep_45_radius + base_wall_dc_motor_housing_thick + 2, motor_gr_ep_45_radius + side_wall_dc_motor_housing_thick + 15, motor_gr_ep_45_188_1_length + 3]) mirror([0, 0, 1]) motor_gr_ep_45_188_1();
}
//--------------------------------------------------------------------
module platform_sheet()
{
  difference(){    
    cube(base_platform_size);
    
    // holes  
    // LEFT SIDE
    // first gear, first bearing
    for (i=[0:1]){
        translate ([first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_1_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        echo("first shaft first bearing",  [first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_1_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i]);
    }
    // first gear, second bearing
       for (i=[0:1]){
    translate ([first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_2_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        echo("first shaft second bearing",  [first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_2_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i]);
    }
    // second gear, first bearing
    for (i=[0:1]){
    translate ([first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2 + distance_between_wheels, wheels_bearing_housing_1_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        echo("second shaft first bearing",  [first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2 + distance_between_wheels, wheels_bearing_housing_1_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i]);
    }
    // second gear, second bearing
    for (i=[0:1]){
        translate ([first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2 + distance_between_wheels, wheels_bearing_housing_2_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        echo("second shaft second bearing",  [first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2 + distance_between_wheels, wheels_bearing_housing_1_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i]);
    }
    
    // holes for motor housing
    for (i = [0 : 3]){
        echo("motor housing holes = ", [leg_postion_on_platform - motor_gr_ep_45_housing_size[1] / 2 + 10, 25 - 3, 0] + rotate_z(90, motor_gr_ep_45_housing_large_base_holes[i]));
        translate ([leg_postion_on_platform - motor_gr_ep_45_housing_size[1] / 2 + 10, 25 - 3, 0]) rotate ([0, 0, 90]) translate (motor_gr_ep_45_housing_large_base_holes[i] - display_tolerance_z) cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
    }
    
    
    // RIGHT SIDE
     // first gear, first bearing
    for (i = [0 : 1]){
        translate ([first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, base_platform_size[1] - wheels_bearing_housing_1_offset_y, 0] + [rbearing_6201_enclosed_housing_holes_position[i][0], -rbearing_6201_enclosed_housing_holes_position[i][1], 0] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        echo("RIGHT; first shaft first bearing",  [first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, base_platform_size[1] - wheels_bearing_housing_1_offset_y, 0] - rbearing_6201_enclosed_housing_holes_position[i]);
    }
    // first gear, second bearing
    for (i = [0 : 1]){
   //     translate ([first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, base_platform_size[1]- wheels_bearing_housing_2_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        echo("first shaft second bearing",  [first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, base_platform_size[1] - wheels_bearing_housing_2_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i]);
    }
    // second gear, first bearing
    for (i = [0 : 1]){
    translate ([first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2 + distance_between_wheels, base_platform_size[1] - wheels_bearing_housing_1_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        echo("second shaft first bearing",  [first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2 + distance_between_wheels, base_platform_size[1] - wheels_bearing_housing_1_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i]);
    }
    // second gear, second bearing
    for (i = [0 : 1]){
        translate ([first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2 + distance_between_wheels, wheels_bearing_housing_2_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i] - display_tolerance_z)
    cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        echo("second shaft second bearing",  [first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2 + distance_between_wheels, wheels_bearing_housing_1_offset_y, 0] + rbearing_6201_enclosed_housing_holes_position[i]);
    }
// motor housing holes
    for (i = [0 : 3])
        translate ([leg_postion_on_platform - motor_gr_ep_45_housing_size[1] / 2 + 10, base_platform_size[1] - (25 - 3), 0]) rotate ([0, 0, 90]) translate (motor_gr_ep_45_housing_large_base_holes[i] - display_tolerance_z) cylinder (h = base_platform_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);

        // holes for fixing the leg to the platform
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
    rotate ([0, 0, 10.8]) pulley_with_shaft(68, 17, 0, 0, 8, 5, 0, 0);
        
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
    
    // reinforcement aluminium L profiles
    // left side
    translate ([0, -3, -3]) rotate ([-90, 0, 0]) rotate ([0, 0, -90]) L_profile(base_platform_size[0], edge_1_width = 25, edge_2_width = 25, wall_thick = 3);
    // right side
    translate ([0, base_platform_size[1] + 3, -3]) rotate ([0, 0, -90]) L_profile(base_platform_size[0], edge_1_width = 25, edge_2_width = 25, wall_thick = 3);

  // motor right
    
  translate ([motor_gr_ep_45_housing_size[1], base_platform_size[1], base_platform_size[2]]) 
    rotate([90, 0, 0])
      rotate([0, 0, 90]) 
        base_motor_with_housing_right();
    
    // motor left
  translate ([0, 0, base_platform_size[2]])
    //rotate([0, 0, 180])
      rotate([-90, 0, 0])
        rotate([0, 0, -90]) 
          base_motor_with_housing_left();
    
// first wheel    
    // first radial bearing housing
    translate ([first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_1_offset_y, -rbearing_6201_enclosed_housing_size[2]]) radial_bearing_6201_vertical_housing(0);
   
    // second radial bearing housing
    translate ([first_tracks_offset - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_2_offset_y, -rbearing_6201_enclosed_housing_size[2]]) radial_bearing_6201_vertical_housing(0);

// traction shaft
    // first radial bearing housing
    translate ([first_tracks_offset + distance_between_wheels - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_1_offset_y, -rbearing_6201_enclosed_housing_size[2]]) radial_bearing_6201_vertical_housing(0);
   
    // second radial bearing housing
    translate ([first_tracks_offset + distance_between_wheels - rbearing_6201_enclosed_housing_size[0] / 2, wheels_bearing_housing_2_offset_y, -rbearing_6201_enclosed_housing_size[2]]) radial_bearing_6201_vertical_housing(0);

// gears
    left_tracks_offset = -5;
    translate ([0, -track_size[0] / 2 - 15, 0]) {
            
    //first gear
        translate ([first_tracks_offset, left_tracks_offset, -rb_6201_external_radius]) rotate([-90, 0, 0]) first_gear(num_tracks_per_circle, tracks_wheel_radius);
    
    //traction gear
        translate ([first_tracks_offset + distance_between_wheels, left_tracks_offset, -rb_6201_external_radius]) rotate([-90, 0, 0]) traction_wheel(num_tracks_per_circle, tracks_wheel_radius);

        //tracks
    translate ([distance_between_wheels + first_tracks_offset, left_tracks_offset, -rb_6201_external_radius]) 
        tracks_on_2_wheels(num_tracks_per_circle, tracks_wheel_radius, distance_between_wheels);
    }




// other side

    right_tracks_offset = 5;
  
    translate([0, base_platform_size[1] + track_size[0] / 2 + 15, 0]){
    // first gear
        translate ([first_tracks_offset, right_tracks_offset, -rb_6201_external_radius]) rotate([90, 0, 0]) first_gear(num_tracks_per_circle, tracks_wheel_radius);
    // traction gear
        translate ([first_tracks_offset + distance_between_wheels, right_tracks_offset, -rb_6201_external_radius]) mirror([0, 1, 0]) rotate([-90, 0, 0]) traction_wheel(num_tracks_per_circle, tracks_wheel_radius);

    //tracks
    translate ([distance_between_wheels + first_tracks_offset, right_tracks_offset, -rb_6201_external_radius]) 
        tracks_on_2_wheels(num_tracks_per_circle, tracks_wheel_radius, distance_between_wheels);

}
    // back wheel
    
    translate ([base_platform_size[0] + 100, base_platform_size[1]/2, -rb_6201_external_radius - tracks_wheel_radius - track_size[2] + chair_wheel_radius]) rotate ([0, 0, 90]) chair_wheel();
    
    // laptop
    translate ([base_platform_size[0] - laptop13_size[1], laptop13_size[0] / 2 + base_platform_size[1] / 2, 50]) rotate ([0, 0, 0]) rotate ([0, 0, -90]) translate ([0, 0, base_platform_size[2]]) laptop13();

    // lidar

    translate([lidar_position, base_platform_size[1] / 2, base_platform_size[2] + 25]) rotate([0, 0, 90]) tera_ranger_one_lidar();

// battery
  //  translate([160, multistar_4s_20000_size[2], base_platform_size[2]]) rotate ([90, 0, 0]) multistar_4s_20000();
}
//--------------------------------------------------------------------


platform();

//platform_sheet(); 


//base_motor_housing_left(); // 1x
//base_motor_housing_right(); // 1x



//traction_wheel(num_tracks_per_circle, tracks_wheel_radius);

//base_motor_pulley();

//motor_housing_with_components();

//base_motor_with_housing_left();

//tracks_on_half_wheel(num_tracks_per_circle, tracks_wheel_radius);

//first_gear();

//second_gear(num_tracks_per_circle, tracks_wheel_radius);

//tracks_on_2_wheels(num_tracks_per_circle, tracks_wheel_radius, 200);

//string_of_tracks (10);

//wheel_traction_pulley();

//wheel_with_teeths(tracks_wheel_radius, num_tracks_per_circle);

//wheel_extension(tracks_wheel_radius, 12, 18, 6); // 4x

//wheel_extension(tracks_wheel_radius, 12, 18, 20); // 4x

//traction_wheel(num_tracks_per_circle, tracks_wheel_radius);

//tracks_on_2_wheels(12, 42.5, 200);

//laptop_fixer_corner_left();

//laptop_fixer_corner_right();

//tracks_tensioner(); // 2x
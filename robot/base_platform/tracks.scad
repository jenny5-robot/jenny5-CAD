// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// License: MIT
//--------------------------------------------------------------------

include <../../basic_scad/params_radial_bearings.scad>
use <../../basic_scad/radial_bearings.scad>

include <../../basic_scad/material_colors.scad>
use <../../basic_scad/screws_nuts_washers.scad>
include <../../basic_scad/tolerance.scad>
include <../../basic_scad/params_screws_nuts_washers.scad>
include <base_platform_params.scad>
use <../../basic_scad/involute_gears.scad>
use <../../basic_scad/spacer.scad>

use <platform_gears.scad>

//--------------------------------------------------------------------
module prism(h)
{
    linear_extrude(height = h)
        polygon( points = [[-3, 0], [3, 0], [0, 9]]);
}
//--------------------------------------------------------------------
module tooth2(height, length, thick)
{
    render(){
        hull() {
            cylinder(h = height, r = thick / 2, $fn = 30);
            translate ([length - thick / 2, 0, 0])
            cylinder(h = height, r = thick / 2, $fn = 30);
        }
    }
}
//--------------------------------------------------------------------
module wheel_extension_with_teeth(radius = 48.5, height = 8, steps = 18)
{
    
    angle_step = 360/steps;
    color (plastic_color) 
    render(){
        diametral_thickness = 10;
        difference(){
            union(){
                cylinder (r = radius, h = height, $fn = 100);
                //cylinder (r = radius + 5, h = 3, $fn = 100);
		for ( i = [0 : 1 : steps] )	
    		rotate([0, 0, i * angle_step]){
                translate ([radius, 0, 0])
                 tooth2(height = height, length = 9, thick = 9);
                
           //     translate ([0, 0, external_radius + 4 - 0.3])
           //         color("red") cylinder(h = 4, r2 = 1.5, r1 = 6, $fn = 30, center = false);
            }                

            }
            translate (-display_tolerance_z) cylinder (r = radius - diametral_thickness, h = height + 2 * display_tolerance, $fn = 100);
            // screw holes
            for (i = [0 : 7])
                translate([(radius - diametral_thickness / 2) * sin(i * 45), (radius - diametral_thickness / 2) * cos(i * 45), 0] - display_tolerance_z) cylinder(h = height + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
        }
    }
}
//--------------------------------------------------------------------
module wheel_wall(radius = 48.5, height = 4)
{
    color (plastic_color) 
    render(){
        diametral_thickness = 10;
        difference(){
            union(){
                cylinder (r = radius + 9, h = height - 1, $fn = 100);
                translate([0, 0, height - 1]) cylinder (r2 = radius, r1 = radius + 9, h = 1, $fn = 100);
            }

            translate (-display_tolerance_z) cylinder (r = radius - diametral_thickness, h = height + 2 * display_tolerance, $fn = 100);
            // screw holes
            for (i = [0 : 7])
                translate([(radius - diametral_thickness / 2) * sin(i * 45), (radius - diametral_thickness / 2) * cos(i * 45), 0] - display_tolerance_z) cylinder(h = height + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
        }
    }
}
//--------------------------------------------------------------------
module wheel_middle_external(external_radius = 84)
{
    screw_case_height = 10;
    color (plastic_color) 
   // render()
    {
    height = 4;
    screw_length = external_radius - 24;
    
    diametral_thickness = 10;
    
	difference(){
      // traction teeth
      union(){
            cylinder (r = external_radius + 9, h = 3, $fn = 100);
            translate([0, 0, 3]) cylinder (r2 = external_radius, r1 = external_radius + 9, h = height - 3, $fn = 100);
          // screw case
          cylinder (h = screw_case_height, r = 18);
            }

      num_spokes = 8;
      spoke_angle = 360 / num_spokes;
      // holes for saving material
	  for ( i = [0 : 1 : num_spokes] )	
		rotate([i * spoke_angle, 90, 0]){
          translate ([0, 0, external_radius - screw_length - 6]){
          hull(){
            translate ([height / 2, 0, 0])         
                    cylinder(h = screw_length - 4, r1 = 4, r2 = 14, $fn = 6, center = false);
            translate ([-height / 2, 0, 0])         
                    cylinder(h = screw_length - 4, r1 = 4, r2 = 14, $fn = 6, center = false);
                }
            }
        }

// 4 holes for fixing the part to the next ones
               diametral_thickness = 10; 
            for (i = [0 : 3])
                rotate([0, 0, 23])
                translate([(external_radius - diametral_thickness / 2) * sin(i * 90), (external_radius - diametral_thickness / 2) * cos(i * 90), 0] - display_tolerance_z) cylinder(h = height + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);

// midle screw holes
            for (i = [0 : 3])
                                rotate([0, 0, 70])
                translate([14 * sin(i * 90), 14 * cos(i * 90), 0] - display_tolerance_z) cylinder(h = screw_case_height + 2 * display_tolerance, r = m3_screw_radius, $fn = 30);
        // centre hole
        cylinder (r = 6, h = height + 1, $fn = 50);
        // nut hole
        translate ([0, 0, height - 1]) cylinder (r = M12_nut_radius, h = M12_nut_thick + display_tolerance, $fn = 6, center = false);
	}
    }
}
//--------------------------------------------------------------------
module wheel_middle_internal(external_radius = 84)
{
    color (plastic_color) 
    //render()
    {
    height = 4;
    screw_length = external_radius - 24;
    
    diametral_thickness = 10;
    
	difference(){
      // traction teeth
      union(){
            cylinder (r = external_radius + 9, h = 3, $fn = 100);
            translate([0, 0, 3]) cylinder (r2 = external_radius, r1 = external_radius + 9, h = height - 3, $fn = 100);
            }

      num_spokes = 8;
      spoke_angle = 360 / num_spokes;
      // holes for saving material
	  for ( i = [0 : 1 : num_spokes] )	
		rotate([i * spoke_angle, 90, 0]){
          translate ([0, 0, external_radius - screw_length - 6]){
          hull(){
            translate ([height / 2, 0, 0])         
                    cylinder(h = screw_length - 4, r1 = 4, r2 = 14, $fn = 6, center = false);
            translate ([-height / 2, 0, 0])         
                    cylinder(h = screw_length - 4, r1 = 4, r2 = 14, $fn = 6, center = false);
                }
            }
        }

// 4 holes for fixing the part to the next ones	
        diametral_thickness = 10; 
            for (i = [0 : 3])
                rotate([0, 0, 23])
                translate([(external_radius - diametral_thickness / 2) * sin(i * 90), (external_radius - diametral_thickness / 2) * cos(i * 90), 0] - display_tolerance_z) cylinder(h = height + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);

// midle screw holes
            for (i = [0 : 3])
                rotate([0, 0, 70])
                translate([14 * sin(i * 90), 14 * cos(i * 90), 0] - display_tolerance_z) cylinder(h = height + 2 * display_tolerance, r = m3_screw_radius, $fn = 30);
        
        // centre hole
        cylinder (r = 6, h = height + 1, $fn = 50);
	}
    }
}
//--------------------------------------------------------------------
module wheel_middle_with_bearing_hole(external_radius = 84)
{
    screw_case_height = rb_6907_thick;
    color (plastic_color) 
   // render()
    {
    height = 4;
    screw_length = external_radius - 24;
    
    diametral_thickness = 10;
    
	difference(){
      // traction teeth
      union(){
            cylinder (r = external_radius + 9, h = 3, $fn = 100);
          
            translate([0, 0, 3]) cylinder (r2 = external_radius, r1 = external_radius + 9, h = height - 3, $fn = 100);
          hull(){
              translate([0, 0, 3]) cylinder (r = external_radius - 10, h = height - 3, $fn = 100);
          // bearing case
          cylinder (h = screw_case_height, r = rb_6907_external_radius + 7);
          }
            }

      num_spokes = 8;
      spoke_angle = 360 / num_spokes;
      // holes for saving material
	  for ( i = [0 : 1 : num_spokes] )	
		rotate([i * spoke_angle, 90, 0]){
          translate ([0, 0, external_radius - screw_length + 6]){
          hull(){
            translate ([height / 2, 0, 0])         
                    cylinder(h = screw_length - 8, r1 = 4, r2 = 14, $fn = 6, center = false);
            translate ([-height / 2, 0, 0])         
                    cylinder(h = screw_length - 8, r1 = 4, r2 = 14, $fn = 6, center = false);
                }
            }
        }

// 8 holes for fixing the part to the next ones
               diametral_thickness = 10; 
            for (i = [0 : 7])
                rotate([0, 0, 23])
                translate([(external_radius - diametral_thickness / 2) * sin(i * 45), (external_radius - diametral_thickness / 2) * cos(i * 45), 0] - display_tolerance_z) cylinder(h = height + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);

// middle screw holes
            for (i = [0 : 7])
                 rotate([0, 0, 68])
                translate([(rb_6907_external_radius + 3) * sin(i * 45), (rb_6907_external_radius + 3) * cos(i * 45), 0] - display_tolerance_z) cylinder(h = screw_case_height + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
            
        // bearing hole
        translate (-display_tolerance_z) cylinder (r = rb_6907_external_radius, h = rb_6907_thick + 2 * display_tolerance, $fn = 50, center = false);
	}
    }
}
//--------------------------------------------------------------------
module wheel_middle_with_bearing(external_radius = 84)
{
    wheel_middle_with_bearing_hole(external_radius = external_radius);
    6907rs();
    
    // screws
    for (i = [0 : 7])
        rotate([0, 0, 68])
            translate([(rb_6907_external_radius + 3) * sin(i * 45), (rb_6907_external_radius + 3) * cos(i * 45), rb_6907_thick + 2]) mirror([0, 0, 1]) M4_hexa(20);

}
//--------------------------------------------------------------------
module wheel()
{
    wheel_middle_with_bearing(wheel_radius);
    translate ([0, 0, 4]) wheel_extension_with_teeth(wheel_radius, wheel_tooth_height, wheel_steps);
    translate ([0, 0, wheel_tooth_height + 4 + 4]) mirror ([0, 0, 1]) wheel_wall(wheel_radius, 4);
    translate ([0, 0, wheel_tooth_height + 4 + 4]) wheel_wall(wheel_radius, 4);
    translate ([0, 0, wheel_tooth_height + 4 + 4 + 4]) wheel_extension_with_teeth(wheel_radius, wheel_tooth_height, wheel_steps);
    translate ([0, 0, wheel_tooth_height + 4 + 4 + 4 + wheel_tooth_height + 4]) mirror([0, 0, 1]) wheel_middle_with_bearing(wheel_radius);
    
    // screws
}
//--------------------------------------------------------------------
module first_wheel()
{
    wheel();
    translate ([0, 0, wheel_tooth_height + 4 + 4 + 4 + wheel_tooth_height + 4]) platform_wheel_gear();
}
//--------------------------------------------------------------------

//first_wheel();

spacer_round(length = 10, external_radius = 5, internal_radius = 2);

// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: https://github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_radial_bearings.scad>
include <params_screws_nuts_washers.scad>
include <params_basic_components.scad>
include <config.scad>
include <params_radial_bearings_housing.scad>
include <params_stepper_motors.scad>
use <radial_bearings.scad>
use <basic_components.scad>
use <potentiometer_support.scad>
include <tolerance.scad>
          
//---------------------------------------------------------------------------
module radial_bearing_housing(rbearing_housing_size, rbearing_housing_holes_position, rb_external_radius, rb_thick, housing_height, screw_radius = m4_screw_radius, height_extension = 0, extra_thick = 0)
{
   color(plastic_color)
    render()
        difference(){
            translate ([-rbearing_housing_size[0] / 2 - extra_thick, -rbearing_housing_size[1] / 2 - extra_thick, 0]) my_cube_rounded2 ([rbearing_housing_size[0] + 2 * extra_thick, rbearing_housing_size[1] + 2 * extra_thick, housing_height + height_extension]);
            // bearing hole
            translate ([0, 0, housing_height + height_extension - rb_thick]) cylinder (h = rb_thick, r = rb_external_radius + 0.1, $fn = 70);
            // bearing support hole
            translate (rbearing_housing_holes_position[0] - display_tolerance_z) cylinder (h = housing_height + height_extension + 2 * display_tolerance, r = rb_external_radius - 1, $fn = 70);
            // screws holes
            for (i = [1 : 4])
                translate (rbearing_housing_holes_position[i]-display_tolerance_z) cylinder (h = height_extension + housing_height + 2 * display_tolerance, r = screw_radius, $fn = 20);
        }
}
//---------------------------------------------------------------------------
module radial_bearing_spacer(rbearing_housing_size, rbearing_housing_holes_position, rb_external_radius, rb_thick, housing_height, screw_radius = m4_screw_radius, height_extension = 0)
{
   color(plastic_color)
    render()
        difference(){
            translate ([-rbearing_housing_size[0] / 2, -rbearing_housing_size[1] / 2, 0]) my_cube_rounded2 ([rbearing_housing_size[0], rbearing_housing_size[1], housing_height + height_extension]);
            // bearing support hole
            translate (rbearing_housing_holes_position[0] - display_tolerance_z) cylinder (h = housing_height + height_extension + 2 * display_tolerance, r = rb_external_radius - 1, $fn = 70);
            // screws holes
            for (i = [1 : 4])
                translate (rbearing_housing_holes_position[i]-display_tolerance_z) cylinder (h = height_extension + housing_height + 2 * display_tolerance, r = screw_radius, $fn = 20);
        }
}
//---------------------------------------------------------------------------
module radial_2x_bearing_housing(rbearing_housing_size, rbearing_housing_holes_position, rb_external_radius, rb_thick, housing_height, screw_radius = m4_screw_radius, height_extension = 0)
{
   color(plastic_color)
    render()
        difference(){
            translate ([-rbearing_housing_size[0] / 2, -rbearing_housing_size[1] / 2, 0]) my_cube_rounded2 ([rbearing_housing_size[0], rbearing_housing_size[1], housing_height + height_extension]);
            // bearing hole
            translate ([0, 0, housing_height + height_extension - rb_thick]) cylinder (h = rb_thick, r = rb_external_radius, $fn = 70);
            // bearing hole
            cylinder (h = rb_thick, r = rb_external_radius, $fn = 70);
            // bearing support hole
            translate (rbearing_housing_holes_position[0] - display_tolerance_z) cylinder (h = housing_height + height_extension + 2 * display_tolerance, r = rb_external_radius - 1, $fn = 70);
            // screws holes
            for (i = [1 : 4])
                translate (rbearing_housing_holes_position[i]-display_tolerance_z) cylinder (h = height_extension + housing_height + 2 * display_tolerance, r = screw_radius, $fn = 20);
        }
}
//---------------------------------------------------------------------------
module radial_bearing_enclosed_housing_half_with_nema_holes(height, rb_external_radius, rb_thick, motor_tolerance)
{
        lungime = 2 * (rb_external_radius + 2 * radial_bearing_housing_lateral_wall_thickness + 2 * m3_screw_radius);
    latime = radial_bearing_housing_base_wall_thickness + rb_thick + radial_bearing_housing_base_wall_thickness;

    difference(){
        radial_bearing_enclosed_housing_half(height, rb_external_radius, rb_thick);
        translate ([-nema_17_width / 2 + lungime / 2, 0, nema_17_width + motor_tolerance]) rotate ([-90, 0, 0]) gauri_nema17_with_motor_hole(latime, 1.5, 1.5, 0, motor_tolerance);
    }
}
//---------------------------------------------------------------------------
module radial_bearing_enclosed_housing_half(height, rb_external_radius, rb_thick)
{
    lungime = 2 * (rb_external_radius + 2 * radial_bearing_housing_lateral_wall_thickness + 2 * m4_screw_radius);
    latime = radial_bearing_housing_base_wall_thickness + rb_thick + radial_bearing_housing_base_wall_thickness;
    
    color(plastic_color)
    difference(){
        cube([lungime, latime, height]);
        // gaura rulment
        translate ([lungime / 2, radial_bearing_housing_base_wall_thickness, height]) rotate ([-90, 0, 0])
        cylinder (h = latime - 2 * radial_bearing_housing_base_wall_thickness, r = rb_external_radius, $fn = 60);
        // gaura ax
        translate ([lungime / 2, 0, height] - display_tolerance_y) rotate ([-90, 0, 0])
        cylinder (h = latime + 2 * display_tolerance, r = rb_external_radius - 2, $fn = 60);
        // gauri surub
        for (i=[0:1])
        translate (rbearing_608_enclosed_housing_holes_position[i] - display_tolerance_z) cylinder (h = height + 2 * display_tolerance, r = m4_screw_radius, $fn = 40);
    }
}
//---------------------------------------------------------------------------
module radial_bearing_enclosed_housing(height, rb_external_radius, rb_thick)
{
    radial_bearing_enclosed_housing_half(height, rb_external_radius, rb_thick);
    translate ([0, 0, height + rb_external_radius + radial_bearing_housing_lateral_wall_thickness]) mirror([0, 0, 1])
        radial_bearing_enclosed_housing_half(rb_external_radius + radial_bearing_housing_lateral_wall_thickness, rb_external_radius, rb_thick); 
}
//---------------------------------------------------------------------------
module radial_bearing_enclosed_housing_with_nema_holes(height, rb_external_radius, rb_thick, motor_tolerance)
{
    radial_bearing_enclosed_housing_half_with_nema_holes(height, rb_external_radius, rb_thick, motor_tolerance);
    translate ([0, 0, height + rb_external_radius + radial_bearing_housing_lateral_wall_thickness]) mirror([0, 0, 1])
        radial_bearing_enclosed_housing_half(rb_external_radius + radial_bearing_housing_lateral_wall_thickness, rb_external_radius, rb_thick);    
}
//---------------------------------------------------------------------------
module bearing_housing_with_flaps(radius = 42.5, bearing_external_radius, bearing_thick, distance_between_flaps = 18)
{
    thick = 12;
            flaps_length = 45;
            flaps_thick = 7;
    
    dist_to_first_flap_hole = 10;
    dist_to_second_flap_hole = 30;
    
	difference(){
		color (plastic_color) 
        union(){
            cylinder (r = radius, h = thick, $fn = 100);	
        //flaps
            translate([distance_between_flaps / 2, 0, 0]) cube([flaps_thick, radius + flaps_length, thick]); 
            translate([-distance_between_flaps / 2 - flaps_thick, 0, 0]) cube([flaps_thick, radius + flaps_length, thick]); 
        }
       
		for ( i = [0 : 1 : 4] ){
            // fixing the bearing
			translate([(bearing_external_radius + 3) * sin(i * 90 + 45), (bearing_external_radius + 3) * cos(i * 90 + 45), 0]) cylinder(h = thick + 2 * display_tolerance, r = 2, $fn = 20);
		}
        // center hole
        translate(-display_tolerance_z) cylinder (r = bearing_external_radius - 2, h = thick, $fn = 100);
        // bearing hole
        translate ([0, 0, thick - bearing_thick]) cylinder (r = bearing_external_radius, h = thick, $fn = 100);
        // flap first hole
        hull(){
            translate([- distance_between_flaps / 2 - flaps_thick, radius + dist_to_first_flap_hole, thick / 2] - display_tolerance_x) rotate([0, 90, 0])
cylinder (h = distance_between_flaps + 2 * flaps_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
            translate([- distance_between_flaps / 2 - flaps_thick, radius + dist_to_first_flap_hole + 10, thick / 2] - display_tolerance_x) rotate([0, 90, 0])
cylinder (h = distance_between_flaps + 2 * flaps_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        }
        
                // flap first hole
        hull(){
            translate([- distance_between_flaps / 2 - flaps_thick, radius + dist_to_second_flap_hole, thick / 2] - display_tolerance_x) rotate([0, 90, 0])
cylinder (h = distance_between_flaps + 2 * flaps_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
            translate([- distance_between_flaps / 2 - flaps_thick, radius + dist_to_second_flap_hole + 10, thick / 2] - display_tolerance_x) rotate([0, 90, 0])
cylinder (h = distance_between_flaps + 2 * flaps_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        }
	}
}
//---------------------------------------------------------------------------
module rbearing_6002_housing()
{
    radial_bearing_housing(rbearing_6002_housing_size, rbearing_6002_housing_holes_position, rb_6002_external_radius, rb_6002_thick, rbearing_6002_housing_size[2], m4_screw_radius);
}
//---------------------------------------------------------------------------
module rbearing_626_housing()
{
    radial_bearing_housing(rbearing_626_housing_size, rbearing_626_housing_holes_position, rb_626_external_radius, rb_626_thick, rbearing_626_housing_size[2], m4_screw_radius);
}
//---------------------------------------------------------------------------
module rbearing_608_housing()
{
    radial_bearing_housing(rbearing_608_housing_size, rbearing_608_housing_holes_position, rb_608_external_radius, rb_608_thick, rbearing_608_housing_size[2], m4_screw_radius);
}
//---------------------------------------------------------------------------
module rbearing_6001_housing()
{
    radial_bearing_housing(rbearing_6001_housing_size, rbearing_6001_housing_holes_position, rb_6001_external_radius, rb_6001_thick, rbearing_6001_housing_size[2], m4_screw_radius);
}
//---------------------------------------------------------------------------
module rbearing_6005_housing()
{
    radial_bearing_housing(rbearing_6005_housing_size, rbearing_6005_housing_holes_position, rb_6005_external_radius, rb_6005_thick, rbearing_6005_housing_size[2], m4_screw_radius);
}
//---------------------------------------------------------------------------
module rbearing_6905_housing()
{
    radial_bearing_housing(rbearing_6905_housing_size, rbearing_6905_housing_holes_position, rb_6905_external_radius, rb_6905_thick, rbearing_6905_housing_size[2], m4_screw_radius);
}
//---------------------------------------------------------------------------
module rbearing_608_housing_double()
{
    radial_bearing_housing(rbearing_608_housing_size, rbearing_608_housing_holes_position, rb_608_external_radius, 2 * rb_608_thick, rbearing_608_housing_size[2] + rb_608_thick, m4_screw_radius, 0, 1);
}
//---------------------------------------------------------------------------
module rbearing_6001_double_housing()
{
    radial_bearing_housing(rbearing_housing_size = rbearing_6001_housing_size, rbearing_housing_holes_position = rbearing_6001_housing_holes_position, rb_external_radius = rb_6001_external_radius, rb_thick = 2 * rb_6001_thick, housing_height = rbearing_6001_housing_size[2] + rb_6001_thick, screw_radius = m4_screw_radius, height_extension = -1);
}
//---------------------------------------------------------------------------
module rbearing_6001_double_housing_thicker_wall(extra_height = 0)
{
    radial_bearing_housing(rbearing_housing_size = rbearing_6001_housing_size_thicker, rbearing_housing_holes_position = rbearing_6001_housing_holes_position, rb_external_radius = rb_6001_external_radius, rb_thick = 2 * rb_6001_thick, housing_height = rbearing_6001_housing_size[2] + rb_6001_thick, screw_radius = m4_screw_radius, height_extension = extra_height);
}
//---------------------------------------------------------------------------
module rbearing_6005_double_housing()
{
    radial_bearing_housing(rbearing_6005_housing_size, rbearing_6005_housing_holes_position, rb_6005_external_radius, 2 * rb_6005_thick, rbearing_6005_housing_size[2] + rb_6005_thick, m4_screw_radius, 0, 1);
}
//---------------------------------------------------------------------------
module rbearing_6002_housing_with_bearing()
{
    rbearing_6002_housing();
    translate ([0, 0, radial_bearing_housing_base_wall_thickness]) 6002rs();
}
//---------------------------------------------------------------------------
module rbearing_626_housing_with_bearing()
{
    rbearing_626_housing();
    translate ([0, 0, radial_bearing_housing_base_wall_thickness]) 626rs();
}
//---------------------------------------------------------------------------
module rbearing_608_housing_with_bearing()
{
    rbearing_608_housing();
    translate ([0, 0, radial_bearing_housing_base_wall_thickness]) 608rs();
}
//---------------------------------------------------------------------------
module rbearing_6001_housing_with_bearing()
{
    rbearing_6001_housing();
    translate ([0, 0, radial_bearing_housing_base_wall_thickness]) 6001rs();
}
//---------------------------------------------------------------------------
module rbearing_6001_double_housing_with_bearings()
{
    rbearing_6001_double_housing();
    translate ([0, 0, radial_bearing_housing_base_wall_thickness]) 6001rs();
    translate ([0, 0, rb_6001_thick + radial_bearing_housing_base_wall_thickness]) 6001rs();
}
//---------------------------------------------------------------------------
module rbearing_6005_double_housing_with_bearings()
{
    rbearing_6005_double_housing();
    translate ([0, 0, radial_bearing_housing_base_wall_thickness]) 6005rs();
    translate ([0, 0, rb_6001_thick + radial_bearing_housing_base_wall_thickness]) 6005rs();
}
//---------------------------------------------------------------------------
module radial_bearing_6002_enclosed_housing(height)
{
    radial_bearing_enclosed_housing(height, rb_6002_external_radius, rb_6002_thick);
}
//---------------------------------------------------------------------------
module radial_bearing_608_enclosed_housing(height)
{
    radial_bearing_enclosed_housing(height, rb_608_external_radius, rb_608_thick);
}
//---------------------------------------------------------------------------
module radial_bearing_608_enclosed_housing_half_top()
{
  radial_bearing_enclosed_housing_half(rb_608_external_radius + radial_bearing_housing_lateral_wall_thickness, rb_608_external_radius, rb_608_thick);
}
//---------------------------------------------------------------------------
module radial_bearing_608_enclosed_housing_half_bottom(height)
{
  radial_bearing_enclosed_housing_half(height, rb_608_external_radius, rb_608_thick);
}
//---------------------------------------------------------------------------
module radial_bearing_6002_enclosed_housing_with_nema_holes(height, motor_tolerance)
{
    radial_bearing_enclosed_housing_with_nema_holes(height, rb_6002_external_radius, rb_6002_thick, motor_tolerance);
}
//---------------------------------------------------------------------------
module rbearing_608_housing_thicker(extra_height = -1)
{
    echo(rbearing_608_housing_holes_position=rbearing_608_housing_holes_position);
    radial_bearing_housing(rbearing_housing_size = rbearing_608_housing_size, rbearing_housing_holes_position = rbearing_608_housing_holes_position, rb_external_radius = rb_608_external_radius, rb_thick = rb_608_thick, housing_height= rbearing_608_housing_size[2] + extra_height, screw_radius = m4_screw_radius, height_extension = 0);
}
//---------------------------------------------------------------------------
module rbearing_608_housing_thicker_m3(extra_height = -1)
{
    radial_bearing_housing(rbearing_housing_size = rbearing_608_housing_size, rbearing_housing_holes_position = rbearing_608_housing_holes_position_m3, rb_external_radius = rb_608_external_radius, rb_thick = rb_608_thick, housing_height= rbearing_608_housing_size[2] + extra_height, screw_radius = m3_screw_radius, height_extension = 0, extra_thick = 1);
}
//---------------------------------------------------------------------------
module rbearing_608_spacer_thicker_m3(extra_height = -1)
{
    radial_bearing_spacer(rbearing_housing_size = rbearing_608_housing_size, rbearing_housing_holes_position = rbearing_608_housing_holes_position_m3, rb_external_radius = rb_608_external_radius, rb_thick = rb_608_thick, housing_height= rbearing_608_housing_size[2] + extra_height, screw_radius = m3_screw_radius, height_extension = 0);
}
//---------------------------------------------------------------------------

// bearing_housing_with_flaps(18, rb_608_external_radius, rb_608_thick);

// rbearing_6002_housing_with_bearing();

// rbearing_608_housing();

// rbearing_6005_housing();
// rbearing_6905_housing();

// rbearing_6001_housing();
 //rbearing_608_housing_double();
//echo(rbearing_6001_housing_size=rbearing_6001_housing_size);
 //rbearing_6001_double_housing();
//rbearing_6001_double_housing_thicker_wall(extra_height = -1);
// rbearing_608_housing_with_bearing();

// rbearing_626_housing();

 //rbearing_608_housing_thicker(10);
 rbearing_608_housing_thicker_m3(0);
 //rbearing_608_spacer_thicker_m3((90.5-25) / 2 - 3 * 8);
//rbearing_608_housing_thicker(-1);
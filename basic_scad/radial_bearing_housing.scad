// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_radial_bearings.scad>
include <params_screws_nuts_washers.scad>
include <params_basic_components.scad>
include <config.scad>
include <params_radial_bearings_housing.scad>
include <params_stepper_motors.scad>
use <radial_bearings.scad>
use <stepper_motors_utils.scad>
use <functions_3d.scad>
          
//---------------------------------------------------------------------------
module radial_bearing_housing(rbearing_housing_size, rbearing_housing_holes_position, rb_external_radius, rb_thick, inaltime, screw_radius = m4_screw_radius, extension = 0, hole_base = 2)
{
   
   color(plastic_color)
       render(){
        difference(){
            translate ([-rbearing_housing_size[0] / 2, -rbearing_housing_size[1] / 2, 0]) my_cube_rounded2([rbearing_housing_size[0], rbearing_housing_size[1], inaltime]);
            // rulment
            translate ([0, 0, radial_bearing_housing_grosime_perete_baza]) cylinder (h = rb_thick + display_tolerance, r = rb_external_radius, $fn = 70);
            // gaura centru
          translate (rbearing_housing_holes_position[0]-display_tolerance_z) cylinder (h = rb_thick + radial_bearing_housing_grosime_perete_baza + 2 * display_tolerance, r = rb_external_radius - hole_base, $fn = 70);
            // gaura surub
    for (i=[1:4])
        translate (rbearing_housing_holes_position[i]-display_tolerance_z) cylinder (h = rb_thick + radial_bearing_housing_grosime_perete_baza + 2 * display_tolerance, r = screw_radius, $fn = 20);  
    
        }
    }
}
//---------------------------------------------------------------------------
module radial_bearing_housing_with_potentiometer_support(rbearing_housing_size, rbearing_housing_holes_position, rb_external_radius, rb_thick, inaltime, screw_radius = m4_screw_radius, extension_length = 25)
{
    color(plastic_color){
      radial_bearing_housing(rbearing_housing_size, rbearing_housing_holes_position, rb_external_radius, rb_thick, inaltime, screw_radius);
        translate ([rbearing_housing_size[0] / 2 - 2, -rbearing_housing_size[1] / 2, 0]) potentiometer_support(extension_length, rbearing_housing_size[1], 4);
    }
}
//---------------------------------------------------------------------------
module radial_bearing_enclosed_housing_half_with_nema_holes(height, rb_external_radius, rb_thick, motor_tolerance)
{
        lungime = 2 * (rb_external_radius + 2 * radial_bearing_housing_grosime_perete_lateral + 2 * m3_screw_radius);
    latime = radial_bearing_housing_grosime_perete_baza + rb_thick + radial_bearing_housing_grosime_perete_baza;

    difference(){
        radial_bearing_enclosed_housing_half(height, rb_external_radius, rb_thick);
        translate ([-nema_17_width / 2 + lungime / 2, 0, nema_17_width + motor_tolerance]) rotate ([-90, 0, 0]) gauri_nema17_with_motor_hole(latime, 1.5, 1.5, 0, motor_tolerance);
    }
}
//---------------------------------------------------------------------------
module radial_bearing_enclosed_housing_half(height, rb_external_radius, rb_thick)
{
    lungime = 2 * (rb_external_radius + 2 * radial_bearing_housing_grosime_perete_lateral + 2 * m4_screw_radius);
    latime = radial_bearing_housing_grosime_perete_baza + rb_thick + radial_bearing_housing_grosime_perete_baza;
    
    color(plastic_color)
    difference(){
        cube([lungime, latime, height]);
        // gaura rulment
        translate ([lungime / 2, radial_bearing_housing_grosime_perete_baza, height]) rotate ([-90, 0, 0])
        cylinder (h = latime - 2 * radial_bearing_housing_grosime_perete_baza, r = rb_external_radius, $fn = 60);
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
    translate ([0, 0, height + rb_external_radius + radial_bearing_housing_grosime_perete_lateral]) mirror([0, 0, 1])
        radial_bearing_enclosed_housing_half(rb_external_radius + radial_bearing_housing_grosime_perete_lateral, rb_external_radius, rb_thick); 
}
//---------------------------------------------------------------------------
module radial_bearing_enclosed_housing_with_nema_holes(height, rb_external_radius, rb_thick, motor_tolerance)
{
    radial_bearing_enclosed_housing_half_with_nema_holes(height, rb_external_radius, rb_thick, motor_tolerance);
    translate ([0, 0, height + rb_external_radius + radial_bearing_housing_grosime_perete_lateral]) mirror([0, 0, 1])
        radial_bearing_enclosed_housing_half(rb_external_radius + radial_bearing_housing_grosime_perete_lateral, rb_external_radius, rb_thick);    
}
//---------------------------------------------------------------------------
module radial_bearing_vertical_housing(housing_size = rbearing_608_enclosed_housing_size, rbearing_enclosed_housing_holes_position = rbearing_608_enclosed_housing_holes_position, grosime_perete_lateral_lungime_exterior = radial_bearing_vertical_housing_grosime_perete_lateral_lungime_exterior,grosime_perete_lateral_lungime_interior = radial_bearing_vertical_housing_grosime_perete_lateral_lungime_interior, grosime_perete_lateral_latime = radial_bearing_vertical_housing_grosime_perete_lateral_latime, screw_holes_tolerance = 0)
{
    buza = 2;
    
    rb_thick = housing_size[1] - 2 * grosime_perete_lateral_latime;
    rb_external_radius = housing_size[0] / 2 - (grosime_perete_lateral_lungime_exterior + grosime_perete_lateral_lungime_interior + 2 * m4_screw_radius);

//echo(housing_size=housing_size);
//echo(rb_thick=rb_thick);
    difference(){
       color(plastic_color) my_cube_rounded3_x(housing_size + [2 * screw_holes_tolerance, 0, 0]);
        // rulmentul
        
        hull(){
            translate ([housing_size[0] / 2 + screw_holes_tolerance, grosime_perete_lateral_latime, radial_bearing_vertical_housing_grosime_perete_baza + rb_external_radius]) rotate ([-90, 0, 0]) cylinder (h =  rb_thick, r = rb_external_radius, $fn = 100);
            translate ([housing_size[0] / 2 + screw_holes_tolerance, grosime_perete_lateral_latime, housing_size[2] ]) rotate ([-90, 0, 0]) cylinder (h =  rb_thick, r = rb_external_radius, $fn = 100);
        }
        
        // margine rulment
        hull(){
            translate ([housing_size[0] / 2 + screw_holes_tolerance, 0, radial_bearing_vertical_housing_grosime_perete_baza + rb_external_radius] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h =  housing_size[1] + 2 * display_tolerance, r = rb_external_radius - buza, $fn = 100);
            translate ([housing_size[0] / 2 + screw_holes_tolerance, 0, housing_size[2]] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h =  housing_size[1] + 2 * display_tolerance, r = rb_external_radius - buza, $fn = 100);
        }
        // gauri suruburi
        for (i=[0:1]){
            hull(){
            translate(rbearing_enclosed_housing_holes_position[i] + i * [screw_holes_tolerance, 0, 0]- display_tolerance_z)cylinder (h = housing_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
            translate(rbearing_enclosed_housing_holes_position[i] + (i + 1) * [screw_holes_tolerance, 0, 0]- display_tolerance_z)cylinder (h = housing_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
            }
        }
    }
}
//---------------------------------------------------------------------------
module radial_bearing_vertical_housing_bounded(housing_size, radial_bearing_external_radius, radial_bearing_thick, distance_between_holes)
{
    difference(){
        color(plastic_color)
        hull(){
            cylinder (h = housing_size[2], r = housing_size[1] / 2);
            translate ([housing_size[0] - housing_size[1], 0, 0]) cylinder (h = housing_size[2], r = housing_size[1] / 2);
        }
        
        // bearing hole
        translate ([housing_size[0] / 2 - housing_size[1] / 2, housing_size[1] / 2, housing_size[2]] + display_tolerance_y) rotate ([90, 0, 0]) cylinder (h = housing_size[1] + 2 * display_tolerance, r = radial_bearing_external_radius - 1, $fn = 50);
        
        translate ([housing_size[0] / 2 - housing_size[1] / 2, radial_bearing_thick / 2, housing_size[2]]) rotate ([90, 0, 0]) cylinder (h = radial_bearing_thick, r = radial_bearing_external_radius, $fn = 50);

        // screw holes
        translate (-display_tolerance_z) cylinder (h = housing_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        translate ([housing_size[0] - housing_size[1], 0, 0]) translate (-display_tolerance_z) cylinder (h = housing_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
    }
}
//---------------------------------------------------------------------------
module radial_bearing_u_vertical_housing(rb_external_radius, rb_thick, extra_height)
{
    echo(baza_sizes=baza_sizes);
     h = 12;
    baza_sizes = [2 * (rb_external_radius + radial_bearing_vertical_housing_grosime_perete_baza + 4.5), extra_height, h];//rb_thick + radial_bearing_vertical_housing_grosime_perete_lateral_latime];
    difference(){
rotate([90, 0, 0])
        difference(){
color(plastic_color)
        hull(){
        translate ([0, rb_external_radius + extra_height, 0]) cylinder (h = h, r = rb_external_radius + radial_bearing_vertical_housing_grosime_perete_baza, $fn = 100);
            translate ([-baza_sizes[0] / 2, 0, 0]) cube(baza_sizes);
            //translate ([-(rb_external_radius + radial_bearing_vertical_housing_grosime_perete_baza), 0, 0]) cube([2 * (rb_external_radius + radial_bearing_vertical_housing_grosime_perete_baza), rb_external_radius + radial_bearing_vertical_housing_grosime_perete_baza, rb_thick + radial_bearing_vertical_housing_grosime_perete_lateral_latime]);
        }
        translate ([0, rb_external_radius + extra_height, 0] - display_tolerance_z) cylinder (h = h + 2 * display_tolerance, r = rb_external_radius - 2, $fn = 100);
        translate ([0, rb_external_radius + extra_height, 4]) cylinder (h = rb_thick + display_tolerance, r = rb_external_radius, $fn = 100);
    }
    // gauri baza  surub
        translate ([-baza_sizes[0] / 2 + 4, - baza_sizes[2] / 2, 0] - display_tolerance_z) cylinder (h = 11, r = m4_screw_radius, $fn = 30);
    // gaura baza piulitza
    hull(){
        translate ([-baza_sizes[0] / 2 + 4, - baza_sizes[2] / 2, 5] - display_tolerance_z) cylinder (h = 6, r = m4_nut_radius, $fn = 6);
        translate ([-baza_sizes[0] / 2, - baza_sizes[2] / 2, 5] - display_tolerance_z) cylinder (h = 6, r = m4_nut_radius, $fn = 6);
    }
// gauri baza  surub
        translate ([(baza_sizes[0] / 2 - 4), - baza_sizes[2] / 2, 0] - display_tolerance_z) cylinder (h = 11, r = m4_screw_radius, $fn = 30);
        // gaura baza piulitza
    hull(){
        translate ([baza_sizes[0] / 2 - 4, - baza_sizes[2] / 2, 5] - display_tolerance_z) cylinder (h = 6, r = m4_nut_radius, $fn = 6);
        translate ([baza_sizes[0] / 2, - baza_sizes[2] / 2, 5] - display_tolerance_z) cylinder (h = 6, r = m4_nut_radius, $fn = 6);
    }
    }
    
    
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
//--------------------------------------------------------------------
module rbearing_608_vertical_housing_bounded_half()
{
    radial_bearing_vertical_housing_bounded(rbearing_608_vertical_housing_size_bounded_half, rb_608_external_radius,rb_608_thick, 60);
}
//---------------------------------------------------------------------------
module rbearing_608_vertical_housing_bounded_half_small()
{
    radial_bearing_vertical_housing_bounded(rbearing_608_vertical_housing_size_bounded_half_small, rb_608_external_radius,rb_608_thick, 60);
}
//---------------------------------------------------------------------------
module rbearing_608_vertical_housing_bounded_half_small_top()
{
    radial_bearing_vertical_housing_bounded(rbearing_608_vertical_housing_size_bounded_half_small_top, rb_608_external_radius,rb_608_thick, 60);
}
//---------------------------------------------------------------------------
module radial_bearing_608_u_vertical_housing()
{
    radial_bearing_u_vertical_housing(rb_608_external_radius, rb_608_thick, 4);
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
module rbearing_608_housing_double()
{
    radial_bearing_housing(rbearing_608_housing_size, rbearing_608_housing_holes_position, rb_608_external_radius, 2 * rb_608_thick, rbearing_608_housing_size[2] + rb_608_thick, m4_screw_radius, 0, 1);
}
//---------------------------------------------------------------------------
module rbearing_608_housing_with_potentiometer_support()
{
    radial_bearing_housing_with_potentiometer_support(rbearing_608_housing_size, rbearing_608_housing_holes_position, rb_608_external_radius, rb_608_thick, rbearing_608_housing_size[2], m4_screw_radius, 25);
}
//---------------------------------------------------------------------------
module rbearing_6002_housing_with_bearing()
{
    rbearing_6002_housing();
    translate ([0, 0, radial_bearing_housing_grosime_perete_baza]) 6002rs();
}
//---------------------------------------------------------------------------
module rbearing_626_housing_with_bearing()
{
    rbearing_626_housing();
    translate ([0, 0, radial_bearing_housing_grosime_perete_baza]) 626rs();
}
//---------------------------------------------------------------------------
module rbearing_608_housing_with_bearing()
{
    rbearing_608_housing();
    translate ([0, 0, radial_bearing_housing_grosime_perete_baza]) 608rs();
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
  radial_bearing_enclosed_housing_half(rb_608_external_radius + radial_bearing_housing_grosime_perete_lateral, rb_608_external_radius, rb_608_thick);
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
module radial_bearing_6001_vertical_housing()
{
    radial_bearing_vertical_housing(rb_6001_external_radius, rb_6001_thick, rbearing_6001_enclosed_housing_holes_position);
}
//---------------------------------------------------------------------------
module radial_bearing_608_vertical_housing()
{
    radial_bearing_vertical_housing(rb_608_external_radius, rb_608_thick, rbearing_608_enclosed_housing_holes_position);
    echo(rbearing_608_enclosed_housing_holes_position = rbearing_608_enclosed_housing_holes_position);
}
//---------------------------------------------------------------------------
module radial_bearing_6201_vertical_housing(screw_holes_tolerance = 0)
{
    radial_bearing_vertical_housing(rbearing_6201_enclosed_housing_size, rbearing_6201_enclosed_housing_holes_position, screw_holes_tolerance = 0);
    echo(rbearing_6201_enclosed_housing_holes_position = rbearing_6201_enclosed_housing_holes_position);
}
//---------------------------------------------------------------------------
module radial_bearing_608_vertical_housing()
{
    radial_bearing_vertical_housing(rbearing_608_enclosed_housing_size, rbearing_608_enclosed_housing_holes_position);
}
//---------------------------------------------------------------------------
module radial_bearing_698_vertical_housing_touch()
{
    radial_bearing_vertical_housing(rbearing_698_enclosed_housing_touch_size, rbearing_698_enclosed_housing_holes_position);
}
//---------------------------------------------------------------------------
module radial_bearing_608_vertical_housing_slim()
{
    radial_bearing_vertical_housing(rbearing_608_enclosed_housing_slim_size, rbearing_608_enclosed_housing_slim_holes_position, radial_bearing_vertical_housing_grosime_perete_lateral_slim_lungime,
   radial_bearing_vertical_housing_grosime_perete_lateral_slim_lungime, radial_bearing_vertical_housing_grosime_perete_lateral_slim_latime);
}
//---------------------------------------------------------------------------

bearing_housing_with_flaps(18, rb_608_external_radius, rb_608_thick);

//rbearing_608_vertical_housing_bounded_half();

//rbearing_608_vertical_housing_bounded_half_small();

//rbearing_608_vertical_housing_bounded_half_small_top();

//rbearing_608_housing_with_potentiometer_support();

//radial_bearing_608_vertical_housing();

//radial_bearing_608_u_vertical_housing();


//radial_bearing_6201_vertical_housing(screw_holes_tolerance = 0);
//radial_bearing_608_vertical_housing();
//radial_bearing_608_vertical_housing_slim();

//rbearing_6002_housing_with_bearing();

//rbearing_608_housing();
//rbearing_608_housing_double();
//rbearing_608_housing_with_bearing();

//radial_bearing_6002_enclosed_housing(120); // 1x
//radial_bearing_608_enclosed_housing(120);
//radial_bearing_608_enclosed_housing_half_top();
//radial_bearing_608_enclosed_housing_half_bottom(19);

//radial_bearing_6002_enclosed_housing(rb_6002_external_radius + radial_bearing_housing_grosime_perete_lateral); // 2x


//radial_bearing_6002_enclosed_housing_with_nema_holes(120, 3); // 1x

//rbearing_626_housing();

//potentiometer_support_with_screw_holes(25, 47, 13, 31);


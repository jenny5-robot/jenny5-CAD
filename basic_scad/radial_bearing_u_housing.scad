// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_radial_bearings.scad>
include <params_screws_nuts_washers.scad>
include <params_basic_components.scad>
include <config.scad>
include <params_radial_bearings_u_housing.scad>
use <radial_bearings.scad>
use <basic_components.scad>
include <tolerance.scad>
include <params_radial_bearings_housing.scad>

//--------------------------------------------------------------
module radial_bearing_vertical_housing_bounded(housing_size, radial_bearing_external_radius, radial_bearing_thick, vertical_holes_position)
{
    difference(){
        color(plastic_color)
        hull(){
            translate ([-housing_size[0] / 2 + housing_size[1] / 2, 0, 0])  cylinder (h = housing_size[2], r = housing_size[1] / 2);
            translate ([housing_size[0] / 2 - housing_size[1] / 2, 0, 0]) cylinder (h = housing_size[2], r = housing_size[1] / 2);
        }
        
        // bearing hole
        translate ([0, housing_size[1] / 2, housing_size[2]] + display_tolerance_y) rotate ([90, 0, 0]) cylinder (h = housing_size[1] + 2 * display_tolerance, r = radial_bearing_external_radius - 1, $fn = 50);
        
        translate ([0, radial_bearing_thick / 2, housing_size[2]]) rotate ([90, 0, 0]) cylinder (h = radial_bearing_thick, r = radial_bearing_external_radius, $fn = 50);

        // screw holes
       translate (vertical_holes_position[0]) translate (-display_tolerance_z) cylinder (h = housing_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        translate (vertical_holes_position[1]) translate (-display_tolerance_z) cylinder (h = housing_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
    }
}
//--------------------------------------------------------------
module radial_bearing_vertical_housing_bounded_with_horizontal_holes(housing_size, radial_bearing_external_radius, radial_bearing_thick, vertical_holes_position, horizontal_holes_position)
{
     difference(){
        radial_bearing_vertical_housing_bounded(housing_size, radial_bearing_external_radius, radial_bearing_thick, vertical_holes_position);
         for (i = [1 : 4])
             translate ([0, housing_size[1] / 2, housing_size[2]] + display_tolerance_y) rotate ([90, 0, 0]) translate (horizontal_holes_position[i])  cylinder (h = 20, r = 2, $fn = 10);   
     }
}
//--------------------------------------------------------------
module radial_bearing_vertical_housing(housing_size = rbearing_608_enclosed_housing_size, rbearing_enclosed_housing_holes_position = rbearing_608_enclosed_housing_holes_position, grosime_perete_lateral_lungime_exterior = radial_bearing_vertical_housing_wall_thick_external_length, grosime_perete_lateral_lungime_interior = radial_bearing_vertical_housing_wall_thick_internal_length, grosime_perete_lateral_latime = radial_bearing_vertical_housing_wall_thick_width, screw_holes_tolerance = 0)
{
    color(plastic_color)
    render(){
        edge = 2;
        
        rb_thick = housing_size[1] - 2 * grosime_perete_lateral_latime;
        rb_external_radius = housing_size[0] / 2 - (grosime_perete_lateral_lungime_exterior + grosime_perete_lateral_lungime_interior + 2 * m4_screw_radius);

        difference(){
            hull(){
                translate ([-housing_size[0] / 2 + housing_size[1] / 2, 0, 0])  cylinder (h = housing_size[2], r = housing_size[1] / 2);
                translate ([housing_size[0] / 2 - housing_size[1] / 2, 0, 0]) cylinder (h = housing_size[2], r = housing_size[1] / 2);
            }
            // bearing hole
            
            hull(){
                translate ([0, housing_size[1] / 2 - grosime_perete_lateral_latime, radial_bearing_vertical_housing_base_wall_thick + rb_external_radius]) rotate ([90, 0, 0]) cylinder (h =  rb_thick, r = rb_external_radius, $fn = 100);
                translate ([0, housing_size[1] / 2 - grosime_perete_lateral_latime, housing_size[2] ]) rotate ([90, 0, 0]) cylinder (h =  rb_thick, r = rb_external_radius, $fn = 100);
            }
            
            // bearing housing margin
            hull(){
                translate ([0, -housing_size[1] / 2, radial_bearing_vertical_housing_base_wall_thick + rb_external_radius] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h =  housing_size[1] + 2 * display_tolerance, r = rb_external_radius - edge, $fn = 100);
                translate ([0, -housing_size[1] / 2, housing_size[2]] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h =  housing_size[1] + 2 * display_tolerance, r = rb_external_radius - edge, $fn = 100);
            }
            // screw holes
            for (i = [0 : 1]){
                hull(){
                    translate(rbearing_enclosed_housing_holes_position[i] + i * [screw_holes_tolerance, 0, 0]- display_tolerance_z)cylinder (h = housing_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
                    translate(rbearing_enclosed_housing_holes_position[i] + (i + 1) * [screw_holes_tolerance, 0, 0]- display_tolerance_z)cylinder (h = housing_size[2] + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
                }
            }
        }
    }
}
//---------------------------------------------------------------------------
module radial_bearing_dome_housing(rb_external_radius, rb_thick, extra_height)
{
    h = 12;
    baza_sizes = [2 * (rb_external_radius + radial_bearing_vertical_housing_base_wall_thick + 4.5), extra_height, h];//rb_thick + radial_bearing_vertical_housing_wall_thick_width];
    difference(){
rotate([90, 0, 0])
        difference(){
color(plastic_color)
        hull(){
        translate ([0, rb_external_radius + extra_height, 0]) cylinder (h = h, r = rb_external_radius + radial_bearing_vertical_housing_base_wall_thick, $fn = 100);
            translate ([-baza_sizes[0] / 2, 0, 0]) cube(baza_sizes);
            //translate ([-(rb_external_radius + radial_bearing_vertical_housing_base_wall_thick), 0, 0]) cube([2 * (rb_external_radius + radial_bearing_vertical_housing_base_wall_thick), rb_external_radius + radial_bearing_vertical_housing_base_wall_thick, rb_thick + radial_bearing_vertical_housing_wall_thick_width]);
        }
        translate ([0, rb_external_radius + extra_height, 0] - display_tolerance_z) cylinder (h = h + 2 * display_tolerance, r = rb_external_radius - 2, $fn = 100);
        translate ([0, rb_external_radius + extra_height, 4]) cylinder (h = rb_thick + display_tolerance, r = rb_external_radius, $fn = 100);
    }
    // base screw holes
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
module radial_bearing_6001_vertical_housing()
{
    radial_bearing_vertical_housing(rb_6001_external_radius, rb_6001_thick, rbearing_6001_enclosed_housing_holes_position);
}
//---------------------------------------------------------------------------
module radial_bearing_608_vertical_housing()
{
    radial_bearing_vertical_housing(rb_608_external_radius, rb_608_thick, rbearing_608_enclosed_housing_holes_position);
}
//---------------------------------------------------------------------------
module radial_bearing_6201_vertical_housing(screw_holes_tolerance = 0)
{
    radial_bearing_vertical_housing(rbearing_6201_enclosed_housing_size, rbearing_6201_enclosed_housing_holes_position, screw_holes_tolerance = 0);
}
//---------------------------------------------------------------------------
module radial_bearing_6001_vertical_housing(screw_holes_tolerance = 0)
{
    radial_bearing_vertical_housing(rbearing_6001_enclosed_housing_size, rbearing_6001_enclosed_housing_holes_position, screw_holes_tolerance = 0);
}
//---------------------------------------------------------------------------
module radial_bearing_6005_vertical_housing(screw_holes_tolerance = 0)
{
    radial_bearing_vertical_housing(rbearing_6005_enclosed_housing_size, rbearing_6005_enclosed_housing_holes_position, screw_holes_tolerance = 0);
}
//---------------------------------------------------------------------------
module radial_bearing_3205_vertical_housing(screw_holes_tolerance = 0)
{
    radial_bearing_vertical_housing(rbearing_3205_enclosed_housing_size, rbearing_3205_enclosed_housing_holes_position, screw_holes_tolerance = 0);
}
//---------------------------------------------------------------------------
module radial_bearing_6006_vertical_housing(screw_holes_tolerance = 0)
{
    radial_bearing_vertical_housing(rbearing_6006_enclosed_housing_size, rbearing_6006_enclosed_housing_holes_position, screw_holes_tolerance = 0);
}
//---------------------------------------------------------------------------
module radial_bearing_6906_vertical_housing(screw_holes_tolerance = 0)
{
    radial_bearing_vertical_housing(rbearing_6906_enclosed_housing_size, rbearing_6906_enclosed_housing_holes_position, screw_holes_tolerance = 0);
}
//---------------------------------------------------------------------------
module radial_bearing_6905_vertical_housing(screw_holes_tolerance = 0)
{
    radial_bearing_vertical_housing(rbearing_6905_enclosed_housing_size, rbearing_6905_enclosed_housing_holes_position, screw_holes_tolerance = 0);
    
}
//---------------------------------------------------------------------------
module radial_bearing_6905_double_vertical_housing(screw_holes_tolerance = 0)
{
    radial_bearing_vertical_housing(rbearing_6905_enclosed_double_housing_size, rbearing_6905_enclosed_housing_holes_position, screw_holes_tolerance = 0);    
}
//---------------------------------------------------------------------------
module radial_bearing_608_vertical_housing()
{
    radial_bearing_vertical_housing(rbearing_608_enclosed_housing_size, rbearing_608_enclosed_housing_holes_position);
    echo(rbearing_608_enclosed_housing_holes_position);
}
//---------------------------------------------------------------------------
module radial_bearing_698_vertical_housing_touch()
{
    radial_bearing_vertical_housing(rbearing_698_enclosed_housing_touch_size, rbearing_698_enclosed_housing_holes_position);
}
//---------------------------------------------------------------------------
module radial_bearing_608_vertical_housing_slim_double()
{
    radial_bearing_vertical_housing(rbearing_608_enclosed_housing_slim_size, rbearing_608_enclosed_housing_slim_holes_position, radial_bearing_vertical_housing_wall_thick_length_slim,
   radial_bearing_vertical_housing_wall_thick_length_slim, radial_bearing_vertical_housing_wall_thick_width_slim);
translate([0, rbearing_608_enclosed_housing_slim_size[1], 0])
    radial_bearing_vertical_housing(rbearing_608_enclosed_housing_slim_size, rbearing_608_enclosed_housing_slim_holes_position, radial_bearing_vertical_housing_wall_thick_length_slim,
   radial_bearing_vertical_housing_wall_thick_length_slim, radial_bearing_vertical_housing_wall_thick_width_slim);
}
//---------------------------------------------------------------------------
module radial_bearing_6001_vertical_housing_slim_double()
{
    radial_bearing_vertical_housing(rbearing_6001_enclosed_housing_slim_size, rbearing_6001_enclosed_housing_slim_holes_position, radial_bearing_vertical_housing_wall_thick_length_slim,
   radial_bearing_vertical_housing_wall_thick_length_slim, radial_bearing_vertical_housing_wall_thick_width_slim);
    
translate([0, rbearing_6001_enclosed_housing_slim_size[1], 0])
    radial_bearing_vertical_housing(rbearing_6001_enclosed_housing_slim_size, rbearing_6001_enclosed_housing_slim_holes_position, radial_bearing_vertical_housing_wall_thick_length_slim,
   radial_bearing_vertical_housing_wall_thick_length_slim, radial_bearing_vertical_housing_wall_thick_width_slim);
}
//---------------------------------------------------------------------------
module rbearing_6905_vertical_housing_bounded_half_small_extra_height(extra_height = 0)
{
    radial_bearing_vertical_housing_bounded(f_rbearing_6905_vertical_housing_size_bounded_half_small(extra_height), rb_6905_external_radius, rb_6905_thick, rbearing_6905_enclosed_housing_holes_position);
}
//---------------------------------------------------------------------------
module rbearing_6905_vertical_double_housing_bounded_half_small_extra_height(extra_height = 0)
{
    radial_bearing_vertical_housing_bounded(f_rbearing_6905_vertical_double_housing_size_bounded_half_small(extra_height), rb_6905_external_radius, 2 * rb_6905_thick, rbearing_6905_enclosed_housing_holes_position);
}
//---------------------------------------------------------------------------
module rbearing_6905_vertical_housing_bounded_half_with_horizontal_holes()
{
    radial_bearing_vertical_housing_bounded_with_horizontal_holes(housing_size = f_rbearing_6905_vertical_housing_size_bounded_half_small(0), radial_bearing_external_radius = rb_6905_external_radius, radial_bearing_thick = rb_6905_thick, vertical_holes_position = rbearing_6905_enclosed_housing_holes_position, horizontal_holes_position = rbearing_6905_housing_holes_position);
}
//---------------------------------------------------------------------------
module rbearing_6906_vertical_housing_bounded_half_with_horizontal_holes()
{
    radial_bearing_vertical_housing_bounded_with_horizontal_holes(housing_size = f_rbearing_6906_vertical_housing_size_bounded_half_small(0), radial_bearing_external_radius = rb_6906_external_radius, radial_bearing_thick = rb_6906_thick, vertical_holes_position = rbearing_6906_enclosed_housing_holes_position, horizontal_holes_position = rbearing_6906_housing_holes_position);
}
//---------------------------------------------------------------------------
module rbearing_6907_vertical_housing_bounded_half_with_horizontal_holes()
{
    radial_bearing_vertical_housing_bounded_with_horizontal_holes(housing_size = f_rbearing_6907_vertical_housing_size_bounded_half_small(0), radial_bearing_external_radius = rb_6907_external_radius, radial_bearing_thick = rb_6907_thick, vertical_holes_position = rbearing_6907_enclosed_housing_holes_position, horizontal_holes_position = rbearing_6907_housing_holes_position);
}
//---------------------------------------------------------------------------
module radial_bearing_608_dome_housing()
{
    radial_bearing_dome_housing(rb_608_external_radius, rb_608_thick, 4);
}
//---------------------------------------------------------------------------
module rbearing_6909_vertical_housing_half()
{
    radial_bearing_vertical_housing_bounded(housing_size = rbearing_6909_vertical_housing_size_half, radial_bearing_external_radius = rb_6909_external_radius, radial_bearing_thick = rb_6909_thick, vertical_holes_position = rbearing_6909_enclosed_housing_holes_position);
}
//---------------------------------------------------------------------------

//rbearing_6909_vertical_housing_half();

//radial_bearing_608_vertical_housing();

// radial_bearing_608_dome_housing();


// radial_bearing_6201_vertical_housing(screw_holes_tolerance = 0);
// radial_bearing_6001_vertical_housing(screw_holes_tolerance = 0);


//rbearing_6905_vertical_housing_bounded_half_small_extra_height(0);

//radial_bearing_6005_vertical_housing(0);

//radial_bearing_6905_double_vertical_housing();


//radial_bearing_6906_vertical_housing();
//radial_bearing_6905_vertical_housing();


//rbearing_6905_vertical_housing_bounded_half_with_horizontal_holes();

//rbearing_6906_vertical_housing_bounded_half_with_horizontal_holes();
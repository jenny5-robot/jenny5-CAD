include <params_screws_nuts_washers.scad>
include <params_basic_components.scad>
include <params_radial_bearings.scad>
include <config.scad>

use <screws_nuts_washers.scad>
use <radial_bearings.scad>


//---------------------------------------------------------------------------
module belt_tensioner_bearing_holder(lungime, latime, grosime_perete)
{
    difference(){
        color(plastic_color) cube([lungime, latime, grosime_perete]);
        translate ([6, latime / 2, 0] - display_tolerance_z) cylinder(h = grosime_perete + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
        translate ([lungime - 6, latime / 2, 0] - display_tolerance_z) cylinder(h = grosime_perete + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
    }
}
//---------------------------------------------------------------------------
module belt_tensioner_base()
{
    grosime_perete = 3;
    bone_thick = 10;

    h = 13 - grosime_perete;
    lungime = h + grosime_perete + bone_thick + 3 + m4_nut_thick;
    grosime = 12;
    latime = bone_thick + 2 * grosime_perete;
    lungime_bearing_holder = 2 * washer_4_12_radius + latime + 2 * rb_624_external_radius;
    difference(){
        union(){
            color(plastic_color) cube([lungime, latime, grosime]);
            translate ([lungime -0.1, -lungime_bearing_holder / 2 + latime / 2, 0]) rotate ([90, 0, 90]) belt_tensioner_bearing_holder(lungime_bearing_holder, grosime, grosime_perete);
        }
        // gaura os
        translate([grosime_perete + m4_nut_thick, grosime_perete - 0.2, 0] - display_tolerance_z) cube([bone_thick + 3, bone_thick + 2 * 0.2, grosime] + 2 * display_tolerance_z);
        // gaura m4 screw
        translate([0, latime / 2, grosime / 2] - display_tolerance_x) rotate([0, 90, 0]) cylinder (h = 10, r = m4_screw_radius, $fn = 30);
        translate([grosime_perete, latime / 2, grosime / 2]) rotate([0, 90, 0]) cylinder (h = 10, r = m4_nut_radius, $fn = 6);
    }
}
//---------------------------------------------------------------------------
module belt_tensioner_housing(h)
{
    difference(){
        color (plastic_color) cube([2 * wall_thick_3 + 2 * washer_5_15_external_radius, wall_thick_3 + 4 * washer_4_12_radius, h]);
        // remove middle
        translate ([wall_thick_3, wall_thick_3, wall_thick_3]) cube([2 * washer_5_15_external_radius, 4 * washer_4_12_radius, h] + display_tolerance_y);
        // remove half
        translate ([0, wall_thick_3 + 4 * washer_4_12_radius, wall_thick_3] - display_tolerance_x) rotate([atan((wall_thick_3 + 4 * washer_4_12_radius)/ h), 0, 0]) cube([2 * wall_thick_3 + 2 * washer_5_15_external_radius, wall_thick_3 + 4 * washer_4_12_radius, sqrt(h*h + (wall_thick_3 + 4 * washer_4_12_radius) * (wall_thick_3 + 4 * washer_4_12_radius))] + 2 * display_tolerance_x);
        // base screw holes
        translate ([wall_thick_3 + washer_5_15_external_radius, wall_thick_3 + washer_4_12_radius, 0] - display_tolerance_z) cylinder (h = wall_thick_3 + 2 * display_tolerance, r = m4_screw_radius, $fn = 10); 

        translate ([wall_thick_3 + washer_5_15_external_radius, wall_thick_3 + 3 * washer_4_12_radius, 0] - display_tolerance_z) cylinder (h = wall_thick_3 + 2 * display_tolerance, r = m4_screw_radius, $fn = 10); 
        
        //bearing screw hole
hull(){
        translate ([wall_thick_3 + washer_5_15_external_radius, 0, wall_thick_3 + washer_5_15_external_radius] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h = wall_thick_3 + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
        translate ([wall_thick_3 + washer_5_15_external_radius, 0, h - washer_5_15_external_radius] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h = wall_thick_3 + 2 * display_tolerance, r = m4_screw_radius, $fn = 10);
}
    }
}
//---------------------------------------------------------------------------
module belt_tensioner_slider()
{
    M4x25_hexa();
    translate ([0, 0, m4_nut_thick]) M4x9_washer();
    translate ([0, 0, m4_nut_thick + 1]) washer_4_15();
    translate ([0, 0, m4_nut_thick + 1 + 1 + wall_thick_3]) washer_4_15();
    translate ([0, 0, m4_nut_thick + 1 + 1 + 1 + wall_thick_3]) washer_4_9();

    translate ([0, 0, m4_nut_thick + 1 + wall_thick_3 + 1 + 2]) 624rs();
    translate ([0, 0, m4_nut_thick + 1 + 4 + rb_624_thick + 2]) 624rs();
    translate ([0, 0, m4_nut_thick + 1 + 3 + 2 * rb_624_thick + wall_thick_3]) washer_4_9();
    translate ([0, 0, m4_nut_thick + 1 + 2 * rb_624_thick + 4 + wall_thick_3]) M4_autolock_nut();
}
//---------------------------------------------------------------------------
module belt_tensioner(h, dist_to_bearings)
{
    
    belt_tensioner_housing(h);

// screw
    translate ([wall_thick_3 + washer_5_15_external_radius, m4_nut_thick + 2 + 3, wall_thick_3 + washer_5_15_external_radius + dist_to_bearings]) rotate ([90, 0, 0]) {
        belt_tensioner_slider();
    }
}
//---------------------------------------------------------------------------
belt_tensioner(30, 10);

//belt_tensioner_base();

//belt_tensioner_slider();
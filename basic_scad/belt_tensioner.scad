include <params_screws_nuts_washers.scad>
include <params_basic_components.scad>
include <params_radial_bearings.scad>
include <config.scad>


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

belt_tensioner_base();
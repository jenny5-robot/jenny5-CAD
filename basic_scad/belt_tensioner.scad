// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_screws_nuts_washers.scad>
include <params_basic_components.scad>
include <params_radial_bearings.scad>
include <config.scad>

use <screws_nuts_washers.scad>
use <radial_bearings.scad>


//---------------------------------------------------------------------------
module belt_tensioner_cover(length, width)
{
    wall_thick = 3;
    difference(){
        color(plastic_color) cube([length, width, wall_thick]);
        translate ([washer_4_12_radius, width / 2, 0] - display_tolerance_z) cylinder(h = wall_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
        translate ([length - washer_4_12_radius, width / 2, 0] - display_tolerance_z) cylinder(h = wall_thick + 2 * display_tolerance, r = m4_screw_radius, $fn = 30);
    }
}
//---------------------------------------------------------------------------
module belt_tensioner_base(length)
{
    wall_thick = 3;
    bone_thick = 10;

    h = 13 - wall_thick;
    
    thick = 12;
    width = bone_thick + 2 * wall_thick;
    bearing_cover_length = 4 * washer_4_12_radius + width;
    
    difference(){
        union(){
            color(plastic_color) cube([length, width, thick]);
            translate ([length - 0.01, -bearing_cover_length / 2 + width / 2, 0]) rotate ([90, 0, 90]) belt_tensioner_cover(bearing_cover_length, thick, wall_thick);
        }
        // bone hole
        translate([wall_thick + m4_nut_thick, wall_thick - 0.2, 0] - display_tolerance_z) cube([bone_thick + 2, bone_thick + 2 * 0.2, thick] + 2 * display_tolerance_z);
        // m4 screw hole
        translate([0, width / 2, thick / 2] - display_tolerance_x) rotate([0, 90, 0]) cylinder (h = 10, r = m4_screw_radius, $fn = 30);
        // m4 nut hole
        translate([wall_thick, width / 2, thick / 2]) rotate([0, 90, 0]) cylinder (h = 10, r = m4_nut_radius, $fn = 6);
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
module belt_tensioner_prism(h, dist_to_bearings)
{
    
    belt_tensioner_housing(h);

// screw
    translate ([wall_thick_3 + washer_5_15_external_radius, m4_nut_thick + 2 + 3, wall_thick_3 + washer_5_15_external_radius + dist_to_bearings]) rotate ([90, 0, 0]) {
        belt_tensioner_slider();
    }
}
//---------------------------------------------------------------------------
module belt_tensioner_with_branch(h)
{
    belt_tensioner_base(h);

    // right side bearings
    translate ([h - 3, -washer_4_12_radius, washer_4_12_radius]) rotate ([0, 90, 0]) M4x25_hexa();
    translate ([h + 3, -washer_4_12_radius, washer_4_12_radius]) rotate ([0, 90, 0]) washer_4_9();
    translate ([h + 3 + 1, -washer_4_12_radius, washer_4_12_radius]) rotate ([0, 90, 0]) 624rs();
    translate ([h + 3 + 1 + rb_624_thick, -washer_4_12_radius, washer_4_12_radius]) rotate ([0, 90, 0]) 624rs();
    translate ([h + 3 + 1 + 2 * rb_624_thick, -washer_4_12_radius, washer_4_12_radius]) rotate ([0, 90, 0]) washer_4_9();
    translate ([h + 3 + 1 + 2 * rb_624_thick + 1 + wall_thick_3, -washer_4_12_radius, washer_4_12_radius]) rotate ([0, 90, 0]) washer_4_9();
    translate ([h + 3 + 1 + 2 * rb_624_thick + 1 + wall_thick_3 + 1, -washer_4_12_radius, washer_4_12_radius]) rotate ([0, 90, 0]) M4_autolock_nut();

    thick = 12;
    bone_thick = 10;
    width = bone_thick + 2 * wall_thick_3;

    // left side bearings
    translate ([h - 3, width + washer_4_12_radius, washer_4_12_radius]) rotate ([0, 90, 0]) M4x25_hexa();
    translate ([h + 3, width + washer_4_12_radius, washer_4_12_radius]) rotate ([0, 90, 0]) washer_4_9();
    translate ([h + 3 + 1, width + washer_4_12_radius, washer_4_12_radius]) rotate ([0, 90, 0]) 624rs();
    translate ([h + 3 + 1 + rb_624_thick, width + washer_4_12_radius, washer_4_12_radius]) rotate ([0, 90, 0]) 624rs();
    translate ([h + 3 + 1 + 2 * rb_624_thick, width + washer_4_12_radius, washer_4_12_radius]) rotate ([0, 90, 0]) washer_4_9();
    translate ([h + 3 + 1 + 2 * rb_624_thick + 1 + wall_thick_3, width + washer_4_12_radius, washer_4_12_radius]) rotate ([0, 90, 0]) washer_4_9();
    translate ([h + 3 + 1 + 2 * rb_624_thick + 1 + wall_thick_3 + 1, width + washer_4_12_radius, washer_4_12_radius]) rotate ([0, 90, 0]) M4_autolock_nut();

// cover
    bearing_cover_length = 4 * washer_4_12_radius + width;
    translate ([h + 3 + 1 + 2 * rb_624_thick + 1, -bearing_cover_length / 2 + width / 2, 0]) rotate ([90, 0, 90]) belt_tensioner_cover(bearing_cover_length, thick);

    
}
//---------------------------------------------------------------------------
//belt_tensioner_with_branch(31);

//belt_tensioner_housing(20);

//belt_tensioner_prism(30, 10);

//belt_tensioner_base(31);

belt_tensioner_cover(40, 12);

//belt_tensioner_slider();
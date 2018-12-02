// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_screws_nuts_washers.scad>
include <params_basic_components.scad>
include <params_radial_bearings.scad>
include <params_belt_tensioner.scad>
include <config.scad>
include <tolerance.scad>

use <screws_nuts_washers.scad>
use <radial_bearings.scad>
include <as5147_params.scad>

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
module belt_tensioner_external_half()
{

    size = belt_tensioner_external_size;
    
    difference(){
        union(){
            hull(){
                cylinder(h = size[2] / 2, r = size[1] / 2, $fn = 40);
                translate([size[0], 0, 0]) cylinder(h = size[2] / 2, r = size[1] / 2, $fn = 40);
            }
            
            hull(){
                translate([size[0] / 2, 2, 0]) cylinder(h = size[2] / 2, r = rb_624_external_radius);
                translate([size[0] / 2, pusher_length + 1, 0]) cylinder(h = size[2] / 2, r = rb_624_external_radius);
            }
        }
        
        // remove middle part
        hull(){
          translate([size[0] / 2, 6 + 3, wing_thick]) cylinder(h = size[2] - 2 * wing_thick, r = rb_624_external_radius + 1, $fn = 40);
          translate([size[0] / 2, pusher_length + 1 + 3, wing_thick]) cylinder(h = size[2] - 2 * wing_thick, r = rb_624_external_radius + 1, $fn = 40);
        }
        
        // fixer screw holes
        translate ( - display_tolerance_z) cylinder(h = size[2] + 2 * display_tolerance, r = 2, $fn = 20);
        translate([size[0], 0, 0] - display_tolerance_z) cylinder(h = size[2] + 2 * display_tolerance, r = 2, $fn = 20);
        
        // shaft hole
        hull(){
            translate([size[0] / 2, 6 + 3, 0] - display_tolerance_z) cylinder(h = size[2] + 2 * display_tolerance, r = 2, $fn = 20);
            translate([size[0] / 2, pusher_length, 0] - display_tolerance_z) cylinder(h = size[2] + 2 * display_tolerance, r = 2, $fn = 20);
        }
        
        // pusher screw 1
        translate ([size[0] / 2, -7, wing_thick / 2]) rotate ([-90, 0, 0]) cylinder (h = 20, r = m4_screw_radius, $fn = 20);
        // pusher screw 2
        translate ([size[0] / 2, -7, size[2] - wing_thick / 2]) rotate ([-90, 0, 0]) cylinder (h = 20, r = m4_screw_radius, $fn = 20);

        // pusher nut 1
        hull(){
            translate ([size[0] / 2, -2, wing_thick / 2]) rotate ([-90, 30, 0]) cylinder (h = m4_nut_thick, r = m4_nut_radius, $fn = 6);
            translate ([size[0] / 2, -2, 0]) rotate ([-90, 30, 0]) cylinder (h = m4_nut_thick, r = m4_nut_radius, $fn = 6);
        }
        // pusher nut 2
        hull(){
            translate ([size[0] / 2, -2, size[2] - wing_thick / 2]) rotate ([-90, 30, 0]) cylinder (h = m4_nut_thick, r = m4_nut_radius, $fn = 6);
            translate ([size[0] / 2, -2, size[2]]) rotate ([-90, 30, 0]) cylinder (h = m4_nut_thick, r = m4_nut_radius, $fn = 6);
        }
    }
}
//---------------------------------------------------------------------------
module belt_tensioner_external_with_bearings(position = 10)
{
    belt_tensioner_external_half();
    translate ([0, 0, belt_tensioner_external_size[2]]) mirror([0, 0, 1]) belt_tensioner_external_half();

    translate ([belt_tensioner_external_dist_between_holes / 2, 8 + position, 0]){
        translate ([0, 0, 28]) mirror([0, 0, 1]) M4_hexa(25);
    
        translate ([0, 0, 6]) washer_4_12();
        translate ([0, 0, 6 + 1]) 624rs();
        translate ([0, 0, 6 + 1 + rb_624_thick]) 624rs();
        translate ([0, 0, 6 + 1 + 2 * rb_624_thick]) washer_4_12();
    }
}
//---------------------------------------------------------------------------
module belt_tensioner_spacer(distance_between_screws)
{
    length = distance_between_screws + 2 * m4_nut_radius + 2 * wall_thick_2;
    height = 5;
    difference(){
        translate ([- length / 2, -6, 0]) cube([length, 12, height]);
// first screw
        translate ([-distance_between_screws / 2, 0, 0] - display_tolerance_z) cylinder(h = height + 2 * display_tolerance, r = 2);
        translate ([-distance_between_screws / 2, 0, height - m4_nut_thick]) cylinder(h = height + 2 * display_tolerance, r = m4_nut_radius, $fn = 6);
// second screw hole
        translate ([distance_between_screws / 2, 0, 0] - display_tolerance_z) cylinder(h = height + 2 * display_tolerance, r = 2);
        translate ([distance_between_screws / 2, 0, height - m4_nut_thick]) cylinder(h = height + 2 * display_tolerance, r = m4_nut_radius, $fn = 6);
    }
}
//---------------------------------------------------------------------------

//belt_tensioner_spacer(28);


//belt_tensioner_external_with_bearings(0);

//belt_tensioner_external_half();

//belt_tensioner_with_branch(31);

//belt_tensioner_housing(20);

//belt_tensioner_prism(30, 10);

//belt_tensioner_base(31);

//belt_tensioner_cover(40, 12);

//belt_tensioner_slider();
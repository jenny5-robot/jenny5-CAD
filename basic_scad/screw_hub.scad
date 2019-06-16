// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: https://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

//include <params_basic_components.scad>
include <config.scad>
include <tolerance.scad>
include <screw_hub_params.scad>

//--------------------------------------------------------------
module screw_hub(internal_radius, large_external_radius, small_external_radius, large_cylinder_thick, small_cylinder_thick, screws_hole_radius, distance_between_screws_hole)
{
    difference(){
        union(){
            color(aluminium_color) cylinder(h = large_cylinder_thick, r = large_external_radius);
            translate ([0, 0, large_cylinder_thick]) color(aluminium_color) cylinder(h = small_cylinder_thick, r = small_external_radius);
        }
        // shaft hole
        translate (-display_tolerance_z) cylinder(h = large_cylinder_thick + small_cylinder_thick + 2 * display_tolerance, r = internal_radius, $fn = 20);
        // screw holes
        for (i = [0 : 3])
            rotate([0, 0, i * 90])
        translate([0, distance_between_screws_hole * sqrt(2) / 2, 0] - display_tolerance_z)
        cylinder(h = large_cylinder_thick + 2 * display_tolerance, r = screws_hole_radius, $fn = 15);
    }
}
//--------------------------------------------------------------

screw_hub(internal_radius = 10mm_internal_radius, 
large_external_radius = 10mm_large_external_radius, 
small_external_radius = 10mm_small_external_radius, 
large_cylinder_thick = 10mm_large_cylinder_thick, 
small_cylinder_thick = 10mm_small_cylinder_thick, 
screws_hole_radius = 10mm_screws_hole_radius, 
distance_between_screws_hole = 10mm_distance_between_screws_hole
);
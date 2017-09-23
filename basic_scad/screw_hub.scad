include <params_basic_components.scad>
include <config.scad>

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

screw_hub(internal_radius = 5, large_external_radius = 20, small_external_radius = 10, large_cylinder_thick = 6, small_cylinder_thick = 8, screws_hole_radius = 2.5, distance_between_screws_hole = 22);
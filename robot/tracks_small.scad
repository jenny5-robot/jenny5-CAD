// Author: Mihai Oltean, https://mihaioltean.github.io, mihai.oltean@gmail.com
// More details: http://jenny5.org, https://jenny5-robot.github.io/
// Source code: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------


include <../basic_scad/params_radial_bearings.scad>
use <../basic_scad/radial_bearings.scad>

include <../basic_scad/params_basic_components.scad>

include <../basic_scad/config.scad>
use <../basic_scad/screws_nuts_washers.scad>
use <../basic_scad/basic_components.scad>
include <../basic_scad/tolerance.scad>
include <../basic_scad/params_screws_nuts_washers.scad>
include <base_platform_params.scad>
use <../basic_scad/involute_gears.scad>

//----------------------------------------------
module small_tracks_sheet()
{
    difference(){
        color(aluminium_color) cube(small_tracks_sheet_size);
        // shaft hole
        translate ([small_tracks_wheel_distance_to_shaft, small_tracks_sheet_size[1] / 2, 0] - display_tolerance_z)
        cylinder (h = small_tracks_sheet_size[2] + 2 * display_tolerance, r = 22);
            // wheel bearings hole
        translate ([small_tracks_wheel_distance_to_wheel, small_tracks_sheet_size[1] / 2, 0] - display_tolerance_z)
        cylinder (h = small_tracks_sheet_size[2] + 2 * display_tolerance, r = 15);
    }
}
//----------------------------------------------
module small_track()
{
    small_tracks_sheet();
    // traction gear
    translate ([small_tracks_wheel_distance_to_shaft, small_tracks_sheet_size[1] / 2, small_tracks_sheet_size[2]])
    gear (number_of_teeth = 40,
					circular_pitch = 500,
					bore_diameter = 10,
					hub_diameter = 30,
					rim_width = 4,
					hub_thickness = small_tracks_wheel_radius_thickness,
					rim_thickness = small_tracks_wheel_radius_thickness,
					gear_thickness = small_tracks_wheel_radius_thickness,
					pressure_angle = 31);
    // wheel
    translate ([small_tracks_wheel_distance_to_wheel, small_tracks_sheet_size[1] / 2, small_tracks_sheet_size[2]])
        cylinder(h= small_tracks_wheel_radius_thickness, r = small_tracks_wheel_radius);
    // other sheet
    translate ([0, 0, small_tracks_sheet_size[2] + small_tracks_wheel_radius_thickness])
    small_tracks_sheet();
}

//----------------------------------------------

small_track();
// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License

include <params_tracks.scad>
use <../basic_scad/belt.scad>
include <../basic_scad/config.scad>
include <../basic_scad/params_basic_components.scad>
use <../basic_scad/involute_gears.scad>
use <../basic_scad/pulleys.scad>
include <../basic_scad/params_screws_nuts_washers.scad>

include <../basic_scad/tolerance.scad>

//--------------------------------------------------------------------
module wheel_with_teeths(external_radius = 50, height = 50)// radius = 42, steps = 12
{
    cylinder (h = height, r = external_radius);
}
//--------------------------------------------------------------------
module second_wheel_with_shaft(wheel_radius)
{
    wheel_with_teeths();
}
//--------------------------------------------------------------------
module first_wheel_with_shaft(wheel_radius)
{
    wheel_with_teeths();
    color (aluminium_color) cylinder (h = track_shaft_length, r = 12.5);
}

//--------------------------------------------------------------------
module track_lateral_sheet(thick = 5, radius = 25)
{
    color ("black")
    hull(){
        cylinder(h = thick, r = radius);
        translate ([distance_between_track_wheels, 0, 0]) cylinder(h = thick, r = radius);
    }
}
//--------------------------------------------------------------------

module track_gear()
{    
    difference(){
        rotate ([0, 0, 12]) 
        color(plastic_color)
        gear (number_of_teeth=45,
					circular_pitch=_circular_pitch,
					bore_diameter=0,
					hub_diameter=0,
					rim_width=4,
					hub_thickness=4,
					rim_thickness=wheel_gear_height,
					gear_thickness=wheel_gear_height,
					pressure_angle=31);
        // M12 screw hole
        translate (-display_tolerance_z) cylinder(h = wheel_gear_height + 2 * display_tolerance, r = 6, $fn = 40);
        // M12 nut hole
        translate ([0, 0, wheel_gear_height - wheel_gear_nut_depth]) cylinder(h = wheel_gear_nut_depth + display_tolerance, r = M12_nut_radius, $fn = 6);
    }
}
//--------------------------------------------------------------------
module base_shaft_gear()
{    
    difference(){
        rotate ([0, 0, 12]) 
        color(plastic_color)
        gear (number_of_teeth=20,
					circular_pitch=500,
					bore_diameter=0,
					hub_diameter=0,
					rim_width=4,
					hub_thickness=4,
					rim_thickness=wheel_gear_height,
					gear_thickness=wheel_gear_height,
					pressure_angle=31);
        // M12 screw hole
        translate (-display_tolerance_z) cylinder(h = wheel_gear_height + 2 * display_tolerance, r = 6, $fn = 40);
        // M12 nut hole
        translate ([0, 0, wheel_gear_height - wheel_gear_nut_depth]) cylinder(h = wheel_gear_nut_depth + display_tolerance, r = M12_nut_radius, $fn = 6);
    }
}
//--------------------------------------------------------------------
module base_shaft_pulley()
{    
    difference(){
        pulley(profile = "T5mm_pulley", num_teeth = 29, pulley_b_ht = 7, pulley_b_dia = 17, pulley_t_ht = 8);
        // M12 screw hole
        translate (-display_tolerance_z) cylinder(h = wheel_gear_height + 2 * display_tolerance, r = 12.5, $fn = 40);
    }
}
//--------------------------------------------------------------------


module track()
{
  //first gear
  rotate([-90, 0, 0]) first_wheel_with_shaft(tracks_wheel_radius);
    
   //second gear
  translate ([distance_between_track_wheels, 0, 0]) rotate([-90, 0, 0]) second_wheel_with_shaft(tracks_wheel_radius);
// belt
  rotate([-90, 0, 0])
    color ("gray")
        belt_on_2_pulleys(r1 = 50, r2 = 50, distance_between_pulleys = distance_between_track_wheels, belt_width = 50, belt_thick = 10);
    
    // sides
  translate ([0, -5, 0])
    rotate([-90, 0, 0])
      track_lateral_sheet(thick = 5, radius = 25);
// other side
  translate ([0, 50, 0])
    rotate([-90, 0, 0])
      track_lateral_sheet(thick = 5, radius = 25);
        
    // shaft pulley for connecting front-back tracks
  translate ([0, shaft_pulley_offset, 0]) rotate ([-90, 0, 0]) base_shaft_pulley();
}
//--------------------------------------------------------------------
module track_with_rotation_gear()
{
    track();
        // gear for rotating the entire track
    translate ([0, 55, 0]) rotate ([-90, 0, 0]) track_gear();
}
//--------------------------------------------------------------------
module track_with_move_gear()
{
    track();
        // shaft gear 
  translate ([0, 125, 0]) rotate ([-90, 0, 0]) base_shaft_gear();

}
//--------------------------------------------------------------------
track_with_rotation_gear();
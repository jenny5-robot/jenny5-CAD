// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <../basic_scad/params_basic_components.scad>
include <../basic_scad/params_screws_nuts_washers.scad>
use <../basic_scad/screws_nuts_washers.scad>
include <params_tracks.scad>
include <../basic_scad/config.scad>

//--------------------------------------------------------------------
module track(length = 25, width = 60, height = 8)
{
    togue_width = width / 5;
    
    hole_radius = 1.2;
    togue_tolerance = 1.2;
    togue_width_tolerance = 0.5;

    big_interior_hole_size = 10;
    small_interior_hole_size = big_interior_hole_size - height;

  union(){
	difference(){
		union(){
			color (plastic_color){ 
                cube(size=[length, width, height], center = false);
                rotate([-90,0,0]) translate([length, -height / 2, 0]) cylinder(h = width, r = height / 2, $fn = 40, center = false);
                rotate([-90,0,0]) translate([0,-height / 2, 0]) cylinder(h=width, r = height / 2, $fn = 40, center = false);
            }
		}

// holes for screws for connecting to the other track
		rotate([-90, 0, 0]) translate([length, -height / 2, 0] - display_tolerance_z) cylinder(h = width + 2 * display_tolerance, r = hole_radius, $fn = 20, center = false);
		rotate([-90, 0, 0]) translate([0, -height / 2, 0] - display_tolerance_z) cylinder(h = width + 2 * display_tolerance, r = hole_radius, $fn = 20, center = false);
        
        // wire stopper
        translate ([0, 0, height / 2]) rotate ([0, 90, 0]) cylinder (h = 15, r = hole_radius, $fn = 20);
        translate ([0, width, height / 2]) rotate ([0, 90, 0]) cylinder (h = 15, r = hole_radius, $fn = 20);
// front
// center
		translate([length - height / 2 - togue_tolerance / 2, (width - togue_width) / 2 - togue_width_tolerance, 0] - display_tolerance_z) cube([height + togue_tolerance, togue_width + 2 * togue_width_tolerance , height + 2 * display_tolerance], center = false);
// margins
		translate([length - height / 2 - togue_tolerance / 2, 0, 0] - display_tolerance_yz) cube([height + togue_tolerance, togue_width + togue_width_tolerance, height] + 2 * display_tolerance_z + display_tolerance_y, center = false);
		translate([length - height / 2 - togue_tolerance / 2, width - togue_width - togue_width_tolerance, 0] - display_tolerance_z) cube([height + togue_tolerance, togue_width + togue_width_tolerance, height] + 2 * display_tolerance_z + display_tolerance_y, center = false);
	
// the other side
		translate([-height / 2, togue_width - togue_width_tolerance, 0] - display_tolerance_z) cube([height + togue_tolerance, togue_width + 2 * togue_width_tolerance, height] + 2 * display_tolerance_z, center = false);
		translate([-height / 2, width / 2 + togue_width / 2 - togue_width_tolerance, 0] - display_tolerance_z) cube([height + togue_tolerance, togue_width + 2 * togue_width_tolerance, height] + 2 * display_tolerance_z, center = false);

// circular middle holes for wheel bumps
        translate([length / 2, width / 2, 0]) cylinder(h = height + 0.001, r1 = 2, r2 = 6, $fn = 40);
        translate([length / 2, width / 2, 0] - display_tolerance_z) cylinder(h = 2 * display_tolerance, r = 2, $fn = 40);
	}
  }
}
//--------------------------------------------------------------------
module tracks_on_circle(num_max_tracks, wheel_radius, start_angle = 0, num_tracks)
{
  step = 360 / num_max_tracks;
    
    for (i = [0 : num_tracks - 1]){
        angle = i * step;  
        rotate([0, 0, start_angle])
        translate ([wheel_radius * sin(angle), wheel_radius * cos(angle), 0]) 
            
        rotate ([0, 0, -angle]) 
                rotate ([90, 0, 0]) 
                    translate ([-track_size[1]/2, -track_size[0] / 2, -track_size[2]]) track(track_size[1], track_size[0], track_size[2]);
    }
}
//--------------------------------------------------------------------
module string_of_tracks (num_tracks)
{
    for (i = [0 : num_tracks - 1]){
        translate ([i * 25, 0, 0]) track(track_size[1], track_size[0], track_size[2]);
    }
}
//--------------------------------------------------------------------
//track(length = 25, width = 80, height = 8);

tracks_on_circle(16, 58.8, 90, 10);

//tracks_on_circle(6, 17.7, 90, 6);

//string_of_tracks (10);


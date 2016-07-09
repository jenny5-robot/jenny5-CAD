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
module track(length = 25, width = 60, zh = 8)
{
    roundness = 100;

    togue_width = 12;
    
    hole_radius = 2;
    togue_tolerance = 1.2;

    big_interior_hole_size = 10;
    small_interior_hole_size = big_interior_hole_size - zh;

  union(){
	difference(){
		union(){
			color (plastic_color){ 
                cube(size=[length, width, zh], center = false);
                rotate([-90,0,0]) translate([length,-zh/2,0]) cylinder(h=width, r = zh/2, $fn = roundness, center = false);
                rotate([-90,0,0]) translate([0,-zh/2,0]) cylinder(h=width, r = zh/2, $fn = roundness, center = false);
            }
		}
        // holes for future use
        translate ([length / 2, 10, 0] - display_tolerance_z) cylinder (h = zh + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
        translate ([length / 2, 10, zh - 3]) cylinder (h = zh + display_tolerance, r = m3_nut_radius + 0.2, $fn = 20);
// other side
        translate ([length / 2, width - 10, 0] - display_tolerance_z) cylinder (h = zh + 2 * display_tolerance, r = m3_screw_radius, $fn = 20);
        translate ([length / 2, width - 10, zh - 3]) cylinder (h = zh + display_tolerance, r = m3_nut_radius + 0.2, $fn = 20);
        
// holes for screws
		rotate([-90,0,0]) translate([length,-zh/2,0]) cylinder(h = width + 1, r = hole_radius, $fn = roundness, center = false);
		rotate([-90,0,0]) translate([0,-zh/2,0]) cylinder(h = width + 1, r = hole_radius+0.1, $fn = roundness, center = false);
// front
// center
		translate([length - zh/2 - togue_tolerance/2, (width-togue_width) / 2-togue_tolerance, 0] - display_tolerance_z) cube([zh + togue_tolerance, togue_width+2*togue_tolerance , zh + 2 * display_tolerance], center = false);
// margins
		translate([length - zh/2 - togue_tolerance/2, -0.001,0] - display_tolerance_z) cube([zh + togue_tolerance, (width -3*togue_width)/2+0.5 , zh + 2 * display_tolerance], center = false);
		translate([length - zh/2 - togue_tolerance/2, width/2 + 3*togue_width/2 - 0.5, 0] - display_tolerance_z) cube([zh + togue_tolerance, (width -3*togue_width)/2+1 , zh + 2 * display_tolerance], center = false);
	
// back
		translate([-zh/2, -1,0] - display_tolerance_z) cube([zh + togue_tolerance, (width - togue_width)/2 + 1, zh + 2 * display_tolerance], center = false);
		translate([-zh/2, width/2 + togue_width/2 ,0] - display_tolerance_z) cube([zh + togue_tolerance, (width - togue_width)/2 + display_tolerance, zh + 2 * display_tolerance], center = false);


// circular middle holes for tracking
        translate([length / 2, width / 2, 0]) cylinder(h = zh, r1 = 2, r2 = 6, $fn= roundness);
        translate([length / 2, width / 2, 0] - display_tolerance_z) cylinder(h = 2 * display_tolerance, r = 2, $fn= roundness);
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
                    translate ([-25/2, -60 / 2, -8]) track();
     /*       
        rotate([0, 0, start_angle])
          translate ([(wheel_radius + track_size[2] / 2) * sin(angle + step / 2), (wheel_radius + track_size[2] / 2) * cos(angle + step / 2), 0]){ 
            translate ([0, 0, - track_size[0] / 2 + 9]) M4x40_screw();
            translate ([0, 0, track_size[0] / 2 - 12]) M4_autolock_nut();
          }
        */
    }
}
//--------------------------------------------------------------------
module string_of_tracks (num_tracks)
{
    for (i = [0 : num_tracks - 1]){
        translate ([i * 25, 0, 0]) track();
        translate ([i * 25, 9, 4]) rotate([-90, 0, 0]) M4x40_screw();
        translate ([i * 25, track_size[0] - 12, 4]) rotate([-90, 0, 0]) M4_autolock_nut();
    }
}
//--------------------------------------------------------------------
track();

//tracks_on_circle(12, 42.5, 90, 10);

//string_of_tracks (10);


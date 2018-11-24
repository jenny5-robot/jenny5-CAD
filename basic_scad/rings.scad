// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_basic_components.scad>
include <params_screws_nuts_washers.scad>
include <tolerance.scad>

//-------------------------------------------------------------
module ring(external_radius, internal_radius, height)
{
    
    difference(){
        cylinder(h = height, r = external_radius, $fn = 50);
        translate (-display_tolerance_z) cylinder(h = height + 2 * display_tolerance, r = internal_radius, $fn = 50);
    }
}
//-------------------------------------------------------------
module open_ring(external_radius, internal_radius, height)
{
    
    difference(){
        cylinder(h = height, r = external_radius, $fn = 50);
        translate (-display_tolerance_z) cylinder(h = height + 2 * display_tolerance, r = internal_radius, $fn = 50);
        translate ([internal_radius - 5, 0, 0] - display_tolerance_z) cube([external_radius - internal_radius + 10, 5, height + 2 * display_tolerance]);
    }
}
//-------------------------------------------------------------
module ring_with_clamp(external_radius, internal_radius, height)
{
    margin = 3;
    difference(){
        union(){
            translate ([-external_radius - margin, - external_radius - margin, 0]) cube([external_radius + 8 + margin + internal_radius, 2 * external_radius + 2 * margin, 8]);
            translate ([0, 0, 8]) cylinder(h = height, r = external_radius, $fn = 50);
        }
        // midle hole
        translate (-display_tolerance_z) cylinder(h = height + 8 + 2 * display_tolerance, r = internal_radius, $fn = 50);
        // screw hole
        translate ([internal_radius + 4, - external_radius - margin, 4] - display_tolerance_y) rotate ([-90, 0, 0]) cylinder (h = external_radius + 2 * external_radius + 2 * display_tolerance, r = 2, $fn = 20);
        // window
        cube([external_radius + 8 - (external_radius - internal_radius), 2, height + 8]);
    } 
}
//-------------------------------------------------------------
module ring_with_flanges(external_radius, internal_radius, height, flange_size = 1.5)
{
    
  difference(){
      union(){
        cylinder(h = height, r = external_radius, $fn = 50);
          // flanges
        cylinder(h = flange_size, r2 = external_radius, r1= external_radius + flange_size , $fn = 50);
        translate ([0, 0, height - flange_size])cylinder(h = flange_size, r1 = external_radius, r2= external_radius + flange_size , $fn = 50);
      }
    translate (-display_tolerance_z) cylinder(h = height + 2 * display_tolerance, r = internal_radius, $fn = 50);
  }
}
//-------------------------------------------------------------
module ring_with_flanges_and_rectangular_hole(external_radius, internal_edge_length, height)
{
  flange_size = 1.5;
  difference(){
    union(){
      cylinder(h = height, r = external_radius, $fn = 50);
          // flanges
      cylinder(h = flange_size, r2 = external_radius, r1= external_radius + flange_size , $fn = 50);
      translate ([0, 0, height - flange_size])cylinder(h = flange_size, r1 = external_radius, r2= external_radius + flange_size , $fn = 50);
    }
    translate ([-internal_edge_length / 2, -internal_edge_length / 2, 0]-display_tolerance_z) cube([internal_edge_length, internal_edge_length, height] + 2 * display_tolerance_z);
      // m3 screw hole
    translate ([0, 0, height / 2]) rotate([0, 90, 0]) cylinder (h = external_radius, r = 1.4, $fn = 30);  
    // m3 nut hole
    translate ([internal_edge_length / 2, 0, height / 2]) rotate([0, 90, 0]) cylinder (h = 2.5, r = m3_nut_radius, $fn = 6);  
  }
}
//-------------------------------------------------------------
module potentiometer_button()
{
  difference(){
    ring_with_flanges(10, 3.3, 8);
      translate ([-6.3, -0.5, 0]) cube([12.6, 1, 1]);
    translate ([-6.3, 0, 0] - display_tolerance_z) cylinder (r = 0.5, h = 10, $fn = 20);
    translate ([6.3, 0, 0] - display_tolerance_z) cylinder (r = 0.5, h = 10, $fn = 20);
  }
}
//-------------------------------------------------------------

//ring_with_flanges(7, 4, 7);

//ring_with_flanges(10, 6.6, 12);

//ring_with_flanges(7, 4, 8, 0);

//ring_with_flanges_and_rectangular_hole(10, 10.5, 9);

//potentiometer_button();

//ring_with_clamp(external_radius = 14.5, internal_radius = 12.5, height = 4);
//ring_with_clamp(external_radius = 17.5, internal_radius = 15, height = 4);
//ring(external_radius = 17.5, internal_radius = 15, height = 4);
//open_ring(external_radius = 17.5, internal_radius = 15, height = 12 + 6 + 3);
open_ring(external_radius = 15, internal_radius = 12.5, height = 12 + 6 + 3);

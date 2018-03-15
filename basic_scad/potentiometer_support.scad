// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_screws_nuts_washers.scad>
include <params_basic_components.scad>
include <tolerance.scad>

//---------------------------------------------------------------------------
module potentiometer_support(length, width, height, dist_to_hole = 10, hole_tolerance = 5, wall_thick = 2)
{
  difference(){
    cube([length, width, height]);
      
    translate ([2, wall_thick, 2])  cube([length, width - 2 * wall_thick, height + 1]);
    //translate ([wall_thick, wall_thick, -1])  cube([length, width - 2 * wall_thick, bottom_wall + 1]);
    translate ([2, 0, height] - display_tolerance_y)  rotate ([0, atan((height - 2) / (length - wall_thick)), 0]) cube([length + sqrt(length), width + 2 * display_tolerance, height + 1]);
    
      // potentiometer hole
    hull(){
       translate ([2 + dist_to_hole, width / 2, 0] - display_tolerance_z) cylinder (h = 5, r = 4.9, $fn = 40);
       translate ([2 + dist_to_hole + hole_tolerance, width / 2, 0] - display_tolerance_z) cylinder (h = 5, r = 4.9, $fn = 40);
    }
  }
}
//---------------------------------------------------------------------------
module potentiometer_support_squared(length, width, height, dist_to_hole = 8, hole_tolerance = 5, wall_thick = 2, pot_width = 16, stopper_shift = 0.9)
{
  difference(){
    union(){
      difference(){
        cube([length, width, height]);
        translate ([2, wall_thick, 2])  cube([length, width - 2 * wall_thick, height + 1]);
        translate ([2, 0, height] - display_tolerance_y)  rotate ([0, atan((height - 2) / (length - wall_thick)), 0]) cube([length + sqrt(length), width + 2 * display_tolerance, height + 1]);
      }
        // stopper for potentiometer
      translate ([0, width / 2 - pot_width / 2 - 2 - stopper_shift, 0]) cube([length, pot_width + 4, 4]);
    }
    // potentiometer slide hole
    translate ([2, width / 2 - pot_width / 2 - stopper_shift, 2]) cube([length, pot_width, height]);
      // potentiometer screw hole
    hull(){
       translate ([2 + dist_to_hole, width / 2, 0] - display_tolerance_z) cylinder (h = 5, r = 5, $fn = 40);
       translate ([2 + dist_to_hole + hole_tolerance, width / 2, 0] - display_tolerance_z) cylinder (h = 5, r = 5, $fn = 40);
    }
  }
}
//---------------------------------------------------------------------------
module potentiometer_support_with_screw_holes(length, width, height, dist_between_support_holes, dist_to_support_holes = 5)
{
    difference(){
      potentiometer_support(length, width, height);
        translate ([0, width / 2 - dist_between_support_holes / 2, 2 + dist_to_support_holes] - display_tolerance_x) rotate([0, 90, 0]) cylinder (h = 2 + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        translate ([0, width / 2 + dist_between_support_holes / 2, 2 + dist_to_support_holes] - display_tolerance_x) rotate([0, 90, 0]) cylinder (h = 2 + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
    }
}
//---------------------------------------------------------------------------
module potentiometer_support_squared_with_screw_holes(length, width, height, dist_between_support_holes, dist_to_support_holes = 5, stopper_shift = 0)
{
    difference(){
      potentiometer_support_squared(length, width, height, pot_width = 17.5, stopper_shift = 0.9);
        translate ([0, width / 2 - dist_between_support_holes / 2, 2 + dist_to_support_holes] - display_tolerance_x) rotate([0, 90, 0]) cylinder (h = 2 + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        translate ([0, width / 2 + dist_between_support_holes / 2, 2 + dist_to_support_holes] - display_tolerance_x) rotate([0, 90, 0]) cylinder (h = 2 + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
    }
}
//---------------------------------------------------------------------------
module rectangular_axis_slider(height, wall_thick = 3, hole_depth = 10.5, hole_width = 10.5)
{
    width = 2 * wall_thick + hole_width + 4;
    
            difference(){
              cube([height, width, hole_depth + 2 * wall_thick - 0.5]);
              translate([0, wall_thick, 3.5] - display_tolerance_x) cube([height + 2 * display_tolerance, hole_width, hole_depth]); 
              translate([height / 2 - 4, wall_thick, 3.5]) cube([8, hole_width, hole_depth + wall_thick] + display_tolerance_z); 
                
             // screw hole   
              translate([height / 2, width, wall_thick + hole_depth / 2]) rotate ([90, 0, 0]) cylinder (h = 10, r = m4_screw_radius, $fn = 20);
                // nut hole
                translate([height / 2, width - 3, wall_thick + hole_depth / 2]) rotate ([90, 30, 0]) cylinder (h = 10, r = m4_nut_radius, $fn = 6);
            }
}
//---------------------------------------------------------------------------
module rounded_axis_slider(height, wall_thick = 3, hole_radius = 6)
{
  width = 2 * wall_thick + 2 * hole_radius;
    
  difference(){
    cube([height, width, width]);
        // shaft hole
    translate([0, wall_thick + hole_radius, wall_thick + hole_radius] - display_tolerance_x) rotate ([0, 90, 0]) cylinder( h = height + 2 * display_tolerance, r = hole_radius, $fn = 40); 
                
    // screw hole   
    translate([height / 2, hole_radius, 0] - display_tolerance_z) cylinder (h = wall_thick + 2, r = m4_screw_radius, $fn = 20);
    // nut hole
      hull(){
    //translate([height / 2, width, 3]) rotate([0, 0, 30]) cylinder (h = m4_nut_thick, r = m4_nut_radius, $fn = 6);
    translate([height / 2, hole_radius, 2.5]) rotate([0, 0, 30]) cylinder (h = m4_nut_thick + 2, r = m4_nut_radius, $fn = 6);
      }
  }
}
//---------------------------------------------------------------------------
module potentiometer_support_on_rectangular_axis(length, width, potentiometer_height, box_height, vertical_distance_to_potentiometer = 0, _stopper_shift = -0.9)
{
    hole_depth = 11.5;
    hole_width = 10.5;
    union(){
        // potentiometer
      translate ([0, 0, vertical_distance_to_potentiometer]) potentiometer_support_squared(length, width, potentiometer_height, pot_width = 18, stopper_shift = _stopper_shift);
      // bone housing
      translate ([-(hole_depth + 6), 0, 0]) 
        difference(){
          cube([hole_depth + 8, width, box_height]);
          translate([6, 0, 2] - display_tolerance_y) cube([hole_depth, width + 2 * display_tolerance, hole_width]); 
          translate([6, 5, 2]) cube([hole_depth, width -10, 20]); 
                
          // screw hole
          translate([0, width / 2, 9] - display_tolerance_x) rotate ([0, 90, 0]) cylinder (h = 10, r = m4_screw_radius, $fn = 20);
          // nut hole
          translate([6 - m4_nut_thick, width / 2, 9] - display_tolerance_x) rotate ([0, 90, 0]) cylinder (h = 5, r = m4_nut_radius, $fn = 6);
        }
    }
}
//---------------------------------------------------------------------------
//potentiometer_support(length = 40, width = 20, height = 4, dist_to_hole = 10, hole_tolerance = 15, wall_thick = 2);

//potentiometer_support_with_screw_holes(25, 48, 13, 29);

//potentiometer_support_on_rectangular_axis(length = 25, width = 23.3, potentiometer_height = 4, box_height = 15, vertical_distance_to_potentiometer = 4, stopper_shift = -0.9);

//rectangular_axis_slider(20);

//rounded_axis_slider(height = 30, wall_thick = 3, hole_depth = 10.5, hole_width = 10.5);

//potentiometer_support(27, 28, 5, 10, 5, 3, 0);

//potentiometer_support_squared(length = 27, width = 28, height = 5, dist_to_hole = 10, hole_tolerance = 15, wall_thick = 3, pot_width = 16, stopper_shift = 0.0);

potentiometer_support_squared_with_screw_holes(length = 25, width = 48, height = 13, dist_between_support_holes = 30, dist_to_support_holes = 5, stopper_shift = 0);
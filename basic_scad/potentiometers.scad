include <params_screws_nuts_washers.scad>
include <params_basic_components.scad>


//---------------------------------------------------------------------------
module potentiometer_support(length, width, inaltime, dist_to_hole = 10, hole_tolerance = 5, wall_thick = 2, bottom_wall = 0)
{
  difference(){
    cube([length, width, inaltime + bottom_wall]);
    translate ([wall_thick, wall_thick, wall_thick + bottom_wall])  cube([length, width - 2 * wall_thick, inaltime + 1]);
    translate ([wall_thick, wall_thick, -1])  cube([length, width - 2 * wall_thick, bottom_wall + 1]);
    translate ([wall_thick, 0, inaltime + bottom_wall] - display_tolerance_y)  rotate ([0, atan((inaltime - wall_thick) / (length - wall_thick)), 0]) cube([length + sqrt(length), width + 2 * display_tolerance, inaltime + 1]);
            // gaura potentiometru
    hull(){
       translate ([wall_thick + dist_to_hole, width / 2, 0] - display_tolerance_z) cylinder (h = 5, r = 4.9, $fn = 40);
       translate ([wall_thick + dist_to_hole + hole_tolerance, width / 2, 0] - display_tolerance_z) cylinder (h = 5, r = 4.9, $fn = 40);
    }
  }
}
//---------------------------------------------------------------------------
module potentiometer_support_with_screw_holes(length, width, inaltime, dist_between_holes)
{
    difference(){
      potentiometer_support(length, width, inaltime);
        translate ([0, width / 2 - dist_between_holes / 2, 2 + (inaltime - 2) / 2] - display_tolerance_x) rotate([0, 90, 0]) cylinder (h = 2 + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
        translate ([0, width / 2 + dist_between_holes / 2, 2 + (inaltime - 2) / 2] - display_tolerance_x) rotate([0, 90, 0]) cylinder (h = 2 + 2 * display_tolerance, r = m4_screw_radius, $fn = 20);
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
                
             // gaura surub   
              translate([height / 2, width, wall_thick + hole_depth / 2]) rotate ([90, 0, 0]) cylinder (h = 10, r = m4_screw_radius, $fn = 20);
                translate([height / 2, width - 3, wall_thick + hole_depth / 2]) rotate ([90, 30, 0]) cylinder (h = 10, r = m4_nut_radius, $fn = 6);
            }
}
//---------------------------------------------------------------------------
module potentiometer_support_on_rectangular_axis(length, width, potentiometer_height, box_height, dist_to_pot = 0)
{
    hole_depth = 11.5;
    hole_width = 10.5;
    union(){
      translate ([0, 0, dist_to_pot]) potentiometer_support(length, width, potentiometer_height);
                  translate ([-(hole_depth + 6), 0, 0]) 
            difference(){
              cube([hole_depth + 8, width, box_height]);
              translate([6, 0, 2] - display_tolerance_y) cube([hole_depth, width + 2 * display_tolerance, hole_width]); 
             translate([6, 5, 2]) cube([hole_depth, width -10, 20]); 
                
             // gaura surub   
              translate([0, width / 2, 9] - display_tolerance_x) rotate ([0, 90, 0]) cylinder (h = 10, r = m4_screw_radius, $fn = 20);
                translate([6 - m4_nut_thick, width / 2, 9] - display_tolerance_x) rotate ([0, 90, 0]) cylinder (h = 5, r = m4_nut_radius, $fn = 6);
            }
        }
}
//---------------------------------------------------------------------------
//potentiometer_support(46, 35, 3, 50, 0, 3, 2);
//potentiometer_support_with_screw_holes(25, 48, 13, 29);

//potentiometer_support_on_rectangular_axis(27, 30, 4, 15, 2, 3);

rectangular_axis_slider(20);

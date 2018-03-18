// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------------------------------------------------------

include <params_basic_components.scad>
include <tolerance.scad>

//------------------------------------------------------------------------
module belt_arc(_r, start_angle, end_angle, belt_width = 6, belt_thick = 2)
{
    difference(){
        color("DarkKhaki") cylinder(r = _r + belt_thick, h = belt_width);
        translate (-display_tolerance_z) color("DarkKhaki") cylinder(r = _r, h = belt_width + 2 * display_tolerance);
    }
}
//------------------------------------------------------------------------
module belt_on_2_pulleys(r1, r2, distance_between_pulleys, belt_width = 6, belt_thick = 2)
{
    // r1 >= r2
    //cylinder ( h = belt_width, r = r1);
    
    //translate ([distance_between_pulleys, 0, 0]) cylinder ( h = belt_width, r = r2);
    
    angle = asin((r1 - r2) / distance_between_pulleys);
    belt_length = distance_between_pulleys * cos(angle);
    // belt between pulleys
    translate ([sin(angle) * r1, cos(angle) * r1, 0]) rotate ([0, 0, -angle]) color("DarkKhaki") cube([belt_length, belt_thick, belt_width]);
    translate ([sin(angle) * (r1 + belt_thick), cos(180 - angle) * (r1 + belt_thick), 0]) rotate ([0, 0, angle]) color("DarkKhaki") cube([belt_length, belt_thick, belt_width]);
    
    // belt around pulley
    belt_arc(r1, angle, 360 - angle, belt_width, belt_thick);
    translate ([distance_between_pulleys, 0, 0]) belt_arc(r2, 360 - angle, angle, belt_width, belt_thick);
}
//------------------------------------------------------------------------
function length_belt_on_2_pulleys(r1, r2, distance_between_pulleys) = PI * r1 + PI * r2 + 2 * sqrt(distance_between_pulleys * distance_between_pulleys + abs(r1-r2));
//------------------------------------------------------------------------
module belt_on_4_pulleys(r1, r2, r3, distance_to_tensioner_pulleys_x, distance_to_tensioner_pulleys_y, distance_between_traction_pulleys, belt_width = 6, belt_thick = 2)
{
    // r1 >= r2
    //cylinder ( h = belt_width, r = r1);
    
    //translate ([distance_between_pulleys, 0, 0]) cylinder ( h = belt_width, r = r2);
    
    angle1 = asin((r1 - (distance_to_tensioner_pulleys_y - r2)) / distance_to_tensioner_pulleys_x);
    belt_length1 = distance_to_tensioner_pulleys_x * cos(angle1);
    // belt between pulleys
    translate ([sin(angle1) * r1, cos(angle1) * r1, 0]) rotate ([0, 0, -angle1]) color("DarkKhaki") cube([belt_length1, belt_thick, belt_width]);
    translate ([sin(angle1) * (r1 + belt_thick), cos(180 - angle1) * (r1 + belt_thick), 0]) rotate ([0, 0, angle1]) color("DarkKhaki") cube([belt_length1, belt_thick, belt_width]);
    
    angle2 = asin((r3 - (distance_to_tensioner_pulleys_y - r2)) / (distance_between_traction_pulleys - distance_to_tensioner_pulleys_x));
    belt_length2 = (distance_between_traction_pulleys - distance_to_tensioner_pulleys_x) * cos(angle2);
    // belt between pulleys
    translate ([sin(angle2) * r1, cos(angle2) * r1, 0] + [distance_to_tensioner_pulleys_x, distance_to_tensioner_pulleys_y - r2, 0]) rotate ([0, 0, angle2]) color("DarkKhaki") cube([belt_length2, belt_thick, belt_width]);
    translate ([sin(angle2) * (r1 + belt_thick), cos(180 - angle2) * (r1 + belt_thick), 0] +  [distance_to_tensioner_pulleys_x, -distance_to_tensioner_pulleys_y + r2, 0]) rotate ([0, 0, -angle2]) color("DarkKhaki") cube([belt_length2, belt_thick, belt_width]);

    // belt around pulley
    belt_arc(r1, angle1, 360 - angle1, belt_width, belt_thick);
    translate ([distance_between_traction_pulleys, 0, 0]) belt_arc(r3, 360 - angle1, angle1, belt_width, belt_thick);
    // tensioner pulley
    translate ([distance_to_tensioner_pulleys_x, distance_to_tensioner_pulleys_y, 0]) belt_arc(r2, 360 - angle1, angle1, belt_width, belt_thick);
    translate ([distance_to_tensioner_pulleys_x, -distance_to_tensioner_pulleys_y, 0]) belt_arc(r2, 360 - angle1, angle1, belt_width, belt_thick);
}
//------------------------------------------------------------------------

//belt_on_2_pulleys(50, 20, 100, 5);

//echo (length_belt_on_2_pulleys(r1 = 50, r2 = 20, distance_between_pulleys = 100));

belt_on_4_pulleys(r1 = 6, r2 = 10, r3 = 70, distance_to_tensioner_pulleys_x = 100, distance_to_tensioner_pulleys_y = 30, distance_between_traction_pulleys = 200, belt_width = 6, belt_thick = 2);
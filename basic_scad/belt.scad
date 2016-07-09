include <params_basic_components.scad>

//------------------------------------------------------------------------
module belt_arc(_r, start_angle, end_angle, belt_width, belt_thick = 2)
{
    difference(){
        color("green")cylinder(r = _r + belt_thick, h = belt_width);
        translate (-display_tolerance_z) cylinder(r = _r, h = belt_width + 2 * display_tolerance);
    }
}
//------------------------------------------------------------------------
module belt_on_2_pulleys(r1, r2, distance_between_pulleys, belt_width, belt_thick = 2)
{
    // r1 >= r2
    //cylinder ( h = belt_width, r = r1);
    
    //translate ([distance_between_pulleys, 0, 0]) cylinder ( h = belt_width, r = r2);
    
    angle = asin((r1 - r2) / distance_between_pulleys);
    belt_length = distance_between_pulleys * cos(angle);
    // belt between pulleys
    translate ([sin(angle) * r1, cos(angle) * r1, 0]) rotate ([0, 0, -angle]) cube([belt_length, belt_thick, belt_width]);
    translate ([sin(angle) * (r1 + belt_thick), cos(180 - angle) * (r1 + belt_thick), 0]) rotate ([0, 0, angle]) cube([belt_length, belt_thick, belt_width]);
    
    // belt around pulley
    belt_arc(r1, angle, 360 - angle, belt_width, belt_thick);
    translate ([distance_between_pulleys, 0, 0]) belt_arc(r2, 360 - angle, angle, belt_width, belt_thick);
}
//------------------------------------------------------------------------
belt_on_2_pulleys(50, 20, 100, 5);
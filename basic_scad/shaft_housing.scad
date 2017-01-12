// Author: Mihai Oltean, www.tcreate.org, mihai.oltean@gmail.com
// More details: jenny5.org
// Source: github.com/jenny5-robot
// MIT License
//--------------

module shaft_housing(length, width, shaft_radius)
{
    difference(){
      cube([length, width, 2 * shaft_radius + 3]);
        // shaft hole
        hull(){
            translate ([0, width / 2, 0]) rotate([0, 90, 0]) cylinder(h = length, r = shaft_radius, $fn = 30);
            translate ([0, width / 2, shaft_radius - 0.2]) rotate([0, 90, 0]) cylinder(h = length, r = shaft_radius, $fn = 30);
        }
        
        // screw holes
        translate([8, width / 2 - 8, 0]) cylinder (h = 2 * shaft_radius + 3, r = 2, $fn = 20);
        translate([8, width / 2 + 8, 0]) cylinder (h = 2 * shaft_radius + 3, r = 2, $fn = 20);
        translate([length - 8, width / 2 - 8, 0]) cylinder (h = 2 * shaft_radius + 3, r = 2, $fn = 20);
        translate([length - 8, width / 2 + 8, 0]) cylinder (h = 2 * shaft_radius + 3, r = 2, $fn = 20);
        
        // head for sunken screw
        translate([8, width / 2 - 8, 2 * shaft_radius + 1]) cylinder (h = 2, r1 = 2, r2 = 4, $fn = 20);
        translate([8, width / 2 + 8, 2 * shaft_radius + 1]) cylinder (h = 2, r1 = 2, r2 = 4, $fn = 20);
        translate([length - 8, width / 2 - 8, 2 * shaft_radius + 1]) cylinder (h = 2, r1 = 2, r2 = 4, $fn = 20);
        translate([length - 8, width / 2 + 8, 2 * shaft_radius + 1]) cylinder (h = 2, r1 = 2, r2 = 4, $fn = 20);
        
    }
    
}

shaft_housing(length = 30, width = 30, shaft_radius = 3.9);